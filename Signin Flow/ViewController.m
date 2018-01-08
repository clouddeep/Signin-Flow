//
//  ViewController.m
//  Signin Flow
//
//  Created by Tuan Shou Cheng on 2018/1/3.
//  Copyright © 2018年 Tuan Shou Cheng. All rights reserved.
//

#import "ViewController.h"
#import "THEntranceNavigationController.h"

NSString * const kSegueEntrance = @"segue entrance flow";

@interface ViewController ()

@end

@implementation ViewController

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([kSegueEntrance isEqualToString:segue.identifier]) {
        THEntranceNavigationController *nc = segue.destinationViewController;
        nc.dismissHandler = ^(BOOL completion){
            [self dismissViewControllerAnimated:YES completion:nil];
            if (completion) {
                NSLog(@"Do something if completion");
            }
        };
    }
}


@end
