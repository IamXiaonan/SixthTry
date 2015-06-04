//
//  ViewController.m
//  SixthTry
//
//  Created by Xiaonan Wang on 6/3/15.
//  Copyright (c) 2015 Xiaonan Wang. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.oauth1Controller = [[OAuth1Controller alloc]init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)authorize:(id)sender {
    LoginWebViewController *loginWebViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"loginWebViewController"];
    [self presentViewController:loginWebViewController
                       animated:YES
                     completion:^{
                         [self.oauth1Controller loginWithWebView:loginWebViewController.webView completion:^(NSDictionary *oauthTokens, NSError *error) {
                             if (!error) {
                                 // Store your tokens for authenticating your later requests, consider storing the tokens in the Keychain
                                 NSLog(@"Success: %@", oauthTokens);
                                 [self successAuthorize:oauthTokens];
                             }
                             else
                             {
                                 NSLog(@"Error authenticating: %@", error.localizedDescription);
                             }
                             [self dismissViewControllerAnimated:YES completion: ^{
                                 self.oauth1Controller = nil;
                             }];
                         }];
                     }];
}

- (void)successAuthorize:(NSDictionary *)oauthTokens{
    
    OAConsumer *consumer = [[OAConsumer alloc] initWithKey:@"9a667de9d5690ac32ebfffd33da67895" secret:@"a129dd850662856fff612b0045d2d6ef"];
    OAToken *token = [[OAToken alloc] initWithKey:[NSString stringWithFormat:@"%@",[oauthTokens objectForKey:@"oauth_token"]] secret:[NSString stringWithFormat:@"%@",[oauthTokens objectForKey:@"oauth_token_secret"]]];
    OAHMAC_SHA1SignatureProvider *provider = [[OAHMAC_SHA1SignatureProvider alloc] init];
    
    OAMutableURLRequest *request = [[OAMutableURLRequest alloc] initWithURL:[NSURL URLWithString:@"https://api.fitbit.com/1/user/-/profile.json"] consumer:consumer token:token realm:nil signatureProvider:provider];
    [request prepare];
    
    NSHTTPURLResponse *response = nil;
    NSError *error = nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    NSLog(@"%@",[NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&error]);
}
@end
