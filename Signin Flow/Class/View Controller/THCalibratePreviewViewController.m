//
//  THCalibratePreviewViewController.m
//  Signin Flow
//
//  Created by Tuan Shou Cheng on 2018/1/5.
//  Copyright © 2018年 Tuan Shou Cheng. All rights reserved.
//

#import "THCalibratePreviewViewController.h"
#import "THEntranceNavigationController.h"

@interface THCalibratePreviewViewController ()
@property (weak, nonatomic) IBOutlet UIButton *confirmButton;

@end

@implementation THCalibratePreviewViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (IBAction)registerCompleteAction:(UIButton *)sender
{
    THEntranceNavigationController *nc = (THEntranceNavigationController *)self.navigationController;
    nc.dismissHandler(YES);
}

- (void)setConfirmButton:(UIButton *)confirmButton
{
    [confirmButton setTitle:NSLocalizedString(@"Calibrate Finished", nil) forState:UIControlStateNormal];
    _confirmButton = confirmButton;
}

@end
