
#import <WebKit/WebKit.h>

@interface WKWebView (SKYBackForwardGesture)

@property(nonatomic, assign)BOOL sky_forwardRecognizerEnabled;

@property(nonatomic, assign)BOOL sky_goBackRecognizerEnabled;

@property(nonatomic, strong)NSArray *sky_refuseGoBackUrls;//根据业务需求某些页面不能返回

- (void)sky_openGoBackRecognizer;

- (void)sky_openForwarRecognizer;

- (void)sky_closeForwardRecognizer;

- (void)sky_closeGoBackRecognizer;


@end


