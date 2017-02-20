//
//  ArchillectWindow.swift
//  ArchillectDesktop
//
//  Created by Peter Hajas on 12/23/15.
//  Copyright © 2015 Peter Hajas. All rights reserved.
//

import AppKit
import WebKit

class ArchillectWindow : NSWindow {
    let defaultContentDimension: CGFloat = 500
    let defaultContentRectOffset: CGFloat = 10
    let defaultStyleMask: NSWindowStyleMask = [.borderless, .resizable, .fullSizeContentView]
    let windowCollectionBehavior: NSWindowCollectionBehavior = [.fullScreenPrimary, .fullScreenAllowsTiling]
    let archillectContentView: ArchillectContentView
    
    func goHome() {
        archillectContentView.goHome()
    }
    
    func goToRandomArchillect() {
        archillectContentView.goToRandomArchillect()
    }
    
    func goToArchillect() {
        let goToAlert = NSAlert()
        goToAlert.messageText = "Enter Archillect Number:"
        goToAlert.addButton(withTitle: "Go")
        goToAlert.addButton(withTitle: "Cancel")
        
        let archillectTextField = NSTextField(frame: NSMakeRect(0,0,100,45))
        archillectTextField.isEditable = true
        archillectTextField.font = NSFont(name: "Menlo", size: 24)
        archillectTextField.placeholderString = "43061"
        
        goToAlert.accessoryView = archillectTextField
        
        goToAlert.beginSheetModal(for: self, completionHandler: { (response: NSModalResponse) -> Void in
            if response == 1000 {
                // Go was pushed
                
                let archillectNumber = archillectTextField.stringValue
                self.archillectContentView.goToArchillectURLWithSuffix(archillectNumber)
            }
            else {
                // Cancel was pushed
            }
        }) 
    }
    
    init() {
        let frame = CGRect(x: 0, y: 0, width: defaultContentDimension, height: defaultContentDimension)
        
        archillectContentView = ArchillectContentView(frame: frame)
        
        super.init(contentRect: NSMakeRect(defaultContentRectOffset, defaultContentRectOffset, defaultContentDimension, defaultContentDimension), styleMask: defaultStyleMask, backing: .retained, defer: false)
        self.collectionBehavior = windowCollectionBehavior
        
        self.contentView = archillectContentView
        
        isMovableByWindowBackground = true
    }
}
