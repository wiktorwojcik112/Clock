//
//  AlertController.swift
//  Clock
//
//  Created by Wiktor Wójcik on 03/12/2020.
//

import Cocoa

class AlertController: NSViewController {
    var timeHasEnded = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false) { [self] timer in }
    
    @IBAction func OK(_ sender: NSButton) {
        timeHasEnded.invalidate()
        self.dismiss(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timeHasEnded = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] timer in
            NSSound.beep()
        }
    }
    
}
