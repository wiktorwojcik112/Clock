//
//  StoperController.swift
//  Clock
//
//  Created by Wiktor Wójcik on 22/11/2020.
//

import Cocoa

class TimerController: NSViewController {
    
    @IBOutlet var tfSeconds: NSTextField!
    @IBOutlet var tfMinutes: NSTextField!
    
    @IBOutlet var stTime: NSStepper!
    @IBOutlet var Countdown: NSTextField!
    @IBOutlet var actionButton: NSButton!
    
    @IBOutlet var btnActionBorder: NSBox!
    @IBOutlet var btnActionFill: NSBox!
    
    var time = 1
    var endrun = 0
    
    var isActive = false;
    
    @IBAction func changeMinutes(_ sender: NSTextField) {
        actionButton.title = "Start"
        endrun = 1
        Countdown.stringValue = "0:00"
        
        
        time = (tfMinutes.integerValue * 60) + tfSeconds.integerValue
        stTime.integerValue = time
    }
    
    @IBAction func changeSeconds(_ sender: NSTextField) {
        
        if (tfSeconds.stringValue.contains(" ") || tfSeconds.stringValue == "0") {
            tfSeconds.stringValue = "1"
            
        } else {
        actionButton.title = "Start"
        endrun = 1
        Countdown.stringValue = "0:00"
        
        var minutes = 0
        var seconds = 0
        
        var strSeconds = ""
        
            seconds = tfSeconds.integerValue
            time = seconds
        
        if (time >= 60) {
            minutes = time / 60
            
            let temp = minutes * 60
            seconds = time - temp
            
            tfMinutes.stringValue = String(minutes)
        }

        
        if (seconds < 10) {
            strSeconds = "0" + String(seconds)
        } else {
            strSeconds = String(seconds)
        }
        
        tfSeconds.stringValue = strSeconds
        
        time = (tfMinutes.integerValue * 60) + tfSeconds.integerValue
        stTime.integerValue = time
        }
    }
 

    
    @IBAction func stTime(_ sender: NSStepper) {
        
        actionButton.title = "Start"
        endrun = 1
        Countdown.stringValue = "0:00"
        
        var minutes = 0
        var seconds = 0
        
        var strSeconds = ""
        
        seconds = time
        
        if (time >= 60) {
            minutes = time / 60
            
            let temp = minutes * 60
            seconds = time - temp
        }

        
        if (seconds < 10) {
            strSeconds = "0" + String(seconds)
        } else {
            strSeconds = String(seconds)
        }
        
        tfSeconds.stringValue = strSeconds
        tfMinutes.stringValue = String(minutes)
        
        time = stTime.integerValue
    }
    @IBAction func action(_ sender: NSButton) {
        
        if (isActive) {
            endrun = 1
            actionButton.title = "Start"
            btnActionFill.fillColor = NSColor(named: "GreenStart")!
            btnActionBorder.borderColor = NSColor(named: "GreenStart")!
        } else {
            btnActionFill.fillColor = NSColor(named: "RedStop")!
            btnActionBorder.borderColor = NSColor(named: "RedStop")!
            actionButton.title = "Stop"
            isActive = true
        endrun = 0
            var timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [self] timer in
            
            if (endrun == 1) {
                    timer.invalidate()
                    Countdown.stringValue = "0:00"
                }
            
            
            var minutes = 0
            var seconds = 0
            
            var strSeconds = ""
            
            time = time - 1
            seconds = time
            
            if (time >= 60) {
                minutes = time / 60
                
                let temp = minutes * 60
                seconds = time - temp
            }

            
            if (seconds < 10) {
                strSeconds = "0" + String(seconds)
            } else {
                strSeconds = String(seconds)
            }
            
            
            if (endrun == 1) {
                    timer.invalidate()
                    Countdown.stringValue = "0:00"
                }
            
            Countdown.stringValue = String(minutes)  + ":" + strSeconds
            
            
            if (endrun == 1) {
                    timer.invalidate()
                    Countdown.stringValue = "0:00"
                }
            
            if (time <= 0) {
                actionButton.title = "Start"
                btnActionFill.fillColor = NSColor(named: "GreenStart")!
                btnActionBorder.borderColor = NSColor(named: "GreenStart")!
                endrun = 1
                isActive = false
                Countdown.stringValue = "0:00"
                time = 0
                timer.invalidate()
                
                let storyboard = NSStoryboard(name: "Main", bundle: nil)
                let alert = storyboard.instantiateController(withIdentifier: "Alert")
                
                self.presentAsSheet(alert as! NSViewController)
            }
        }
            
        }
        
    }
    
    @IBAction func deactivate(_ sender: NSButton) {
        actionButton.title = "Start"
        btnActionFill.fillColor = NSColor(named: "GreenStart")!
        btnActionBorder.borderColor = NSColor(named: "GreenStart")!
        endrun = 1
        isActive = false
        Countdown.stringValue = "0:00"
        time = 0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
}
