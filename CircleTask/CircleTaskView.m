//
//  CircleTaskView.m
//  CircleTask
//
//  Created by coder on 15/10/22.
//  Copyright © 2015年 coder. All rights reserved.
//
#import "CircleTaskView.h"
#import "UIColor+Util.h"

@interface CircleTaskView()

@property (assign, nonatomic) NSInteger     completeNumber;
@property (assign, nonatomic) NSInteger     unCompleteNumber;
@property (assign, nonatomic) NSInteger     totalNumber;
@property (strong, nonatomic) CAShapeLayer  *completeLayer;
@property (strong, nonatomic) CAShapeLayer  *unCompleteLayer;

@end

@implementation CircleTaskView

- (instancetype)initWithFrame:(CGRect)frame completeNumber:(NSInteger)completeNumber unCompleteNumber:(NSInteger)unCompleteNumber
{
    if (self = [super initWithFrame:frame]) {
        
        self.completeNumber = completeNumber;
        self.unCompleteNumber = unCompleteNumber;
        self.totalNumber = self.completeNumber + self.unCompleteNumber;
        
        self.textLabel = [UILabel new];
        self.textLabel.textColor = [UIColor whiteColor];
        self.textLabel.textAlignment = NSTextAlignmentCenter;
        self.textLabel.numberOfLines = 2;
        [self addSubview:self.textLabel];
        
        [self initialization];
    }
    return self;
}

- (void)initialization
{
    CGFloat averageAngle = M_PI * 2 / self.totalNumber;
    CGFloat angle        = M_PI * 1.5;
    CGFloat tagAngle     = averageAngle * self.completeNumber;
    CGFloat midWidth     = CGRectGetWidth(self.frame) / 2;
    CGFloat midHeight    = CGRectGetHeight(self.frame) / 2;
    CGFloat radius       = midWidth - midWidth / 4;
    CGPoint center = CGPointMake(midWidth , midHeight);

    self.textLabel.frame  = CGRectMake(0, 0, midWidth, midHeight);
    self.textLabel.center = center;
    
    UIBezierPath *completePath = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:angle endAngle:tagAngle + angle clockwise:YES];
    UIBezierPath *unCompletePath = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:tagAngle + angle endAngle:angle clockwise:YES];
    
    
    self.completeLayer = [self buildLineWithBezierPath:completePath color:[UIColor colorWithHexString:@"#F41A57"]];
    self.unCompleteLayer = [self buildLineWithBezierPath:unCompletePath color:[UIColor colorWithHexString:@"#4ACAB5"]];
    self.unCompleteLayer.hidden = YES;
    
    CABasicAnimation *strokeAnim = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    strokeAnim.fromValue = [NSNumber numberWithFloat:0.f];
    strokeAnim.toValue   = [NSNumber numberWithFloat:1.0f];
    strokeAnim.duration  = 5.f;
    strokeAnim.delegate  = self;
    strokeAnim.removedOnCompletion = YES;
    strokeAnim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    [strokeAnim setValue:@"strokeAnim" forKey:@"CompleteAnim"];
    [self.completeLayer addAnimation:strokeAnim forKey:@"strokenAnim"];
    
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if ([[anim valueForKey:@"CompleteAnim"] isEqualToString:@"strokeAnim"]) {
        float percent = ([[NSNumber numberWithInteger:self.completeNumber] floatValue] / [[NSNumber numberWithInteger:self.totalNumber] floatValue]) * 100;
        [UIView animateWithDuration:2.f delay:0 usingSpringWithDamping:800 initialSpringVelocity:20 options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.textLabel.text   = [NSString stringWithFormat:@"完成率\n %.0f %%",percent];
        } completion:^(BOOL finished) {
            self.unCompleteLayer.hidden = NO;
        }];
    }
}

- (CAShapeLayer *)buildLineWithBezierPath:(UIBezierPath *)path color:(UIColor *)color
{
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.strokeColor = color.CGColor;
    shapeLayer.fillColor   = [UIColor clearColor].CGColor;
    shapeLayer.lineWidth   = 4.f;
    shapeLayer.path        = path.CGPath;
    [self.layer addSublayer:shapeLayer];
    return shapeLayer;
}


- (void)setCompleteColor:(UIColor *)completeColor
{
    _completeColor = completeColor;
    self.completeLayer.strokeColor = completeColor.CGColor;
}

- (void)setUnCompleteColor:(UIColor *)unCompleteColor
{
    _unCompleteColor = unCompleteColor;
    self.unCompleteLayer.strokeColor = unCompleteColor.CGColor;
}

- (void)setCompleteLineWidth:(CGFloat)completeLineWidth
{
    _completeLineWidth = completeLineWidth;
    self.completeLayer.lineWidth = completeLineWidth;
}

- (void)setUnCompleteLineWidth:(CGFloat)unCompleteLineWidth
{
    _unCompleteLineWidth = unCompleteLineWidth;
    self.unCompleteLineWidth = unCompleteLineWidth;
}

@end
