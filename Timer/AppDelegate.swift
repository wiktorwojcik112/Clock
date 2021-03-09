//
//  AppDelegate.swift
//  Timer
//
//  Created by Wiktor Wójcik on 12/10/2020.
//

import Cocoa
import UserNotifications

@main
class AppDelegate: NSObject, NSApplicationDelegate {
    let installedVersion = 8
    
    @IBAction func checkForNewVersion(_ sender: NSMenuItem) {
        
        if let url = URL(string: "https://wiktor.thedev.id/ClockVersion.txt") {
            do {
                let currentVersionString = try String(contentsOf: url)
                print(try String(contentsOf: url))
                
                let scanInteger = Scanner(string: currentVersionString)
                let currentVersion = scanInteger.scanInt()
                
                if (currentVersion! > installedVersion) {
                    let newVersion = NSAlert()
                    newVersion.messageText = "New version of Clock (" + String(currentVersion!) + ") is now available. Your current version is " + String(installedVersion) + "."
                    newVersion.addButton(withTitle: "Update")
                    newVersion.addButton(withTitle: "Cancel")
                    if (newVersion.runModal() == .alertFirstButtonReturn) {
                        NSWorkspace.shared.open(URL(string: "https://github.com/wiktorwojcik112/Clock/releases/download/latest/Clock.app.zip")!)
                    }
                } else {
                    let noNewVersion = NSAlert()
                    noNewVersion.messageText = "Clock is up-to-date."
                    noNewVersion.runModal()
                }

            } catch {
                let couldntAccesWebsite = NSAlert()
                couldntAccesWebsite.messageText = "App couldn't acces updates website. Check your network connection and try again. If error still persists, contact the developer."
                couldntAccesWebsite.addButton(withTitle: "Try again")
                couldntAccesWebsite.addButton(withTitle: "Cancel")
                if (couldntAccesWebsite.runModal() == .alertFirstButtonReturn) {
                    checkForNewVersion(NSMenuItem())
                }
                
            }
        } else {
            let couldntAccesWebsite = NSAlert()
            couldntAccesWebsite.messageText = "Updates website's url is wrong. Please, contact the developer."
            couldntAccesWebsite.runModal()
        }
    
    }

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        if let url = URL(string: "https://wiktor.thedev.id/ClockVersion.txt") {
            do {
                let currentVersionString = try String(contentsOf: url)
                print(try String(contentsOf: url))
                
                let scanInteger = Scanner(string: currentVersionString)
                let currentVersion = scanInteger.scanInt()
                
                if (currentVersion! > installedVersion) {
                    
                    let center = UNUserNotificationCenter.current()
                    center.requestAuthorization(options: [.provisional]) { granted, error in
                        
                        if let error = error {
                        }
                    }
                    
                    let notification = UNMutableNotificationContent()
                    notification.title = "New version available."
                    notification.body = "New version of Clock (" + String(currentVersion!) + ") is now available. Your current version is " + String(installedVersion) + "."
                    
                    var components = DateComponents()
                    components.calendar = Calendar.current
                    
                    let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
                    
                    let uuidString = UUID().uuidString
                    let request = UNNotificationRequest(identifier: uuidString,
                                content: notification, trigger: trigger)

                    let notificationCenter = UNUserNotificationCenter.current()
                    notificationCenter.add(request) { (error) in
                       if error != nil {
                       }
                    }
                }
            } catch {

            }
                
            
        }
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
}
}





