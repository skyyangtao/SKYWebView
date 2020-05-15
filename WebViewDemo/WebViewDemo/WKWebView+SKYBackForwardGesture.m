
#import "WKWebView+SKYBackForwardGesture.h"
#import <objc/runtime.h>



@implementation WKWebView (SKYBackForwardGesture)

- (void)setSky_goBackRecognizerEnabled:(BOOL)sky_goBackRecognizerEnabled {
    if (sky_goBackRecognizerEnabled && !self.allowsBackForwardNavigationGestures) {
        self.allowsBackForwardNavigationGestures = YES;
    }
    [self sky_switchBackForwardRecognizerWithDirection:UIRectEdgeLeft enable:sky_goBackRecognizerEnabled];
    objc_setAssociatedObject(self, @selector(sky_goBackRecognizerEnabled), @(sky_goBackRecognizerEnabled), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (BOOL)sky_goBackRecognizerEnabled {
    id obj = objc_getAssociatedObject(self, @selector(sky_goBackRecognizerEnabled));
    BOOL enabled = obj ? [obj boolValue] : NO;
    return enabled && self.allowsBackForwardNavigationGestures;
}

- (void)setSky_forwardRecognizerEnabled:(BOOL)sky_forwardRecognizerEnabled {
    if (sky_forwardRecognizerEnabled && !self.allowsBackForwardNavigationGestures) {
        self.allowsBackForwardNavigationGestures = YES;
    }
    [self sky_switchBackForwardRecognizerWithDirection:UIRectEdgeRight enable:sky_forwardRecognizerEnabled];
    objc_setAssociatedObject(self, @selector(sky_forwardRecognizerEnabled), @(sky_forwardRecognizerEnabled), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}
- (BOOL)sky_forwardRecognizerEnabled {
    id obj = objc_getAssociatedObject(self, @selector(sky_forwardRecognizerEnabled));
    BOOL enabled = obj ? [obj boolValue] : NO;
    return enabled && self.allowsBackForwardNavigationGestures;
}

- (void)setSky_refuseGoBackUrls:(NSArray *)sky_refuseGoBackUrls {
    objc_setAssociatedObject(self, @selector(sky_refuseGoBackUrls), sky_refuseGoBackUrls, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSArray *)sky_refuseGoBackUrls {
    return objc_getAssociatedObject(self, @selector(sky_refuseGoBackUrls));
}

- (void)setSky_DecidedUrl:(NSString *)sky_DecidedUrl {
    objc_setAssociatedObject(self, @selector(sky_DecidedUrl), sky_DecidedUrl, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)sky_DecidedUrl {
    return objc_getAssociatedObject(self, @selector(sky_DecidedUrl));
}

#pragma mark - Action
- (void)sky_openGoBackRecognizer {
    [self sky_switchBackForwardRecognizerWithDirection:UIRectEdgeLeft enable:YES];
}

- (void)sky_openForwarRecognizer {
    [self sky_switchBackForwardRecognizerWithDirection:UIRectEdgeRight enable:YES];
}

- (void)sky_closeForwardRecognizer {
    [self sky_switchBackForwardRecognizerWithDirection:UIRectEdgeRight enable:NO];
}

- (void)sky_closeGoBackRecognizer {
    [self sky_switchBackForwardRecognizerWithDirection:UIRectEdgeLeft enable:NO];
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    [self sky_configGoBackEnable];//同一页面点击会多次触发
    NSLog(@"%@", self.URL);
    return [super pointInside:point withEvent:event];
}

- (void)sky_configGoBackEnable {
    NSArray *refuseGoBackUrls = [self sky_refuseGoBackUrls];
    if (!refuseGoBackUrls) {
        return;
    }
    NSString *decidedUrl = [self sky_DecidedUrl];
    NSString *absoluteString = self.URL.absoluteString;
    if (decidedUrl && [absoluteString isEqualToString:decidedUrl]) {
        return;
    }
    
    BOOL isRefuse = NO;
    
    for(int i = 0; i < refuseGoBackUrls.count; i ++) {
        NSString *url = refuseGoBackUrls[i];
        if ([absoluteString containsString:url]) {
            isRefuse = YES;
            break;
        }
    }
    
    [self sky_switchBackForwardRecognizerWithDirection:UIRectEdgeLeft enable:!isRefuse];
    [self setSky_DecidedUrl:absoluteString];
}

- (void)sky_switchBackForwardRecognizerWithDirection:(UIRectEdge)direction enable:(BOOL)enable {
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
