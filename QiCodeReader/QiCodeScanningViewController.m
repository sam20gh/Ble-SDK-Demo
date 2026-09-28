//
//  QiCodeScanningViewController.m
//  QiQRCode
//
//  Created by huangxianshuai on 2018/11/13.
//  Copyright © 2018年 QiShare. All rights reserved.
//

#import "QiCodeScanningViewController.h"
#import "QiCodePreviewView.h"
#import "QiCodeManager.h"

@interface QiCodeScanningViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) QiCodePreviewView *previewView;
@property (nonatomic, strong) QiCodeManager *codeManager;

@end

@implementation QiCodeScanningViewController
- (void)viewDidLoad {
    
    [super viewDidLoad];
    _previewView = [[QiCodePreviewView alloc] initWithFrame:self.view.bounds];
    _previewView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:_previewView];
    
    [self SacenavigationViewTiteStr:LocalForkey(@"扫一扫") RigtButStr:@"图片选择扫一扫"];
    
    __weak typeof(self) weakSelf = self;
    _codeManager = [[QiCodeManager alloc] initWithPreviewView:_previewView completion:^{
        [weakSelf startScanning];
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self startScanning];
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    [_codeManager stopScanning];
}

- (void)dealloc {
    
    NSLog(@"%s", __func__);
}


#pragma mark - Action functions

- (void)RigtButAction{
    
    __weak typeof(self) weakSelf = self;
    [_codeManager presentPhotoLibraryWithRooter:self callback:^(NSString * _Nonnull code) {
        NSLog(@"photo:%@",code);
        if (self.sureBlock) {
            self.sureBlock(code);
        }
        if(![self.navigationController popViewControllerAnimated:YES]){
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }];
}


#pragma mark - Private functions

- (void)startScanning {
    
    __weak typeof(self) weakSelf = self;
    [_codeManager startScanningWithCallback:^(NSString * _Nonnull code) {
         NSLog(@"startScanning:%@",code);
        if (self.sureBlock) {
            self.sureBlock(code);
        }
        if(![self.navigationController popViewControllerAnimated:YES]){
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    } autoStop:YES];
}






@end
