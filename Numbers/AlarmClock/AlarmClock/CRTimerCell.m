//
//  CRTimeRangePickerCell.m
//  AlarmClock
//
//  Created by Cornelia Rehbein on 13/02/14.
//  Copyright (c) 2014 Cornelia Rehbein. All rights reserved.
//

#import "CRTimerCell.h"

#import <AVFoundation/AVFoundation.h>

// 2 states. shows either the timepicker, or the timer that counts down
// timer can be stopped and resumed

@interface CRTimerCell () <AVAudioPlayerDelegate, UIAlertViewDelegate>

@property(strong, nonatomic) NSTimer* timer;
@property(nonatomic) NSTimeInterval timeInterval;
@property(nonatomic) NSTimeInterval currentTimeInterval;
@property(nonatomic, strong) AVAudioPlayer* audioPlayer;

@property(strong, nonatomic) NSDateFormatter* dateFormatter;

@end

@implementation CRTimerCell

- (void)awakeFromNib
{
    self.timeInterval = 60 * 5;
    [self setupTimePicker];
    [self setupCountdownLabel];

    self.dateFormatter = [[NSDateFormatter alloc] init];
    [self.dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
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
    [self.countDownLabel setHidden:YES];
}

- (void)updateCountDownLabel
{
    NSMutableString* output = [[NSMutableString alloc] init];
    unsigned long seconds = self.currentTimeInterval;
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
    if (self.currentTimeInterval < 1) {
        [self.timer invalidate];
        [self raiseAlarm];
    } else {
        self.currentTimeInterval--;

        dispatch_async(dispatch_get_main_queue(), ^(void) {
		[self updateCountDownLabel];
        });
    }
}

- (void)handlePickerChanges:(UIDatePicker*)picker
{
    self.timeInterval = picker.countDownDuration;
}

- (void)raiseAlarm
{
    UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Timer finished"
                                                        message:@"Dismiss to Close."
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];

    [self playSound];
    [alertView show];
}

- (void)playSound
{
    NSError* audioSessionError = nil;

    AVAudioSession* audioSession = [AVAudioSession sharedInstance];

    if ([audioSession setCategory:AVAudioSessionCategoryPlayback
                            error:&audioSessionError]) {
        NSLog(@"Successfully set the audio session.");
    } else {
        NSLog(@"Could not set the audio session");
    }

    dispatch_queue_t dispatchQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(dispatchQueue, ^(void) {
		NSBundle *mainBundle = [NSBundle mainBundle];
		NSString *filePath = [mainBundle pathForResource:@"Annoying_Alarm_Clock-UncleKornicob"
												  ofType:@"mp3"];
		NSData *fileData = [NSData dataWithContentsOfFile:filePath];
		NSError *audioPlayerError = nil;
		
		self.audioPlayer = [[AVAudioPlayer alloc]
							initWithData:fileData
							error:&audioPlayerError];
		
		if (self.audioPlayer != nil)
		{			self.audioPlayer.delegate = self;
			if ([self.audioPlayer prepareToPlay] && [self.audioPlayer play]){ NSLog(@"Successfully started playing.");
			}else{
				NSLog(@"Failed to play the audio file."); self.audioPlayer = nil;
			}
		}else{
			NSLog(@"Could not instantiate the audio player.");
		}
    });
}

#pragma mark UIAlertView delegate

- (void)alertView:(UIAlertView*)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{

    [self.audioPlayer stop];
    [self showPicker];
}

#pragma mark AVAudio delegate

- (void)audioPlayerBeginInterruption:(AVAudioPlayer*)player
{
    NSLog(@"audioPlayerBeginInterruption");
}

- (void)audioPlayerEndInterruption:(AVAudioPlayer*)player withOptions:(NSUInteger)flags
{
    if (flags == AVAudioSessionInterruptionOptionShouldResume) {
        [player play];
    }
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer*)player successfully:(BOOL)flag
{
    if (flag) {
        NSLog(@"Audio player stopped correctly.");
    } else {
        NSLog(@"Audio player did not stop correctly.");
    }
    if ([player isEqual:self.audioPlayer]) {
        self.audioPlayer = nil;
    } else { /* This is not our audio player */
    }
}

@end
