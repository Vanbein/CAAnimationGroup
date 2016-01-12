//
//  ViewController.m
//  CAAnimationGroup
//
//  Created by 王斌 on 16/1/11.
//  Copyright © 2016年 Changhong electric Co., Ltd. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface ViewController (){
    UIImageView *imgView;
}

@property(nonatomic, strong)UIImageView *testView;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _testView = [[UIImageView alloc]initWithFrame:CGRectMake(50, 50, 100, 100)];
//    [self.testView setBackgroundColor:[UIColor orangeColor]];
    [self.testView setImage:[UIImage imageNamed:@"good"]];
    self.testView.layer.cornerRadius = 10;
    self.testView.layer.masksToBounds = YES;
    [self.view addSubview:_testView];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Animation

- (void)animation{
    //添加图片
    imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"good"]];
    imgView.frame = CGRectMake(200, 100, 100, 100);
    [self.view addSubview:imgView];
    
    //贝塞尔曲线路径
    UIBezierPath *movePath = [UIBezierPath bezierPath];
    [movePath moveToPoint:CGPointMake(200.0, 100.0)];
    [movePath addQuadCurveToPoint:CGPointMake(300, 300) controlPoint:CGPointMake(300, 100)];
    
    //以下必须导入QuartzCore包
    //关键帧动画（位置）
    CAKeyframeAnimation * posAnim = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    posAnim.path = movePath.CGPath;
    posAnim.removedOnCompletion = YES;
    
    //缩放动画
    CABasicAnimation *scaleAnim = [CABasicAnimation animationWithKeyPath:@"transform"];
    scaleAnim.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    scaleAnim.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)];
    scaleAnim.removedOnCompletion = YES;
    
    //透明动画
    CABasicAnimation *opacityAnim = [CABasicAnimation animationWithKeyPath:@"alpha"];
    opacityAnim.fromValue = [NSNumber numberWithFloat:1.0];
    opacityAnim.toValue = [NSNumber numberWithFloat:0.1];
    opacityAnim.removedOnCompletion = YES;
    
    //动画组
    CAAnimationGroup *animGroup = [CAAnimationGroup animation];
    animGroup.animations = [NSArray arrayWithObjects:posAnim, scaleAnim, opacityAnim, nil];
    animGroup.duration = 1;
    
    [imgView.layer addAnimation:animGroup forKey:nil];
}

#pragma mark - Touch Events

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    //平移
    CABasicAnimation *moveAnimation = [CABasicAnimation animation];
    moveAnimation.keyPath = @"transform.translation.y";
    moveAnimation.toValue = @300;
//    moveAnimation.beginTime = 0.5;
    
    //缩放
    CABasicAnimation *scaleAnimation = [CABasicAnimation animation];
    scaleAnimation.keyPath = @"transform.scale";
    scaleAnimation.toValue = @(0.0);
    scaleAnimation.beginTime = 0.0;
    
    //旋转
    CABasicAnimation *rotationAnimation = [CABasicAnimation animation];
    rotationAnimation.keyPath = @"transform.rotation";
    rotationAnimation.toValue = @(M_PI * 2);
//    rotationAnimation.beginTime = 0.8;
    
    //组动画
    CAAnimationGroup *groupAnimation = [CAAnimationGroup animation];
    groupAnimation.animations = @[moveAnimation, scaleAnimation, rotationAnimation];
    
    //设置组动画时间
    groupAnimation.duration = 1.5;
    groupAnimation.fillMode = kCAFillModeForwards;
    groupAnimation.removedOnCompletion = NO;
//    groupAnimation.repeatCount = MAXFLOAT;
    [self.testView.layer addAnimation:groupAnimation forKey:@"group"];

    [self animation];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    sleep(1.5);
    
    [self.view addSubview:_testView];

}















@end
