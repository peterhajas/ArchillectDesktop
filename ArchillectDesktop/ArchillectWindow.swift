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
    let defaultStyleMask = NSTitledWindowMask | NSClosableWindowMask | NSMiniaturizableWindowMask | NSResizableWindowMask
    
    let movingView: ArchillectMovingView
    let webView: WKWebView
        
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
    
    func archillectTVURLRequest() -> NSURLRequest {
        return archillectURLRequestWithSuffix("tv")
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
        let request = archillectTVURLRequest()
        webView.loadRequest(request)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}