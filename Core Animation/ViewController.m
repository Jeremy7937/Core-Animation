//
//  ViewController.m
//  Core Animation
//
//  Created by 郭凯 on 16/11/21.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UILabel *maskLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self sample1Deleay:0.0];
    [self sample1Deleay:1.0];
    [self sample3];
    [self sample4];
    [self sample5];
    
}

- (void)sample5 {
    
    self.view.backgroundColor = [UIColor darkGrayColor];
    CAGradientLayer *maskLayer = [[CAGradientLayer alloc] init];
    maskLayer.frame = self.maskLabel.bounds;
    maskLayer.backgroundColor = [UIColor clearColor].CGColor;
    maskLayer.startPoint = CGPointMake(0, 0);
    maskLayer.endPoint = CGPointMake(1, 0);
    maskLayer.colors = @[(id)[UIColor clearColor].CGColor, (id)[UIColor clearColor].CGColor, (id)[UIColor whiteColor].CGColor, (id)[UIColor clearColor].CGColor, (id)[UIColor clearColor].CGColor, (id)[UIColor clearColor].CGColor];
    maskLayer.locations = @[@(0.0),@(0.2),@(0.4),@(0.7),@(0.8),@(1.0)];
    
    [self.maskLabel.layer addSublayer:maskLayer];
    self.maskLabel.layer.mask = maskLayer;
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position.x"];
    animation.fromValue = @(0);
    animation.toValue = @(maskLayer.bounds.size.width);
    
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.repeatCount = HUGE_VALF;
    animation.duration = 1.0f;
    [maskLayer addAnimation:animation forKey:@"position"];
    
}

- (void)sample3 {
    CAKeyframeAnimation *keyAnimation = [CAKeyframeAnimation animation];
    keyAnimation.values = @[(id)self.topView.backgroundColor.CGColor,(id)[UIColor yellowColor].CGColor,(id)[UIColor greenColor].CGColor,(id)[UIColor blueColor].CGColor];
    keyAnimation.duration = 3.0f;
    keyAnimation.autoreverses = YES;
    [self.topView.layer addAnimation:keyAnimation forKey:@"backgroundColor"];
}

- (void)sample4 {
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    CGMutablePathRef aPath = CGPathCreateMutable();
    CGPathMoveToPoint(aPath, nil, 20, 20);
    CGPathAddCurveToPoint(aPath, nil, 160, 30, 220, 220, 240, 380);
    animation.path = aPath;
    animation.duration = 5.0f;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    [self.topView.layer addAnimation:animation forKey:@"A"];
}

- (void)sample1Deleay:(NSTimeInterval)time {
    //画个圆
    CAShapeLayer *circleLayer = [CAShapeLayer layer];
    circleLayer.frame = CGRectMake(0, 0, 50, 50);
    circleLayer.position = self.view.center;
    circleLayer.fillColor = [UIColor clearColor].CGColor;
    circleLayer.lineWidth = 2.0;
    circleLayer.strokeColor = [UIColor grayColor].CGColor;
    
    CGRect frame = CGRectMake(0, 0, 50, 50);
    UIBezierPath *circlePath = [UIBezierPath bezierPathWithOvalInRect:frame];
    circleLayer.path = circlePath.CGPath;
    [self.view.layer addSublayer:circleLayer];
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation.fromValue = @(1.0);
    animation.toValue = @(2.0);
//    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    CABasicAnimation *opacityAnim = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnim.fromValue = @(1.0);
    opacityAnim.toValue = @(0.0);
//    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    CAAnimationGroup *groupAnim = [CAAnimationGroup animation];
    groupAnim.duration = 2.0f;
    groupAnim.removedOnCompletion = NO;
    groupAnim.repeatCount = HUGE_VALF;
    groupAnim.beginTime = CACurrentMediaTime() + time;
    groupAnim.fillMode = kCAFillModeForwards;
    groupAnim.animations = @[animation,opacityAnim];
    [circleLayer addAnimation:groupAnim forKey:@"A"];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
