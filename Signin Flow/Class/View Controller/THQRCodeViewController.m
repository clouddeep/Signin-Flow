//
//  THQRCodeViewController.m
//  Signin Flow
//
//  Created by Tuan Shou Cheng on 2018/1/5.
//  Copyright © 2018年 Tuan Shou Cheng. All rights reserved.
//

#import "THQRCodeViewController.h"
#import "THQRCodeView.h"
#import "THEntranceNavigationController.h"

@import AVFoundation;

NSString * const kSegueCalibrate = @"segue calibrate";

@interface THQRCodeViewController () <THQRCodeViewDelegate>
@property (weak, nonatomic) IBOutlet THQRCodeView *qrCodeView;
@property (weak, nonatomic) IBOutlet UITextView *noteTextView;

@end

@implementation THQRCodeViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self cameraAuthCheck];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.qrCodeView stopScanning];
}

- (void)cameraAuthCheck
{
    AVMediaType mediaType = AVMediaTypeVideo;
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    switch (authStatus) {
        case AVAuthorizationStatusAuthorized:
            [self.qrCodeView setupCaptureConfiguration];
            break;
        case AVAuthorizationStatusDenied:
            [self alertCameraAuthDenied];
            break;
        case AVAuthorizationStatusNotDetermined:
        {
            [AVCaptureDevice requestAccessForMediaType:mediaType completionHandler:^(BOOL granted) {
                if (granted) {
                    NSLog(@"Granted access to %@", mediaType);
                    [self.qrCodeView setupCaptureConfiguration];
                } else {
                    NSLog(@"Not granted access to %@", mediaType);
                    [self alertCameraAuthDenied];
                }
            }];
            break;
        }
        default:
            NSLog(@"impossible, unknown authorization status");
            break;
    }
}

- (void)alertCameraAuthDenied
{
    NSString *title = NSLocalizedString(@"Camera Usage Denied", nil);
    NSString *message = NSLocalizedString(@"Please enable camera auth to scan QRCode", nil);
    NSString *cancelTitle = NSLocalizedString(@"Cancel", nil);
    NSString *confirmTitle = NSLocalizedString(@"OK", nil);
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleCancel handler:nil];
    __weak typeof(self) weakSelf = self;
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:confirmTitle style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        NSDictionary *options = @{UIApplicationLaunchOptionsURLKey : @NO};
        NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        [[UIApplication sharedApplication] openURL:url options:options completionHandler:^(BOOL success) {
            [weakSelf dismissEntranceController];
        }];
    }];
    [alert addAction:cancelAction];
    [alert addAction:confirmAction];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - THQRCodeViewDelegate

- (void)didScanQRCode:(NSString *)data
{
    // TODO:: Make login...
    
    // Debug
    NSLog(@"%s", __PRETTY_FUNCTION__);
    [self performSegueWithIdentifier:kSegueCalibrate sender:nil];
}

#pragma mark - Private

- (void)setQrCodeView:(THQRCodeView *)qrCodeView
{
    qrCodeView.delegate = self;
    _qrCodeView = qrCodeView;
}

- (void)setNoteTextView:(UITextView *)noteTextView
{
    NSString *firstBody = @"Scan QR code";
    NSString *secondBody = @"掃描包裝上的QRCode以認證您購買的官方商品";
    NSString *thirdBody = @"認證商品可讓您獲得產品使用的相關協助與完整的售後服務";
    
    NSString *plainText = [NSString stringWithFormat:@"<ul style=\"color:white;\"><li>%@</li><li>%@</li><li>%@</li></ul>", firstBody, secondBody, thirdBody];
        
    NSData *data = [plainText dataUsingEncoding:NSUnicodeStringEncoding];
    NSAttributedString *text = [[NSAttributedString alloc] initWithData:data options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    noteTextView.attributedText = text;
    _noteTextView = noteTextView;
}

@end
