//
//  CRTimeRangePickerCell.m
//  AlarmClock
//
//  Created by Cornelia Rehbein on 13/02/14.
//  Copyright (c) 2014 Cornelia Rehbein. All rights reserved.
//

#import "CRTimerCell.h"

@interface CRTimerCell ()

@end

@implementation CRTimerCell

- (void)awakeFromNib
{
    [self setupTimePicker];
    [self setupCountdownLabel];

    [self showPicker];
}

- (void)setupTimePicker
{
    self.timePicker = [[UIDatePicker alloc] initWithFrame:self.contentView.bounds];
    [self.timePicker setDatePickerMode:UIDatePickerModeCountDownTimer];
    [self addSubview:self.timePicker];

    NSTimeInterval startTime = 60 * 5;
    [self.timePicker setCountDownDuration:startTime];

    [self.timePicker setHidden:YES];
}

- (void)setupCountdownLabel
{
    self.countDownLabel = [[UILabel alloc] initWithFrame:self.contentView.bounds];
    [self.countDownLabel setTextAlignment:NSTextAlignmentCenter];
    UIFont* font = [UIFont systemFontOfSize:40];
    [self.countDownLabel setFont:font];
    [self addSubview:self.countDownLabel];
    [self.countDownLabel setHidden:YES];
}

- (NSTimeInterval)currentTimeInterval
{
    return self.timePicker.countDownDuration;
}

- (void)startTimerWithTimeInterval:(NSTimeInterval)timeInSeconds
{
    [self updateTimerWithTimeInterval:timeInSeconds];
    [self showTimer];
}

- (void)stopTimer
{
    [self showPicker];
}


- (void)updateTimerWithTimeInterval:(NSTimeInterval)remainingTimeInSeconds
{
    NSMutableString* output = [[NSMutableString alloc] init];
    unsigned long seconds = remainingTimeInSeconds;
    unsigned long minutes = seconds / 60;
    seconds %= 60;
    unsigned long hours = minutes / 60;
    minutes %= 60;

    if (hours)
        [output appendFormat:@"%02lu:", hours];

    [output appendFormat:@"%02lu:", minutes];
    [output appendFormat:@"%02lu", seconds];

    self.countDownLabel.text = output;
}

- (void)showPicker
{
    [self.countDownLabel setHidden:YES];
    [self.timePicker setHidden:NO];
}

- (void)showTimer
{
    [self.timePicker setHidden:YES];
    [self.countDownLabel setHidden:NO];
}

@end
