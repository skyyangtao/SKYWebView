
#import "ViewController.h"
#import "SKYWebView.h"
//#import "Classes/SKYWebView.swift"
//#import "WKWebView+SKYBackForwardGesture.h"
#import "WebViewDemo-Swift.h"

@interface ViewController ()<WKNavigationDelegate>

@property(nonatomic, strong)SKYWebView *webView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    SKYWebView *webView = [[SKYWebView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.view addSubview:webView];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://m.baidu.com"]]];
    webView.allowsBackForwardNavigationGestures = YES;
    [webView closeForwardRecognizer];
    webView.navigationDelegate = self;
    _webView = webView;
}
    
@end
