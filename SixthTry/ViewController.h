//
//  ViewController.h
//  SixthTry
//
//  Created by Xiaonan Wang on 6/3/15.
//  Copyright (c) 2015 Xiaonan Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <OAuthConsumer/OAuthConsumer.h>
#import <AFNetworking/AFNetworking.h>
#import "LoginWebViewController.h"
#import "OAuth1Controller.h"

@interface ViewController : UIViewController

@property (nonatomic, strong) OAuth1Controller *oauth1Controller;

- (IBAction)authorize:(id)sender;

@end

