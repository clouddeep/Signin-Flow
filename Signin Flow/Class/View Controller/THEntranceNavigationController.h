//
//  THEntranceNavigationController.h
//  Signin Flow
//
//  Created by Tuan Shou Cheng on 2018/1/7.
//  Copyright © 2018年 Tuan Shou Cheng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^DismissHandler)(BOOL completion);

@interface THEntranceNavigationController : UINavigationController

@property (nonatomic, copy) DismissHandler dismissHandler;

@end
