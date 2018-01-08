//
//  THCalibrateViewController.m
//  Signin Flow
//
//  Created by Tuan Shou Cheng on 2018/1/5.
//  Copyright © 2018年 Tuan Shou Cheng. All rights reserved.
//

#import "THCalibrateViewController.h"
#import "THCalibratePreviewViewController.h"
#import "THEntranceNavigationController.h"

NSString * const kSeguePreviewCalibate = @"segue preview calibrate";

@interface THCalibrateViewController ()
@property (weak, nonatomic) IBOutlet UITextView *noteTextView;

@end

@implementation THCalibrateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self navigationBarCustomizedBackItem];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (![self.navigationController isNavigationBarHidden]) {
        [self.navigationController setNavigationBarHidden:YES animated:YES];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = touches.anyObject;
    UIView *view = touch.view;
    
    if ([view isKindOfClass:[UIImageView class]]) {
        NSLog(@"tag is %zd", view.tag);
        [self performSegueWithIdentifier:kSeguePreviewCalibate sender:view];
    }
}

- (void)navigationBarCustomizedBackItem
{
    UINavigationBar *bar = self.navigationController.navigationBar;
    
    UIImage *backImage = [UIImage imageNamed:@"back_arrow"];
    bar.backIndicatorImage = backImage;
    bar.backIndicatorTransitionMaskImage = backImage;
    bar.tintColor = [UIColor whiteColor];
    bar.barTintColor = [UIColor blackColor];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"" style:self.navigationItem.backBarButtonItem.style target:nil action:nil];
    self.navigationItem.backBarButtonItem = item;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:kSeguePreviewCalibate]) {
        THCalibratePreviewViewController *vc = segue.destinationViewController;
        vc.tagData = ((UIView *)sender).tag;
    }
}

- (void)setNoteTextView:(UITextView *)noteTextView
{
    NSString *plainText = @"<ul style=\"color:white;font-size:110%\"><li>這是假字</li><li>第一行</li><li>第二行</li><li>第三行</li></ul>";
    
    NSData *data = [plainText dataUsingEncoding:NSUnicodeStringEncoding];
    NSAttributedString *text = [[NSAttributedString alloc] initWithData:data options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    noteTextView.attributedText = text;
    _noteTextView = noteTextView;
}


@end
