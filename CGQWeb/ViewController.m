//
//  ViewController.m
//  CGQWeb
//
//  Created by 中科天地 on 16/9/26.
//  Copyright © 2016年 wangchengshan. All rights reserved.
//

#import "ViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "LXFloaintButton.h"
#import "UIView+LXCornerdious.h"


#define Device_Width  [[UIScreen mainScreen] bounds].size.width//获取屏幕宽高
#define Device_Height [[UIScreen mainScreen] bounds].size.height
#define ELSareArea  (MAX(Device_Width, Device_Height)  == 812 ? 34.00 : 0.00)
#define NAVH (MAX(Device_Width, Device_Height)  == 812 ? 88 : 64)
#define TABBARH (MAX(Device_Width, Device_Height)  == 812 ? 83 : 49)

@interface ViewController ()<UIWebViewDelegate>
@property (nonatomic, weak) JSContext *context;
@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) UIButton  *floatBtn;

@end

@implementation ViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
//    self.navigationController.navigationBar.barStyle = UIStatusBarStyleLightContent;
//
//    UIView* stateView = [[UIView alloc] initWithFrame:CGRectMake(0, -20, Device_Width, 20)];
//    [self.navigationController.navigationBar addSubview:stateView];
//    stateView.backgroundColor = [UIColor colorWithRed:69/255.0 green:155/255.0 blue:118/255.0 alpha:1];
}



/**说明
 1，本例用到了JavaScriptCore框架，苹果自身框架，功能强大，只用了其中一个JSContext就完成了简单交互，若要完成复杂交互还要深入研究；
 2，iOS8以后苹果完善了网页框架，使用了新的WebKit框架，确实弥补了一些不足，WKWebView取代了UIWebView，但为了使用更多的系统需求，开发中不少还是从iOS7做起的，开发中以情况，交互量而定；
 3，更多内容将后续推出，如有研究需要，请联系QQ1607656228，共同进步。
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    UIWebView * webView = [[UIWebView alloc] init];
    webView.frame = self.view.bounds;
    webView.backgroundColor = [UIColor clearColor];
    webView.delegate = self;
    webView.multipleTouchEnabled = YES;
    webView.autoresizingMask = YES;
    [self.view addSubview:webView];

    self.webView = webView;
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.pitwang.cn"]];
    [webView loadRequest:request];
    [self.webView reload];
    
    self.floatBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 70, self.view.frame.size.height - NAVH - 100, 60, 60)];
    self.floatBtn.layer.masksToBounds = YES;
    self.floatBtn.layer.cornerRadius = 30;
    [self.floatBtn setTitle:@"返回" forState:UIControlStateNormal];
    [self.floatBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.floatBtn.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.6];
    [self.floatBtn addTarget:self action:@selector(floatBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.webView addSubview:self.floatBtn];
    
    
}

- (void)floatBtn:(UIButton *)sender {
    NSLog(@"点击");
    if ([self.webView canGoBack]) {
        [self.webView goBack];
        
    }
    /*
    else{
        [self.view resignFirstResponder];
        [self.navigationController popViewControllerAnimated:YES];
    }
     */
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
//    截获当前H5页面的链接，做相应处理
    NSString *requestString = [[[request URL] absoluteString]stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"requestString : %@",requestString);
    
    
    NSArray *components = [requestString componentsSeparatedByString:@"|"];
    NSLog(@"=components=====%@",components);
    
    
    NSString *str1 = [components objectAtIndex:0];
    NSLog(@"str1:::%@",str1);
    
    
    NSArray *array2 = [str1 componentsSeparatedByString:@"/"];
    NSLog(@"array2:====%@",array2);
    
    
    NSInteger coun = array2.count;
    NSString *method = array2[coun-1];
    NSLog(@"method:===%@",method);
    
//    if ([str1 hasPrefix:@"http:"]) {
////        链接以什么开头
//    }
//    if ([str1 hasSuffix:@"jifen.html"]) {
////        链接以什么结尾
//    }
//    if ([str1 rangeOfString:@"shop"].location == NSNotFound) {
////        不包含某段字符串
//    }else{
////        包含某段字符串
//    }
//    if ([str1 containsString:@"shop"]) {
////        iOS8以后判断是否包含某段字符串
//    }
    
    NSString *arrayToString = [components componentsJoinedByString:@","];
    NSLog(@"------------%@-----------------", arrayToString);
    
    
//    if ([method isEqualToString:@"jifen.html"])//查看详情，其中红色部分是HTML5跟咱们约定好的，相应H5上的按钮的点击事件后，H5发送超链接，客户端一旦收到这个超链接信号。把其中的点击按钮的约定的信号标示符截取出来跟本地的标示符来进行匹配，如果匹配成功，那么就执行相应的操作，详情见如下所示。
//    {
//        return NO;
//    }else if ([method isEqualToString:@"jifen.html"])
//    {
//        
//        return NO;
//    }
    return YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
    
//    返回的H5方法

    //js方法名＋参数
//    NSString* jsCode = @"history.go(-1)";
    
    //调用html页面的js方法
//    [webView stringByEvaluatingJavaScriptFromString:jsCode];

    
//    documentView.webView.mainFrame.javaScriptContext 获取context的固定写法。
    _context=[webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    //获取首页返回键的方法，
    _context[@"home"] = ^(){
        [[[UIAlertView alloc] initWithTitle:@"恭喜！" message:@"截取到了返回的方法，在这里可以返回我们自己的页面！！！" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"好的", nil] show];
        
        
//        方法带参数时获取方法参数
        NSArray *array = [JSContext currentArguments];//H5方法里的参数
        NSString *url = [array lastObject];
        //        NSString *urlGame = [url substringToIndex:url.length].description;
        NSLog(@"%@, %@", array, url);
    };
    
    
    if (self.navigationController) {
        
//        获得H5标题作为页面title。
//        self.navigationItem.title = self.title?:[_webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    }
}


@end
