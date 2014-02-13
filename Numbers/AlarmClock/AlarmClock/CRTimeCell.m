//
//  CRTimeRangePickerCell.m
//  AlarmClock
//
//  Created by Cornelia Rehbein on 13/02/14.
//  Copyright (c) 2014 Cornelia Rehbein. All rights reserved.
//

#import "CRTimeCell.h"

// 2 states. shows either the timepicker, or the timer that counts down
// timer can be stopped and resumed

@interface CRTimeCell ()

@property(strong, nonatomic) NSTimer* timer;
@property(nonatomic) NSTimeInterval timeInterval;
@property(nonatomic) NSTimeInterval currentTimeInterval;

@property(strong, nonatomic) NSDateFormatter* dateFormatter;

@end

@implementation CRTimeCell

- (void)awakeFromNib
{
    self.timeInterval = 60 * 5;
    [self setupTimePicker];
    [self setupCountdownLabel];

    self.dateFormatter = [[NSDateFormatter alloc] init];
    [self.dateFormatter setDateFormat:@"hh:mm:ss"];

    [self showPicker];
}

- (void)setupTimePicker
{
    self.timePicker = [[UIDatePicker alloc] initWithFrame:self.contentView.bounds];
    [self.timePicker setDatePickerMode:UIDatePickerModeCountDownTimer];
    [self.timePicker setCountDownDuration:self.timeInterval];
    [self addSubview:self.timePicker];

    [self.timePicker addTarget:self
                        action:@selector(handlePickerChanges:)
              forControlEvents:UIControlEventValueChanged];
    [self.timePicker setHidden:YES];
}

- (void)setupCountdownLabel
{
    self.countDownLabel = [[UILabel alloc] initWithFrame:self.contentView.bounds];
    [self.countDownLabel setTextAlignment:NSTextAlignmentCenter];
    UIFont* font = [UIFont systemFontOfSize:40];
    [self.countDownLabel setFont:font];
    [self addSubview:self.countDownLabel];
    [self updateCountDownLabel];
    [self.countDownLabel setHidden:YES];
}

- (void)updateCountDownLabel
{
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:self.currentTimeInterval];
    NSString* output = [self.dateFormatter stringFromDate:date];
    self.countDownLabel.text = output;
}

- (void)showPicker
{
    [self.countDownLabel setHidden:YES];
    [self.timePicker setCountDownDuration:self.timeInterval];
    [self.timePicker setHidden:NO];
}

- (void)showTimer
{
    [self.timePicker setHidden:YES];
    [self updateCountDownLabel];
    [self.countDownLabel setHidden:NO];
}

#pragma mark public trigger methods

- (void)startTimer
{
    self.currentTimeInterval = self.timeInterval;
    [self showTimer];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                  target:self
                                                selector:@selector(countDown)
                                                userInfo:nil
                                                 repeats:YES];
}

- (void)stopTimer
{
    [self.timer invalidate];
    [self showPicker];
}

- (void)pauseTimer
{
    [self.timer invalidate];
}

- (void)resumeTimer
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                  target:self
                                                selector:@selector(countDown)
                                                userInfo:nil
                                                 repeats:YES];
}

#pragma mark event methods

- (void)countDown
{
    if (self.timeInterval < 1) {
        [self.timer invalidate];
        [self raiseAlarm];
    }
    self.currentTimeInterval--;

    dispatch_async(dispatch_get_main_queue(), ^(void) {
		[self updateCountDownLabel];
    });
}

- (void)handlePickerChanges:(UIDatePicker*)picker
{
    self.timeInterval = picker.countDownDuration;
}

- (void)raiseAlarm
{
    // play sound
    // show alert
    // stop alert, when sound is dismissed
}

@end
