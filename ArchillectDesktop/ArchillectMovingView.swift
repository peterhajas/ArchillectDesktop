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
    func movingViewLocationShouldChangeByAmount(movingView: ArchillectMovingView, amount: CGVector)
}

class ArchillectMovingView : NSView {
    var lastMouseLocation: CGPoint = CGPointZero
    
    var _currentMoveOffsetFromMouseDown: CGVector = CGVector.zero
    var currentMoveOffsetFromMouseDown: CGVector {
        get {
            return _currentMoveOffsetFromMouseDown
        }
        set (offset) {
            _currentMoveOffsetFromMouseDown = offset
            
            if let ourDelegate = delegate {
                ourDelegate.movingViewLocationShouldChangeByAmount(self, amount: offset)
            }
        }
    }
    
    var delegate: ArchillectMovingViewDelegate?
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.wantsLayer = true
        self.autoresizingMask = [.ViewWidthSizable, .ViewHeightSizable]
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func mouseDown(theEvent: NSEvent) {
        let location = NSEvent.mouseLocation()
        self.lastMouseLocation = location
        self.currentMoveOffsetFromMouseDown = CGVector.zero
    }
    
    override func mouseDragged(theEvent: NSEvent) {
        let location = NSEvent.mouseLocation()
        let offset = CGVectorMake(location.x - self.lastMouseLocation.x,
                                  location.y - self.lastMouseLocation.y)
        
        self.currentMoveOffsetFromMouseDown = offset
        
        self.lastMouseLocation = location
    }
    
    override func mouseUp(theEvent: NSEvent) {
        let location = NSEvent.mouseLocation()
        self.lastMouseLocation = location
        self.currentMoveOffsetFromMouseDown = CGVector.zero
    }
    
    override func hitTest(aPoint: NSPoint) -> NSView? {
        if ((self.layer?.containsPoint(aPoint)) != nil) {
            return self
        }
        else {
            return nil
        }
    }
}
