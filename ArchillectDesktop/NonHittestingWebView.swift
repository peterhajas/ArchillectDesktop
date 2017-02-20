//
//  NonHittestingWebView.swift
//  ArchillectDesktop
//
//  Created by Peter Hajas on 2/19/17.
//  Copyright © 2017 Peter Hajas. All rights reserved.
//

import WebKit

class NonHittestingWebView : WKWebView {
    override func hitTest(_ point: NSPoint) -> NSView? {
        return nil
    }
    
    override var mouseDownCanMoveWindow: Bool {
        return true
    }
}
