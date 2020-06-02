//
//  SKYWebView.swift
//  WebViewDemo
//
//  Created by 杨涛 on 2020/5/28.
//  Copyright © 2020 www.demo.com. All rights reserved.
//

import UIKit
import WebKit

 @objcMembers class CustomWebView: WKWebView {
   
    open var refuseGoBackUrls: Array<String>?;
    
    open func openGoBackRecognizer() {
        self.switchBackForwardRecognizer(direction: UIRectEdge.left, enable: true);
    }
    
    open func openForwarRecognizer() {
        self.switchBackForwardRecognizer(direction: UIRectEdge.right, enable: true);
    }
    
    open func closeGoBackRecognizer() {
        self.switchBackForwardRecognizer(direction: UIRectEdge.left, enable: false);
    }
    
    open func closeForwardRecognizer() {
        self.switchBackForwardRecognizer(direction: UIRectEdge.right, enable: false);
    }
    
    open func isCanGoBack() -> Bool {
        return self.backForwardEnableRecognizer(UIRectEdge.left);
    }
    
    open func isCanForward() -> Bool {
         return self.backForwardEnableRecognizer(UIRectEdge.right);
    }
    
    fileprivate func switchBackForwardRecognizer(direction: UIRectEdge, enable: Bool) {
        if !self.allowsBackForwardNavigationGestures {
            return;
        }
        
        let obj = self.value(forKey: "_gestureRecognizers");
        if let gestures = obj  {
            let items = gestures as? Array<UIScreenEdgePanGestureRecognizer>;
            if let edgePanGestures = items  {
                for edgePanGesture in edgePanGestures {
                    if direction == edgePanGesture.edges && edgePanGesture.isEnabled != enable {
                        edgePanGesture.isEnabled = enable;
                        break;
                    }
                }
            }
        }
    }
    
    fileprivate func backForwardEnableRecognizer(_ direction: UIRectEdge) -> Bool {
        if !self.allowsBackForwardNavigationGestures {
            return false;
        }
        let obj = self.value(forKey: "_gestureRecognizers");
        if let gestures = obj  {
            let items = gestures as? Array<UIScreenEdgePanGestureRecognizer>;
            if let edgePanGestures = items  {
                for edgePanGesture in edgePanGestures {
                    if direction == edgePanGesture.edges  {
                        return edgePanGesture.isEnabled;
                    }
                }
            }
        }
        return false;
    }
    


    

}
