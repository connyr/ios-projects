//
//  CRTimerControlCell.m
//  AlarmClock
//
//  Created by Cornelia Rehbein on 13/02/14.
//  Copyright (c) 2014 Cornelia Rehbein. All rights reserved.
//

#import "CRTimerControlCell.h"

#import "FontAwesomeKit/FontAwesomeKit.h"

@interface CRTimerControlCell ()

@property(nonatomic) BOOL isPaused;
@property(nonatomic) BOOL isActive;

@end

@implementation CRTimerControlCell

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self styleButtons];
    [self reset];
}

- (void)reset
{
    [self showStartButton];
    [self showPauseButtonEnabled:NO];
    self.isPaused = NO;
    self.isActive = NO;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
}

- (void)styleButtons
{
    CGPoint center = [self leftButtonCenter];

    self.leftButton = [self resizeButton:self.leftButton
                                AtCenter:center];

    center = [self rightButtonCenter];

    self.rightButton = [self resizeButton:self.rightButton
                                 AtCenter:center];

    [self.rightButton addTarget:self
                         action:@selector(triggerPause:)
               forControlEvents:UIControlEventTouchUpInside];

    [self.leftButton addTarget:self
                        action:@selector(startStopTimer:)
              forControlEvents:UIControlEventTouchUpInside];
}

- (void)showStartButton
{
    [self.leftButton setImage:[[FAKFontAwesome playIconWithSize:30] imageWithSize:CGSizeMake(30, 30)]
                     forState:UIControlStateNormal];
    [self.leftButton.layer setBorderColor:[UIColor greenColor].CGColor];
}

- (void)showStopButton
{
    [self.leftButton setImage:[[FAKFontAwesome stopIconWithSize:30] imageWithSize:CGSizeMake(30, 30)]
                     forState:UIControlStateNormal];
    [self.leftButton.layer setBorderColor:[UIColor redColor].CGColor];
}

- (void)showPauseButtonEnabled:(BOOL)enabled
{
    [self.rightButton setImage:[[FAKFontAwesome pauseIconWithSize:30] imageWithSize:CGSizeMake(30, 30)]
                      forState:UIControlStateNormal];
    [self.rightButton.layer setBorderColor:[UIColor grayColor].CGColor];
    [self.rightButton setEnabled:enabled];
}

- (void)showResumeButton
{
    [self.rightButton setImage:[[FAKFontAwesome repeatIconWithSize:30] imageWithSize:CGSizeMake(30, 30)]
                      forState:UIControlStateNormal];
    [self.rightButton.layer setBorderColor:[UIColor grayColor].CGColor];
    [self.rightButton setEnabled:YES];
}

- (UIButton*)resizeButton:(UIButton*)button AtCenter:(CGPoint)center
{
    [button removeFromSuperview];
    button = [UIButton buttonWithType:UIButtonTypeCustom];

    NSInteger size = self.contentView.frame.size.height / 2;

    [button setFrame:CGRectMake(0,
                                0,
                                size,
                                size)];
    [button setCenter:center];

    [button setBackgroundColor:[UIColor whiteColor]];

    [button.layer setMasksToBounds:YES];
    [button.layer setBorderWidth:1];
    [button.layer setCornerRadius:size / 2];
    [self.contentView addSubview:button];

    return button;
}

- (void)centerButtons
{
    self.leftButton.center = self.contentView.center;
}

- (CGPoint)leftButtonCenter
{
    CGPoint center = CGPointMake(self.contentView.frame.size.width / 4,
                                 self.contentView.frame.size.height / 2);
    return center;
}

- (CGPoint)rightButtonCenter
{
    CGPoint center = CGPointMake(self.contentView.frame.size.width
                                 - self.contentView.frame.size.width / 4,
                                 self.contentView.frame.size.height / 2);
    return center;
}

- (void)startStopTimer:(UIButton*)button
{
    if (self.isActive) {
        [self stopTimer];
    } else {
        [self startTimer];
    }
}

- (void)startTimer
{
    self.isActive = YES;
    [self.delegate timerControlShouldStart:self];
    [self showStopButton];
    [self showPauseButtonEnabled:YES];
}

- (void)stopTimer
{
    self.isActive = NO;
    [self.delegate timerControlShouldStop:self];
    [self showStartButton];
    [self showPauseButtonEnabled:NO];
}

- (void)triggerPause:(UIButton*)button
{
    if (self.isPaused) {
        [self.delegate timerControlShouldResume:self];
        [self showPauseButtonEnabled:YES];
        self.isPaused = NO;
    } else {
        [self.delegate timerControlShouldPause:self];
        [self showResumeButton];
        self.isPaused = YES;
    }
}

@end
