//
//  THQRCodeView.m
//  Signin Flow
//
//  Created by Tuan Shou Cheng on 2018/1/5.
//  Copyright © 2018年 Tuan Shou Cheng. All rights reserved.
//

#import "THQRCodeView.h"
@import AVKit;

@interface THQRCodeView () <AVCaptureMetadataOutputObjectsDelegate>

@property (strong, nonatomic) AVCaptureSession *captureSession;


@end

@implementation THQRCodeView

#pragma mark - Public

- (void)startScanning
{
    if (!self.captureSession) return;
    [self.captureSession startRunning];
}

- (void)stopScanning
{
    if (!self.captureSession) return;
    [self.captureSession stopRunning];
}

- (void)setupCaptureConfiguration
{
    [self initAVConfiguration];
}

#pragma mark - Init

+ (Class)layerClass
{
    return [AVCaptureVideoPreviewLayer class];
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self initAVConfiguration];
    }
    return self;
}

- (void)initAVConfiguration
{
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus != AVAuthorizationStatusAuthorized) {
        return;
    }
    dispatch_queue_t bgQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0);
    dispatch_async(bgQueue, ^{
        AVCaptureSession *session = [[AVCaptureSession alloc] init];
        
        AVCaptureDevice *camera = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        
        NSError *error;
        AVCaptureDeviceInput *deviceInput = [AVCaptureDeviceInput deviceInputWithDevice:camera error:&error];
        
        if (error) {
            NSLog(@"Error : %@", error);
        }
        
        if ([session canAddInput:deviceInput]) {
            [session addInput:deviceInput];
        }
        
        AVCaptureMetadataOutput *output = [[AVCaptureMetadataOutput alloc] init];
        if ([session canAddOutput:output]) {
            [session addOutput:output];
        }
        
        dispatch_queue_t dispatchQueue;
        dispatchQueue = dispatch_queue_create("QRCode Queue", NULL);
        [output setMetadataObjectsDelegate:self queue:dispatchQueue];
        [output setMetadataObjectTypes:@[AVMetadataObjectTypeQRCode]];
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            AVCaptureVideoPreviewLayer *layer = (AVCaptureVideoPreviewLayer *)self.layer;
            
            layer.session = session;
            [layer setVideoGravity:AVLayerVideoGravityResize];
        });
        
        self.captureSession = session;
        
        [session startRunning];
    });
}

- (void)captureOutput:(AVCaptureOutput *)output didOutputMetadataObjects:(NSArray<__kindof AVMetadataObject *> *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    if (!metadataObjects.count) return;
    
    AVMetadataMachineReadableCodeObject *object = metadataObjects.firstObject;
    if (object.type == AVMetadataObjectTypeQRCode)
    {
        if (object.stringValue)
        {
            NSLog(@"code: %@", object.stringValue);
            [self.captureSession stopRunning];
            __weak typeof(self) weakSelf = self;
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.delegate didScanQRCode:object.stringValue];
            });
        }
    }
}

@end
