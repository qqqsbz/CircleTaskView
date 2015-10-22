//
//  CircleTaskView.h
//  CircleTask
//
//  Created by coder on 15/10/22.
//  Copyright © 2015年 coder. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CircleTaskView : UIView

@property (strong, nonatomic) UIColor *completeColor;
@property (strong, nonatomic) UIColor *unCompleteColor;
@property (assign, nonatomic) CGFloat completeLineWidth;
@property (assign, nonatomic) CGFloat unCompleteLineWidth;
@property (strong, nonatomic) UILabel *textLabel;

- (instancetype)initWithFrame:(CGRect)frame completeNumber:(NSInteger)completeNumber unCompleteNumber:(NSInteger)unCompleteNumber;

@end
