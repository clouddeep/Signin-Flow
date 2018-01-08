//
//  THEntranceController.m
//  Signin Flow
//
//  Created by Tuan Shou Cheng on 2018/1/7.
//  Copyright © 2018年 Tuan Shou Cheng. All rights reserved.
//

#import "THEntranceController.h"
#import "THEntranceNavigationController.h"

@interface THEntranceController ()

@end

@implementation THEntranceController

- (IBAction)dismissFlowAction:(UIButton *)sender
{
    THEntranceNavigationController *nc = (THEntranceNavigationController *)self.navigationController;
    nc.dismissHandler(NO);
}

- (void)dismissEntranceController
{
    [self dismissFlowAction:nil];
}

@end
