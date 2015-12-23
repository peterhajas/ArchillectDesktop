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

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }


}

