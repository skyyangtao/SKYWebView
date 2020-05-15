//
//  SKYWebView.h
//  GoBackWebView
//
//  Created by sky on 2020/5/15.
//  Copyright © 2020 www.demo.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

//allowsBackForwardNavigationGestures为YES goback forward才会有用

@interface SKYWebView : WKWebView

@property(nonatomic, strong)NSArray *refuseGoBackUrls;//根据业务需求某些页面不能返回

- (void)openGoBackRecognizer;

- (void)openForwarRecognizer;

- (void)closeForwardRecognizer;

- (void)closeGoBackRecognizer;

@end


