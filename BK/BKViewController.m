//
//  BKViewController.m
//  BK
//
//  Created by Steven Callahan on 10/8/12.
//  Copyright (c) 2012 Steven Callahan. All rights reserved.
//

#import "BKViewController.h"

@interface BKViewController ()
@end

@interface NSURLRequest (DummyInterface)
+ (BOOL)allowsAnyHTTPSCertificateForHost:(NSString*)host;
+ (void)setAllowsAnyHTTPSCertificate:(BOOL)allow forHost:(NSString*)host;

@end

@implementation BKViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
   // [self.normanWebView setDelegate:self];
   // [self.westernWebView setDelegate:self];
    
  // called in viewWillAppear  [self loadLogin];
}
- (void)viewDidUnload {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (void)loadLogin {
    
    NSString *normanUrlAddress =@"https://bk11252.info/~sicom/mgrng/login.php";
    NSString *westernUrlAddress =@"https://bk10467.info/~sicom/mgrng/login.php";
    
    NSURL *normanUrl = [NSURL URLWithString:normanUrlAddress];
    [NSURLRequest setAllowsAnyHTTPSCertificate:YES forHost:[normanUrl host]];
    NSURLRequest *normanRequestObj = [NSURLRequest requestWithURL: normanUrl];
    [self.normanWebView loadRequest:normanRequestObj];
    
    NSURL *westernUrl = [NSURL URLWithString:westernUrlAddress];
    [NSURLRequest setAllowsAnyHTTPSCertificate:YES forHost:[westernUrl host]];
    NSURLRequest *westernRequestObj = [NSURLRequest requestWithURL: westernUrl];
    [self.westernWebView loadRequest:westernRequestObj];
    
    [NSTimer scheduledTimerWithTimeInterval:4 target:self selector:@selector(login) userInfo:nil repeats:NO];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSLog(@"%@", request.URL.absoluteString);
    return YES;
}

- (void)viewWillAppear:(BOOL)animated{
    [self showRTM];
}
- (void) login
{

    NSString *jqueryCDN = @"http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js";
    NSData *jquery = [NSData dataWithContentsOfURL:[NSURL URLWithString:jqueryCDN]];
    NSString *jqueryString = [[NSMutableString alloc] initWithData:jquery encoding:NSUTF8StringEncoding];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *login = [defaults stringForKey:@"loginname_preference"];
    NSString *pwd = [defaults stringForKey:@"password_preference"];
    
    [self.westernWebView stringByEvaluatingJavaScriptFromString:jqueryString];
    [self.westernWebView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"$(document).ready(function() { $('input[name=XXX_login_name]').val('%@');$('input[name=XXX_login_password]').val('%@');$('#login').click();});", login, pwd]];
    
    [self.normanWebView stringByEvaluatingJavaScriptFromString:jqueryString];
    [self.normanWebView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"$(document).ready(function() { $('input[name=XXX_login_name]').val('%@');$('input[name=XXX_login_password]').val('%@');$('#login').click();});", login, pwd]];
    
    [NSTimer scheduledTimerWithTimeInterval:4 target:self selector:@selector(showRTM) userInfo:nil repeats:NO];
}
- (void) showRTM {
    
    NSString *normanUrlAddress = @"https://bk11252.info/~sicom/mgrng/rtm.php";
    NSURL *normanUrl = [NSURL URLWithString:normanUrlAddress];
    [NSURLRequest setAllowsAnyHTTPSCertificate:YES forHost:[normanUrl host]];
    NSURLRequest *normanRequestObj = [NSURLRequest requestWithURL: normanUrl];
    [self.normanWebView loadRequest:normanRequestObj];
    
    NSString *westernUrlAddress = @"https://bk10467.info/~sicom/mgrng/rtm.php";
    NSURL *westernUrl = [NSURL URLWithString:westernUrlAddress];
    [NSURLRequest setAllowsAnyHTTPSCertificate:YES forHost:[westernUrl host]];
    NSURLRequest *westernRequestObj = [NSURLRequest requestWithURL: westernUrl];
        [self.westernWebView loadRequest:westernRequestObj];
    /*
    NSString *jqueryCDN = @"http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js";
    NSData *jquery = [NSData dataWithContentsOfURL:[NSURL URLWithString:jqueryCDN]];
    NSString *jqueryString = [[NSMutableString alloc] initWithData:jquery encoding:NSUTF8StringEncoding];
    [self.westernWebView stringByEvaluatingJavaScriptFromString:jqueryString];
    
    [self.normanWebView stringByEvaluatingJavaScriptFromString:jqueryString];

    [self.westernWebView stringByEvaluatingJavaScriptFromString:@"$(document).ready(function() { $('table').css('background-color','red');$('table').attr('style', 'font-weight:5pt !important');});"];
*/
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)refreshButtonPressed:(id)sender {
    [self showRTM];
}

- (IBAction)loginButtonPressed:(id)sender {
[self loadLogin];
}
@end
