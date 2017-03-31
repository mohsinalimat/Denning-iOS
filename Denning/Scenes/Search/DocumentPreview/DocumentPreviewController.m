//
//  DocumentPreviewController.m
//  Denning
//
//  Created by DenningIT on 31/03/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import "DocumentPreviewController.h"

@interface DocumentPreviewController () <UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webview;

@end

@implementation DocumentPreviewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.webview loadRequest:[NSMutableURLRequest requestWithURL:[NSURL URLWithString:self.documentURL] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:3.0]];
    self.webview.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)webView:(UIWebView *)webView
didFailLoadWithError:(NSError *)error
{
    NSLog(@"%@", error.localizedDescription);
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
