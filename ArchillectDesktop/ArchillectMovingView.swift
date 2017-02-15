//
//  ArchillectMovingView.swift
//  ArchillectDesktop
//
//  Created by Peter Hajas on 12/23/15.
//  Copyright © 2015 Peter Hajas. All rights reserved.
//

import AppKit

// This is an NSView that steals clicks to notify its window

protocol ArchillectMovingViewDelegate {
    func movingViewLocationShouldChangeByAmount(_ movingView: ArchillectMovingView, amount: CGVector)
}

class ArchillectMovingView : NSView {
    var lastMouseLocation: CGPoint = CGPoint.zero
    
    var currentMoveOffsetFromMouseDown: CGVector = CGVector.zero {
        didSet {
            if let ourDelegate = delegate {
                ourDelegate.movingViewLocationShouldChangeByAmount(self, amount: self.currentMoveOffsetFromMouseDown)
            }
        }
    }
    
    var delegate: ArchillectMovingViewDelegate?
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.wantsLayer = true
        self.autoresizingMask = [.viewWidthSizable, .viewHeightSizable]
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func mouseDown(with theEvent: NSEvent) {
        let location = NSEvent.mouseLocation()
        self.lastMouseLocation = location
        self.currentMoveOffsetFromMouseDown = CGVector.zero
    }
    
    override func mouseDragged(with theEvent: NSEvent) {
        let location = NSEvent.mouseLocation()
        let offset = CGVector(dx: location.x - self.lastMouseLocation.x,
                                  dy: location.y - self.lastMouseLocation.y)
        
        self.currentMoveOffsetFromMouseDown = offset
        
        self.lastMouseLocation = location
    }
    
    override func mouseUp(with theEvent: NSEvent) {
        let location = NSEvent.mouseLocation()
        self.lastMouseLocation = location
        self.currentMoveOffsetFromMouseDown = CGVector.zero
    }
    
    override func hitTest(_ aPoint: NSPoint) -> NSView? {
        if ((self.layer?.contains(aPoint)) != nil) {
            return self
        }
        else {
            return nil
        }
    }
}
