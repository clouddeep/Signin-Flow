//
//  THRegisterViewController.m
//  Signin Flow
//
//  Created by Tuan Shou Cheng on 2018/1/5.
//  Copyright © 2018年 Tuan Shou Cheng. All rights reserved.
//

#import "THRegisterViewController.h"
#import "THEntranceNavigationController.h"

NSString * const kPurchaseLink = @"http://google.com.tw";

@interface THRegisterViewController () <UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *noteTextView;
@property (weak, nonatomic) IBOutlet UIButton *registerButton;
@property (weak, nonatomic) IBOutlet UIButton *purchaseButton;

@end

@implementation THRegisterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (IBAction)purchaseAction:(UIButton *)sender
{
    NSURL *url = [NSURL URLWithString:kPurchaseLink];
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        NSDictionary *options = @{UIApplicationLaunchOptionsURLKey : @NO};
        [[UIApplication sharedApplication] openURL:url options:options completionHandler:nil];
    }
}

- (void)setNoteTextView:(UITextView *)noteTextView
{
    NSString *plainText = @"<p>By registering you agree to the <a href=\"https://www.google.com.tw\">Terms</a> and <a href=\"https://www.google.com.tw\">Privacy Policy</a></p>";
    NSData *data = [plainText dataUsingEncoding:NSUnicodeStringEncoding];
    NSError *error;
    NSAttributedString *linkText = [[NSAttributedString alloc] initWithData:data options:@{NSDocumentTypeDocumentAttribute : NSHTMLTextDocumentType} documentAttributes:nil error:&error];
    
    noteTextView.attributedText = linkText;
    
    _noteTextView = noteTextView;
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(nonnull NSURL *)URL inRange:(NSRange)characterRange interaction:(UITextItemInteraction)interaction
{
    return (URL.absoluteString != nil);
}

- (void)setRegisterButton:(UIButton *)registerButton
{
    UIImage *image = [UIImage imageNamed:@"btn_blue"];
    CGSize size = image.size;
    image = [image stretchableImageWithLeftCapWidth:size.width/2.0 - 2.0 topCapHeight:size.height/2.0 - 2.0];
    [registerButton setBackgroundImage:image forState:UIControlStateNormal];

    _registerButton = registerButton;
}

- (void)setPurchaseButton:(UIButton *)purchaseButton
{
    UIImage *image = [UIImage imageNamed:@"btn_frame"];
    CGSize size = image.size;
    image = [image stretchableImageWithLeftCapWidth:size.width/2.0 - 2.0 topCapHeight:size.height/2.0 - 2.0];
    [purchaseButton setBackgroundImage:image forState:UIControlStateNormal];
    
    _purchaseButton = purchaseButton;
}

@end
