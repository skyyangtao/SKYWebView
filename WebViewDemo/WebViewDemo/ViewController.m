
#import "ViewController.h"
#import "SKYWebView.h"
//#import "WKWebView+SKYBackForwardGesture.h"

@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    SKYWebView *webView = [[SKYWebView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.view addSubview:webView];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://m.baidu.com"]]];
    webView.allowsBackForwardNavigationGestures = YES;
    [webView closeForwardRecognizer];
    
    //
}


@end
