//
//  THQRCodeView.h
//  Signin Flow
//
//  Created by Tuan Shou Cheng on 2018/1/5.
//  Copyright © 2018年 Tuan Shou Cheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol THQRCodeViewDelegate;
@interface THQRCodeView : UIView

@property (nonatomic, weak) id<THQRCodeViewDelegate> delegate;
- (void)setupCaptureConfiguration;
- (void)startScanning;
- (void)stopScanning;

@end

@protocol THQRCodeViewDelegate <NSObject>
- (void)didScanQRCode:(NSString *)data;
@end
