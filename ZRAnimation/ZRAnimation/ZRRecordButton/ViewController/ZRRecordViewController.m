//
//  ZRRecordViewController.m
//  ZRAnimation
//
//  Created by zhaojijin on 2019/1/31.
//  Copyright © 2019年 RobinZhao. All rights reserved.
//

#import "ZRRecordViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "ZRRecordButton.h"

static float const timeInterval = 0.05;
static float const totalTime = 10.0;

@interface ZRRecordViewController ()

@property (nonatomic, strong) IBOutlet UIView *videoPreviewView;
@property (nonatomic, strong) IBOutlet ZRRecordButton *videoRecordButton;

@property (nonatomic, strong) AVCaptureSession *captureSession;//负责输入和输出设置之间的数据传递
@property (nonatomic, strong) AVCaptureDeviceInput *captureDeviceInput;//负责从AVCaptureDevice获得输入数据
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *captureVideoPreviewLayer;//相机拍摄预览图层

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) CGFloat progress;
@property (nonatomic, assign) CGFloat step;

@end

@implementation ZRRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"录制按钮";
    [self initCapture];
    self.step = 1/(totalTime/timeInterval);
    [self.videoRecordButton addTarget:self selector:@selector(handleVideoRecordButtonEvent)];
    // 设置中间按钮的颜色，默认红色
    self.videoRecordButton.buttonColor = [UIColor greenColor];
    // 设置中间按钮常规图片，不设置默认是颜色
    [self.videoRecordButton setButtonBgImage:[UIImage imageNamed:@"video_record"] forState:UIControlStateNormal];
    // 设置中间按钮选中图片，不设置默认是颜色
    [self.videoRecordButton setButtonBgImage:[UIImage imageNamed:@"video_record_recording"] forState:UIControlStateSelected];
    // 设置中间按钮的颜色，默认红色
    self.videoRecordButton.buttonColor = [UIColor greenColor];
//    // 可以纯代码
//    ZRRecordButton *btn = [[ZRRecordButton alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
//    [btn addTarget:self selector:@selector(handleVideoRecordButtonEvent)];
//    [self.view addSubview:btn];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self captureStartRunning];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self captureStopRunning];
    [self timeInvalidate];
}

- (void)dealloc {
    
    NSLog(@"%s",__func__);
}

#pragma mark - Event

//初始化AVCaptureSession
- (void)initCapture {
    //初始化会话
    _captureSession = [[AVCaptureSession alloc] init];
    if ([_captureSession canSetSessionPreset:AVCaptureSessionPresetHigh]) {
        //设置分辨率
        _captureSession.sessionPreset = AVCaptureSessionPresetHigh;
    }
    
    //获得输入设备
    AVCaptureDevice *captureDevice = [self getCameraDeviceWithPosition:AVCaptureDevicePositionBack];//取得后置摄像头
    
    NSError *error = nil;
    //根据输入设备初始化设备输入对象，用于获得输入数据
    _captureDeviceInput = [[AVCaptureDeviceInput alloc]initWithDevice:captureDevice error:&error];
    
    //将设备输入添加到会话中
    if ([_captureSession canAddInput:_captureDeviceInput]) {
        [_captureSession addInput:_captureDeviceInput];
    }
    
    //创建视频预览层，用于实时展示摄像头状态
    _captureVideoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc]initWithSession:self.captureSession];
    _captureVideoPreviewLayer.frame = [UIScreen mainScreen].bounds;
    _captureVideoPreviewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;//填充模式
    [self.videoPreviewView.layer addSublayer:_captureVideoPreviewLayer];
}

//获取摄像头方向
- (AVCaptureDevice *)getCameraDeviceWithPosition:(AVCaptureDevicePosition)position {
    NSArray *cameras = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for (AVCaptureDevice *camera in cameras) {
        if ([camera position] == position) {
            return camera;
        }
    }
    return nil;
}

- (void)captureStartRunning {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self.captureSession startRunning];
    });
}

- (void)captureStopRunning {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        if ([self.captureSession isRunning]) {
            [self.captureSession stopRunning];
        }
    });
}

- (void)handleVideoRecordButtonEvent {
    NSLog(@"videoRecordButton.selected = %d",self.videoRecordButton.selected);
    if (self.videoRecordButton.selected) {
        [self makeTiemr];
    } else {
        [self timeInvalidate];
    }
}

- (void)makeTiemr {
    if (!self.timer) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:timeInterval target:self selector:@selector(timeAction) userInfo:nil repeats:YES];
    }
}

- (void)timeInvalidate {
    [self.timer invalidate];
    self.timer = nil;
}

- (void)timeAction {
    // totalTime = 60s; 60/0.05 = 1200次，step = 1/1200；
    self.progress += self.step;
    self.videoRecordButton.progress = self.progress;
    NSLog(@"%lf",self.progress);
    if (self.progress >= 1) {
        [self timeInvalidate];
        self.videoRecordButton.selected = NO;
        self.progress = 0;
    }
}

@end
