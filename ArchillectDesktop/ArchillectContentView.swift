//
//  ArchillectContentView.swift
//  ArchillectDesktop
//
//  Created by Peter Hajas on 1/2/16.
//  Copyright © 2016 Peter Hajas. All rights reserved.
//

import AppKit
import WebKit

class ArchillectContentView : NSView {
    let movingView: ArchillectMovingView
    let webViewConfiguration = WKWebViewConfiguration()
    let userContentController = WKUserContentController()
    let webView: WKWebView
    
    let imageFillBoundsScript = WKUserScript(source:"document.getElementById(\"ii\").style.width = \'100%\'", injectionTime: .atDocumentEnd, forMainFrameOnly: false)
    let hideCommentsScript = WKUserScript(source: "document.getElementById(\"disqus_thread\").remove()", injectionTime: .atDocumentEnd, forMainFrameOnly: false)
    
    var movementDelegate: ArchillectMovingViewDelegate? {
        get {
            return movingView.delegate
        }
        set(delegate) {
            movingView.delegate = delegate
        }
    }
    
    func goToArchillectURLWithSuffix(_ suffix: String) {
        let request = archillectURLRequestWithSuffix(suffix)
        webView.load(request)
    }
    
    func goHome() {
        goToArchillectURLWithSuffix("TV")
    }
    
    func archillectURLWithSuffix(_ suffix: String) -> URL {
        let baseURL: NSString = "http://archillect.com"
        
        let urlString = (baseURL as String) + "/" + suffix
        
        let url = URL(string: urlString)!
        
        return url
    }
    
    func archillectURLRequestWithSuffix(_ suffix: String) -> URLRequest {
        let url = archillectURLWithSuffix(suffix)
        
        let urlRequest = URLRequest(url: url)
        
        return urlRequest
    }
    
    func randomArchillectNumber() -> Int {
        let maximum: Int = 40000
        
        let random = Int(arc4random_uniform(UInt32(maximum)) + 1)
        
        return random
    }
    
    func goToRandomArchillect() {
        let randomNumber = randomArchillectNumber()
        let randomSuffix = "\(randomNumber)"
        
        self.goToArchillectURLWithSuffix(randomSuffix)
    }
    
    func toggleMusic() {
        let playPauseScriptString = "document.getElementById(\"playpause\").click()"
        
        webView.evaluateJavaScript(playPauseScriptString, completionHandler: nil)
    }
    
    override init(frame: CGRect) {
        webViewConfiguration.userContentController = userContentController
        userContentController.addUserScript(imageFillBoundsScript)
        userContentController.addUserScript(hideCommentsScript)
        
        webView = WKWebView(frame: frame, configuration: webViewConfiguration)
        webView.autoresizingMask = [.viewWidthSizable, .viewHeightSizable]
        
        movingView = ArchillectMovingView(frame: frame)

        super.init(frame: frame)
        self.wantsLayer = true
        self.autoresizingMask = [.viewWidthSizable, .viewHeightSizable]
        
        self.addSubview(webView)
        self.addSubview(movingView)
        
        goHome()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
