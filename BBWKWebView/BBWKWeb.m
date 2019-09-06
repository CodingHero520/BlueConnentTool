//
//  BBWKWeb.m
//  ibike
//
//  Created by baolei on 2019/1/25.
//  Copyright © 2019 bamboo. All rights reserved.
//

#import "BBWKWeb.h"
#import <WebKit/WebKit.h>
#import "WKWebViewJavascriptBridge.h"
#define SecondUrl @"http://test-web.blackbirdsport.com/static/codeTest-zzg/index.html?ticket=knDTrM2kJEfQatLX&sm=0"

@interface BBWKWeb ()<WKUIDelegate,WKNavigationDelegate>

@property (nonatomic,strong)WKWebView * myWebView;

@property (nonatomic,strong)WKWebViewJavascriptBridge * myBridge;

@end

@implementation BBWKWeb
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        
        self.title = @"二手";
        self.hidesBottomBarWhenPushed = YES;
        
        UIButton* leftButton=[PublicUtils createBarButtonWithImageName:@"Retreat" leftOrRight:0];
        [leftButton addTarget:self action:@selector(backButtonAction) forControlEvents:UIControlEventTouchUpInside];
        
        UIBarButtonItem *leftBar=[[UIBarButtonItem alloc] initWithCustomView:leftButton];
        self.navigationItem.leftBarButtonItem=leftBar;

    }
    
    return self;
    
}
-(void)backButtonAction{
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIUtils colorWithHexString:@"#f6f6f6"];
    
    [self createWebView];
    [self showIntroRequestURL:SecondUrl];
}

-(void)createWebView{
    
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    configuration.userContentController = [WKUserContentController new];
    
    WKPreferences *preferences = [WKPreferences new];
    preferences.javaScriptCanOpenWindowsAutomatically = YES;
    preferences.minimumFontSize = 15.0;
    configuration.preferences = preferences;
    
    CGRect frame = CGRectMake(0, 64, self.view.width, [UIScreen mainScreen].bounds.size.height-64);
    self.myWebView = [[WKWebView alloc] initWithFrame:frame configuration:configuration];
    self.myWebView.backgroundColor = [UIUtils colorWithHexString:@"#f6f6f6"];
    
}
- (void)showIntroRequestURL:(NSString *)webviewUrl {
    NSString * requestUrl = [self completeRequestUrl:webviewUrl];
    //    requestUrl = webviewUrl;
    //    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:requestUrl]];
    NSURLRequest * request = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:requestUrl] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5];
    [self.myWebView loadRequest:request];
    
    self.myWebView.UIDelegate = self;
    self.myWebView.navigationDelegate = self;
    [self.view addSubview:self.myWebView];
    
    UIView *progress = [[UIView alloc]initWithFrame:CGRectMake(0, 64, CGRectGetWidth(self.view.frame), 3)];
    progress.backgroundColor = [UIColor clearColor];
    [self.view addSubview:progress];
    
    [WKWebViewJavascriptBridge enableLogging];
    // 给哪个webview建立JS与OjbC的沟通桥梁
    self.myBridge = [WKWebViewJavascriptBridge bridgeForWebView:self.myWebView];
    [self.myBridge setWebViewDelegate:self];
    
    //father bridge all
    //刷新信息
    [self.myBridge  registerHandler:@"callBackOperateResult" handler:^(id data, WVJBResponseCallback responseCallback) {
      
    }];
    
    
    
}
- (NSString *)completeRequestUrl:(NSString *)url {
    NSString * endString = @"";
    
    if ([url containsString:@"blackbirdsport.com"]) {
        UserManager * manager = [[UserManager alloc]init];
        User * user = [manager getCurrentUser];
        NSString * ton = [IBURLRequest checkToken:user];
        NSDictionary * dic = [[NSDictionary alloc]initWithObjectsAndKeys:ton,@"ticket",@"0",@"sm", nil];
        if ([url containsString:@"#"]) {
            NSArray * urlArr = [url componentsSeparatedByString:@"#"];
            NSString * uu = [urlArr firstObject];
            NSString * dd = [urlArr lastObject];
            uu = [uu stringByAddingQueryDictionary:dic];
            endString = [NSString stringWithFormat:@"%@#%@",uu,dd];
        }else {
            endString = [url stringByAddingQueryDictionary:dic];
        }
    }else {
        endString = url;
    }
    return endString;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
