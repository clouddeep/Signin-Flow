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

- (void)viewDidLoad
{
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
    NSString *headText = @"請先進行校正，讓您獲得最好的產品效果";
    NSString *firstBody = @"請從以上圖片中選出一張最接近白色的圖";
    NSString *secondBody = @"點擊您選擇的圖片可開啟效果預覽圖";
    NSString *thirdBody = @"開啟預覽圖後點擊完成以結束產品校正";
    
    NSString *plainText = [NSString stringWithFormat:@"<h4 style=\"color:white;\">%@</h4><ul style=\"color:white;\"><li>%@</li><li>%@</li><li>%@</li></ul>", headText, firstBody, secondBody, thirdBody];
    
    NSData *data = [plainText dataUsingEncoding:NSUnicodeStringEncoding];
    NSAttributedString *text = [[NSAttributedString alloc] initWithData:data options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    noteTextView.attributedText = text;
    _noteTextView = noteTextView;
}

@end
