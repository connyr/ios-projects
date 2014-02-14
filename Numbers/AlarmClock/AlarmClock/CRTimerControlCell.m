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

@end

@implementation CRTimerControlCell

- (void)awakeFromNib
{
    [self createButtons];
    [self reset];
}

- (void)reset
{
    [self showStartButton];
    [self showPauseButtonEnabled:NO];
    self.isPaused = NO;
}

- (void)createButtons
{
    CGPoint center = [self leftButtonCenter];

    self.leftButton = [self createButtonAt:center];
    [self.contentView addSubview:self.leftButton];

    center = [self rightButtonCenter];

    self.rightButton = [self createButtonAt:center];
    [self.contentView addSubview:self.rightButton];
    [self.rightButton addTarget:self
                         action:@selector(triggerPause:)
               forControlEvents:UIControlEventTouchUpInside];
}

- (void)showStartButton
{
    [self.leftButton removeTarget:self
                           action:@selector(stopTimer:)
                 forControlEvents:UIControlEventTouchUpInside];

    [self.leftButton setImage:[[FAKFontAwesome playIconWithSize:30] imageWithSize:CGSizeMake(30, 30)]
                     forState:UIControlStateNormal];
    [self.leftButton.layer setBorderColor:[UIColor greenColor].CGColor];
    [self.leftButton addTarget:self
                        action:@selector(startTimer:)
              forControlEvents:UIControlEventTouchUpInside];
}

- (void)showStopButton
{
    [self.leftButton removeTarget:self
                           action:@selector(startTimer:)
                 forControlEvents:UIControlEventTouchUpInside];

    [self.leftButton setImage:[[FAKFontAwesome stopIconWithSize:30] imageWithSize:CGSizeMake(30, 30)]
                     forState:UIControlStateNormal];
    [self.leftButton.layer setBorderColor:[UIColor redColor].CGColor];
    [self.leftButton addTarget:self
                        action:@selector(stopTimer:)
              forControlEvents:UIControlEventTouchUpInside];
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

- (UIButton*)createButtonAt:(CGPoint)center
{
    NSInteger size = self.contentView.frame.size.height / 2;

    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(0,
                                0,
                                size,
                                size)];
    [button setCenter:center];

    [button setBackgroundColor:[UIColor whiteColor]];

    [button.layer setMasksToBounds:YES];
    [button.layer setBorderWidth:1];
    [button.layer setCornerRadius:size / 2];

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

- (void)startTimer:(UIButton*)button
{
    [self.delegate timerControlShouldStart:self];

    [self showStopButton];
    [self showPauseButtonEnabled:YES];
}

- (void)stopTimer:(UIButton*)button
{
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
