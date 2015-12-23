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
    
    let movingView: ArchillectMovingView
    let webView: WKWebView
    
    func goToArchillectURLWithSuffix(suffix: String) {
        let request = archillectURLRequestWithSuffix(suffix)
        webView.loadRequest(request)
    }
    
    func goHome() {
        goToArchillectURLWithSuffix("TV")
    }
    
    func goToArchillect() {
        let goToAlert = NSAlert()
        goToAlert.messageText = "Enter Archillect Number:"
        goToAlert.addButtonWithTitle("Go")
        goToAlert.addButtonWithTitle("Cancel")
        
        let archillectTextField = NSTextField(frame: NSMakeRect(0,0,100,45))
        archillectTextField.editable = true
        archillectTextField.font = NSFont(name: "Menlo", size: 24)
        archillectTextField.placeholderString = "12345"
        
        goToAlert.accessoryView = archillectTextField
        
        goToAlert.beginSheetModalForWindow(self) { (response: NSModalResponse) -> Void in
            if response == 1000 {
                // Go was pushed
                
                let archillectNumber = archillectTextField.stringValue
                self.goToArchillectURLWithSuffix(archillectNumber)
            }
            else {
                // Cancel was pushed
            }
        }
    }
    
    func toggleMusic() {
        
    }
    
    func movingViewLocationShouldChangeByAmount(movingView: ArchillectMovingView, amount: CGVector) {
        var windowFrame = self.frame
        windowFrame.offsetInPlace(dx: amount.dx, dy: amount.dy)
        self.setFrame(windowFrame, display: true)
    }
    
    func archillectURLWithSuffix(suffix: String) -> NSURL {
        let baseURL: NSString = "http://archillect.com"
        
        let urlString = (baseURL as String) + "/" + suffix
        
        let url = NSURL(string: urlString)!
        
        return url
    }
    
    func archillectURLRequestWithSuffix(suffix: String) -> NSURLRequest {
        let url = archillectURLWithSuffix(suffix)
        
        let urlRequest = NSURLRequest(URL: url)
        
        return urlRequest
    }
    
    init() {
        let frame = CGRectMake(0, 0, defaultContentDimension, defaultContentDimension)
        
        webView = WKWebView(frame: frame)
        webView.autoresizingMask = [.ViewWidthSizable, .ViewHeightSizable]
        
        movingView = ArchillectMovingView(frame: frame)
        movingView.addSubview(webView)

        super.init(contentRect: NSMakeRect(defaultContentRectOffset, defaultContentRectOffset, defaultContentDimension, defaultContentDimension), styleMask: defaultStyleMask, backing: .Retained, `defer`: false)
        
        movingView.delegate = self
        
        self.contentView = movingView
        
        goHome()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}