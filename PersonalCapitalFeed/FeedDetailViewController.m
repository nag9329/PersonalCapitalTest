//
//  FeedDetailViewController.m
//  PersonalCapitalFeed
//
//  Created by Nagarjuna Ramagiri on 11/4/19.
//  Copyright © 2019 Nagarjuna Ramagiri. All rights reserved.
//

#import "FeedDetailViewController.h"
#import <WebKit/WebKit.h>

@interface FeedDetailViewController ()<WKNavigationDelegate>

@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;

@end

@implementation FeedDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    WKWebViewConfiguration *theConfiguration = [[WKWebViewConfiguration alloc] init];
    WKWebView *webView = [[WKWebView alloc] initWithFrame:self.view.frame configuration:theConfiguration];
    webView.navigationDelegate = self;
    NSURL *nsurl=[NSURL URLWithString:self.articleLink];
    NSURLRequest *nsrequest=[NSURLRequest requestWithURL:nsurl];
    [self.view addSubview:webView];
    [webView loadRequest:nsrequest];
    
    self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleLarge];
    self.activityIndicator.alpha = 1.0;
    [self.view addSubview:self.activityIndicator];
    self.activityIndicator.center = CGPointMake([[UIScreen mainScreen]bounds].size.width/2, [[UIScreen mainScreen]bounds].size.height/2);
    [webView addSubview:self.activityIndicator];
    self.navigationItem.title = self.articleTitle;
}

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation
{
    [self.activityIndicator startAnimating];
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    [self.activityIndicator stopAnimating];
}

@end
