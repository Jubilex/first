//
//  BKViewController.h
//  BK
//
//  Created by Steven Callahan on 10/8/12.
//  Copyright (c) 2012 Steven Callahan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BKViewController : UIViewController <UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *normanWebView;
@property (weak, nonatomic) IBOutlet UIWebView *westernWebView;
- (IBAction)refreshButtonPressed:(id)sender;
- (IBAction)loginButtonPressed:(id)sender;

@end
