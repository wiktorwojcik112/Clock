//
//  ViewController.swift
//  Timer
//
//  Created by Wiktor Wójcik on 12/10/2020.
//

import Cocoa

class StopwatchController: NSViewController {
    @IBOutlet var timerLabel: NSTextField!
    @IBOutlet var actionButton: NSButton!
    
    @IBOutlet var btnActionBorder: NSBox!
    @IBOutlet var btnActionFill: NSBox!
    
    var referenceDate = Date()
    var time = 0.0
    var endrun = 0
    var timer = Timer()
    var wasStopped = false
    var isActive = false;
    
    @IBAction func activate(_ sender: NSButton) {
        if (isActive) {
            endrun = 1
            timer.invalidate()
            actionButton.title = "Start"
            isActive = false
            wasStopped = true
            btnActionBorder.fillColor = NSColor(named: "GreenStart")!
            btnActionFill.borderColor = NSColor(named: "GreenStart")!
        } else {
            if (!timer.isValid) {
                btnActionBorder.fillColor = NSColor(named: "RedStop")!
                btnActionFill.borderColor = NSColor(named: "RedStop")!
                actionButton.title = "Stop"
                isActive = true
                endrun = 0
                
            if (!wasStopped) {
                referenceDate = NSDate.now
            }
                
                timer = Timer.scheduledTimer(withTimeInterval: 0.0001, repeats: true) { [self] timer in
            
                    var minutes = 0
                    var seconds = 0
                    var ms = 0
            
                    if endrun == 1 {
                        timer.invalidate()
                    }
            
                    var strSeconds = ""
                    var strMs = ""
                
                    let now = NSDate.now
                
                    time = referenceDate.distance(to: now) * 100
                    ms = Int(time)
            
                if (time >= 100) {
                    seconds = Int(time) / 100
                
                    let temp = seconds * 100
                    ms = Int(time) - temp
                }
                
                if (seconds >= 60) {
                    minutes = seconds / 60
                    
                    let temp = minutes * 60
                    seconds = seconds - temp
                }
            
            
            if (seconds < 10) {
                strSeconds = "0" + String(seconds)
            } else {
                strSeconds = String(seconds)
            }
                
            if (ms < 10) {
                strMs = "0" + String(ms)
            } else {
                strMs = String(ms)
            }
            
            timerLabel.stringValue = String(minutes)  + ":" + strSeconds + "," + strMs
                    
        }

        }
        }
    }
    
    @IBAction func deleteTimer(_ sender: NSButton) {
        btnActionBorder.fillColor = NSColor(named: "GreenStart")!
        btnActionFill.borderColor = NSColor(named: "GreenStart")!
        actionButton.title = "Start"
        timer.invalidate()
        timerLabel.stringValue = "0:00,00"
        time = 0
        endrun = 0
        wasStopped = false
    }
    
override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

