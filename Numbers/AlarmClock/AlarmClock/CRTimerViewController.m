//
//  CRTimerViewController.m
//  AlarmClock
//
//  Created by Cornelia Rehbein on 12/02/14.
//  Copyright (c) 2014 Cornelia Rehbein. All rights reserved.
//

#import "CRTimerViewController.h"

#import "CRTimerCell.h"
#import "FontAwesomeKit/FontAwesomeKit.h"

@interface CRTimerViewController ()

@property(strong, nonatomic) NSTimer* timer;
@property(nonatomic) NSTimeInterval currentTimeInterval;
@property(nonatomic, strong) AVAudioPlayer* audioPlayer;

@property(nonatomic) BOOL isActive;

@end

@implementation CRTimerViewController

- (void)awakeFromNib
{
    self.title = @"Timer";
    FAKFontAwesome* clockIcon = [FAKFontAwesome clockOIconWithSize:15];
    self.tabBarItem.image = [clockIcon imageWithSize:CGSizeMake(15, 15)];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)scheduleCountDown
{
    self.isActive = YES;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                  target:self
                                                selector:@selector(countDown)
                                                userInfo:nil
                                                 repeats:YES];
}

- (void)stopCountDown
{
    self.isActive = NO;
    [self.timer invalidate];
}

- (void)startTimer
{
    self.currentTimeInterval = [[self getTimerView] currentTimeInterval];
    [[self getTimerView] startTimerWithTimeInterval:self.currentTimeInterval];
    [self scheduleCountDown];
}

- (void)stopTimer
{
    [self stopCountDown];
    [[self getTimerView] stopTimer];
}

- (void)pauseTimer
{
    [self stopCountDown];
}

- (void)resumeTimer
{
    [self scheduleCountDown];
}

- (CRTimerCell*)getTimerView
{
    return (CRTimerCell*)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0
                                                                                  inSection:0]];
}

- (CRTimerControlCell*)getControlsView
{
    return (CRTimerControlCell*)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0
                                                                                         inSection:1]];
}

#pragma mark event methods

- (void)updateInBackgroundPerSecond
{
    [self countDown];
}

- (void)countDown
{
    if (self.currentTimeInterval < 1) {
        [self.timer invalidate];
        [self countDownFinished];
    } else {
        self.currentTimeInterval--;

        dispatch_async(dispatch_get_main_queue(), ^(void) {
			[[self getTimerView] updateTimerWithTimeInterval:self.currentTimeInterval];
        });
    }
}

- (void)countDownFinished
{
    if ([UIApplication sharedApplication].applicationState == UIApplicationStateActive) {
        [self showCountDownFinishedAlert];
    } else {
        [self showCountDownFinishedNotification];
    }
    [[self getControlsView] reset];
}

- (void)showCountDownFinishedAlert
{

    UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Timer finished"
                                                        message:@"Dismiss to Close."
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];

    [self playSound];
    [alertView show];
}

- (void)showCountDownFinishedNotification
{
    UILocalNotification* localNotification = [[UILocalNotification alloc] init];
    localNotification.fireDate = [NSDate date];
    localNotification.soundName = UILocalNotificationDefaultSoundName;
    localNotification.applicationIconBadgeNumber = 1;
    localNotification.alertBody = @"Timer finished";
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
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
    [[self getTimerView] stopTimer];
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

#pragma mark UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath
{
    return tableView.frame.size.height / 2;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    if (indexPath.section == 0) {
        CRTimerCell* cell = nil;
        cell = [tableView dequeueReusableCellWithIdentifier:@"TimePickerCell"
                                               forIndexPath:indexPath];
        return cell;
    } else {
        CRTimerControlCell* cell = nil;
        cell = [tableView dequeueReusableCellWithIdentifier:@"ControlCell"
                                               forIndexPath:indexPath];
        cell.delegate = self;
        return cell;
    }
}

#pragma mark CTTimeViewerControllerDelegate methods

- (void)timerControlShouldStart:(CRTimerControlCell*)cell
{
    [self startTimer];
}

- (void)timerControlShouldStop:(CRTimerControlCell*)cell
{
    [self stopTimer];
}

- (void)timerControlShouldPause:(CRTimerControlCell*)cell
{
    [self pauseTimer];
}

- (void)timerControlShouldResume:(CRTimerControlCell*)cell
{
    [self resumeTimer];
}

@end
