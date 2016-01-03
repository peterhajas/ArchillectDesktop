//
//  ArchillectWindow.swift
//  ArchillectDesktop
//
//  Created by Peter Hajas on 12/23/15.
//  Copyright © 2015 Peter Hajas. All rights reserved.
//

import AppKit
import WebKit

class ArchillectWindow : NSWindow, ArchillectMovingViewDelegate {
    let defaultContentDimension: CGFloat = 500
    let defaultContentRectOffset: CGFloat = 10
    let defaultStyleMask = NSBorderlessWindowMask | NSResizableWindowMask
    let archillectContentView: ArchillectContentView
    
    func goHome() {
        archillectContentView.goHome()
    }
    
    func goToRandomArchillect() {
        archillectContentView.goToRandomArchillect()
    }
    
    func toggleMusic() {
        archillectContentView.toggleMusic()
    }
    
    func goToArchillect() {
        let goToAlert = NSAlert()
        goToAlert.messageText = "Enter Archillect Number:"
        goToAlert.addButtonWithTitle("Go")
        goToAlert.addButtonWithTitle("Cancel")
        
        let archillectTextField = NSTextField(frame: NSMakeRect(0,0,100,45))
        archillectTextField.editable = true
        archillectTextField.font = NSFont(name: "Menlo", size: 24)
        archillectTextField.placeholderString = "43061"
        
        goToAlert.accessoryView = archillectTextField
        
        goToAlert.beginSheetModalForWindow(self) { (response: NSModalResponse) -> Void in
            if response == 1000 {
                // Go was pushed
                
                let archillectNumber = archillectTextField.stringValue
                self.archillectContentView.goToArchillectURLWithSuffix(archillectNumber)
            }
            else {
                // Cancel was pushed
            }
        }
    }
    
    func movingViewLocationShouldChangeByAmount(movingView: ArchillectMovingView, amount: CGVector) {
        var windowFrame = self.frame
        windowFrame.offsetInPlace(dx: amount.dx, dy: amount.dy)
        self.setFrame(windowFrame, display: true)
    }
    
    init() {
        let frame = CGRectMake(0, 0, defaultContentDimension, defaultContentDimension)
        
        archillectContentView = ArchillectContentView(frame: frame)
        
        super.init(contentRect: NSMakeRect(defaultContentRectOffset, defaultContentRectOffset, defaultContentDimension, defaultContentDimension), styleMask: defaultStyleMask, backing: .Retained, `defer`: false)
        
        archillectContentView.movementDelegate = self
        
        self.contentView = archillectContentView
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}