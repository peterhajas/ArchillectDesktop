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

    func applicationDidFinishLaunching(aNotification: NSNotification) {
        archillectWindow.makeKeyAndOrderFront(nil)
    }
    
    @IBAction func goHome(sender: AnyObject) {
        archillectWindow.goHome()
    }
    
    @IBAction func goToArchillect(sender: AnyObject) {
        archillectWindow.goToArchillect()
    }
    
    @IBAction func goToRandomArchillect(sender: AnyObject) {
        archillectWindow.goToRandomArchillect()
    }
    
    @IBAction func toggleMusic(sender: AnyObject) {
        archillectWindow.toggleMusic()
    }
}

