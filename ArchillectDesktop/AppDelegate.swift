//
//  AppDelegate.swift
//  ArchillectDesktop
//
//  Created by Peter Hajas on 12/23/15.
//  Copyright © 2015 Peter Hajas. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    let archillectWindow = ArchillectWindow()

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        archillectWindow.makeKeyAndOrderFront(nil)
    }
    
    @IBAction func goHome(_ sender: AnyObject) {
        archillectWindow.goHome()
    }
    
    @IBAction func goToArchillect(_ sender: AnyObject) {
        archillectWindow.goToArchillect()
    }
    
    @IBAction func goToRandomArchillect(_ sender: AnyObject) {
        archillectWindow.goToRandomArchillect()
    }
    
    @IBAction func toggleMusic(_ sender: AnyObject) {
        archillectWindow.toggleMusic()
    }
    
    @IBAction func toggleFullscreen(_ sender: AnyObject) {
        archillectWindow.toggleFullScreen(sender)
    }
}

