//
//  SKYWebView.m
//  GoBackWebView
//
//  Created by sky on 2020/5/15.
//  Copyright © 2020 www.demo.com. All rights reserved.
//

#import "SKYWebView.h"

@interface SKYWebView ()
//当前页面防止多次判断
@property(nonatomic, copy)NSString *decidedUrl;

@end

@implementation SKYWebView

- (instancetype)init {
    if (self = [super init]) {
    }
    return self;
}

#pragma mark - Action
- (void)openGoBackRecognizer {
    [self switchBackForwardRecognizerWithDirection:UIRectEdgeLeft enable:YES];
}

- (void)openForwarRecognizer {
    [self switchBackForwardRecognizerWithDirection:UIRectEdgeRight enable:YES];
}

- (void)closeForwardRecognizer {
    [self switchBackForwardRecognizerWithDirection:UIRectEdgeRight enable:NO];
}

- (void)closeGoBackRecognizer {
    [self switchBackForwardRecognizerWithDirection:UIRectEdgeLeft enable:NO];
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    [self configGoBackEnable];//同一页面点击会多次触发
    return [super pointInside:point withEvent:event];
}

- (void)configGoBackEnable {
    if (!_refuseGoBackUrls) {
        return;
    }
    NSString *absoluteString = self.URL.absoluteString;
    if (_decidedUrl && [absoluteString isEqualToString:_decidedUrl]) {
        return;
    }
    
    BOOL isRefuse = NO;
    
    for(int i = 0; i < _refuseGoBackUrls.count; i ++) {
        NSString *url = _refuseGoBackUrls[i];
        if ([absoluteString containsString:url]) {
            isRefuse = YES;
            break;
        }
    }
    
    [self switchBackForwardRecognizerWithDirection:UIRectEdgeLeft enable:!isRefuse];
    _decidedUrl = absoluteString;
}

- (void)switchBackForwardRecognizerWithDirection:(UIRectEdge)direction enable:(BOOL)enable {
    if (!self.allowsBackForwardNavigationGestures) {
        return;
    }
    id obj = [self valueForKey:@"_gestureRecognizers"];
    if (obj && [obj isKindOfClass:[NSArray class]]) {
        NSArray *gestures = obj;
        for (int i = 0; i < gestures.count; i ++) {
            UIScreenEdgePanGestureRecognizer *edgePanGesture = gestures[i];
            if ([edgePanGesture isKindOfClass:[UIScreenEdgePanGestureRecognizer class]]) {
                if ((edgePanGesture.edges == direction) && (edgePanGesture.enabled != enable)) {
                    edgePanGesture.enabled = enable;
                    break;
                }
            }
        }
    }
}

@end
