//
//  CRStopwatchControlCell.m
//  AlarmClock
//
//  Created by Cornelia Rehbein on 15/02/14.
//  Copyright (c) 2014 Cornelia Rehbein. All rights reserved.
//

#import "CRStopwatchControlCell.h"

#import "FontAwesomeKit/FontAwesomeKit.h"

@interface CRStopwatchControlCell ()

@property(nonatomic) BOOL isActive;
@property(nonatomic) BOOL addedLaps;

@end

@implementation CRStopwatchControlCell

const static int kFontSize = 15;

- (void)awakeFromNib
{
    [self styleButtons];
    [self showInactive];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
}

- (void)showInactive
{
    self.isActive = NO;
    [self showStartButton];
    if (self.addedLaps) {
        [self showResetButton];
    } else {
        [self showLapButtonActive:NO];
    }
}

- (void)styleButtons
{
    [self.leftButton setTitle:@""
                     forState:UIControlStateNormal];
    [self.rightButton setTitle:@""
                      forState:UIControlStateNormal];

    CGPoint center = [self leftButtonCenter];

    self.leftButton = [self resizeButton:self.leftButton
                                AtCenter:center];

    center = [self rightButtonCenter];

    self.rightButton = [self resizeButton:self.rightButton
                                 AtCenter:center];

    [self.rightButton addTarget:self
                         action:@selector(addLapReset:)
               forControlEvents:UIControlEventTouchUpInside];

    [self.leftButton addTarget:self
                        action:@selector(startStopTimer:)
              forControlEvents:UIControlEventTouchUpInside];
}

- (void)showStartButton
{
    [self.leftButton setImage:[[FAKFontAwesome playIconWithSize:kFontSize] imageWithSize:CGSizeMake(kFontSize, kFontSize)]
                     forState:UIControlStateNormal];
    [self.leftButton.layer setBorderColor:[UIColor greenColor].CGColor];
}

- (void)showLapButtonActive:(BOOL)enabled
{
    [self.rightButton setImage:[[FAKFontAwesome plusIconWithSize:kFontSize] imageWithSize:CGSizeMake(kFontSize, kFontSize)]
                      forState:UIControlStateNormal];
    [self.rightButton.layer setBorderColor:[UIColor grayColor].CGColor];
    [self.rightButton setEnabled:enabled];
}

- (void)showResetButton
{
    [self.rightButton setImage:[[FAKFontAwesome refreshIconWithSize:kFontSize] imageWithSize:CGSizeMake(kFontSize, kFontSize)]
                      forState:UIControlStateNormal];
    [self.rightButton.layer setBorderColor:[UIColor grayColor].CGColor];
    [self.rightButton setEnabled:YES];
}

- (void)showStopButton
{
    [self.leftButton setImage:[[FAKFontAwesome stopIconWithSize:kFontSize] imageWithSize:CGSizeMake(kFontSize, kFontSize)]
                     forState:UIControlStateNormal];
    [self.leftButton.layer setBorderColor:[UIColor redColor].CGColor];
}
- (UIButton*)resizeButton:(UIButton*)button AtCenter:(CGPoint)center
{
    [button setCenter:center];

    [button setBackgroundColor:[UIColor whiteColor]];

    [button.layer setMasksToBounds:YES];
    [button.layer setBorderWidth:1];
    [button.layer setCornerRadius:button.frame.size.width / 2];

    return button;
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

- (void)addLapReset:(UIButton*)button
{
    if (self.isActive) {
        self.addedLaps = YES;
        [self.delegate stopWatchShouldAddLap:self];
    } else {
        self.addedLaps = NO;
        [self.delegate stopWatchShouldResetTiming:self];
        [self showLapButtonActive:NO];
    }
}

- (void)startTimer
{
    self.isActive = YES;
    [self.delegate stopWatchShouldStartTiming:self];
    [self showStopButton];
    [self showLapButtonActive:YES];
}

- (void)stopTimer
{
    self.isActive = NO;
    [self.delegate stopWatchShouldStopTiming:self];
    [self showInactive];
}

@end
