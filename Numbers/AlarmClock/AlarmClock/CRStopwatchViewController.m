//
//  CRStopwatchViewController.m
//  AlarmClock
//
//  Created by Cornelia Rehbein on 14/02/14.
//  Copyright (c) 2014 Cornelia Rehbein. All rights reserved.
//

#import "CRStopwatchViewController.h"

#import "CRStopwatchViewCell.h"
#import "CRLapOverviewCell.h"
#import "FontAwesomeKit/FontAwesomeKit.h"

@interface CRStopwatchViewController ()

@property(nonatomic, strong) NSTimer* timer;
@property(nonatomic) NSMutableArray* laps;
@property(nonatomic) NSTimeInterval runTime;
@property(nonatomic) NSTimeInterval lapRunTime;
@property(nonatomic, weak) IBOutlet UITableView* tableView;

@end

@implementation CRStopwatchViewController

- (void)awakeFromNib
{
    self.tabBarItem.title = @"Stopwatch";
    FAKFontAwesome* clockIcon = [FAKFontAwesome clockOIconWithSize:15];
    self.tabBarItem.image = [clockIcon imageWithSize:CGSizeMake(15, 15)];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.tabBarController.navigationItem setTitle:@"Stopwatch"];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.runTime = 0;
    self.lapRunTime = 0;
    self.laps = [[NSMutableArray alloc] init];
}

- (void)updateInBackgroundPerSecond
{
}

- (void)setupTiming
{
    self.timer = [NSTimer timerWithTimeInterval:0.01
                                         target:self
                                       selector:@selector(updateClock)
                                       userInfo:nil
                                        repeats:YES];
    NSRunLoop* runloop = [NSRunLoop currentRunLoop];
    [runloop addTimer:self.timer
              forMode:NSRunLoopCommonModes];
    [runloop addTimer:self.timer
              forMode:UITrackingRunLoopMode];
}

- (void)updateClock
{
    self.runTime += 0.01;
    self.lapRunTime += 0.01;

    [[self getStopwatchView] updateWithTimeInterval:self.runTime
                                withLapTimeInterval:self.lapRunTime];
}

- (void)clearLaps
{
    self.laps = [[NSMutableArray alloc] init];
    [[self getLapView] setLaps:self.laps];
    [self.tableView reloadData];
}

- (void)addLap
{
    NSString* timestamp = [CRStopwatchViewCell stringFromTimeInterval:self.lapRunTime];
    self.lapRunTime = 0;
    [self.laps addObject:timestamp];
    [[self getLapView] setLaps:self.laps];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITableView delegate

- (CRStopwatchViewCell*)getStopwatchView
{
    return (CRStopwatchViewCell*)[self.tableView cellForRowAtIndexPath:
                                                     [NSIndexPath indexPathForRow:0
                                                                        inSection:0]];
}

- (CRLapOverviewCell*)getLapView
{
    return (CRLapOverviewCell*)[self.tableView cellForRowAtIndexPath:
                                                   [NSIndexPath indexPathForRow:0
                                                                      inSection:2]];
}

- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath
{
    NSInteger staticHeaderSize = 120;

    if (indexPath.section != 2) {
        return staticHeaderSize;
    } else
        return self.tableView.bounds.size.height - (staticHeaderSize * 2);
}

- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    if (indexPath.section == 0) {
        CRStopwatchViewCell* cell = nil;
        cell = [tableView dequeueReusableCellWithIdentifier:@"CRStopwatchViewCell"
                                               forIndexPath:indexPath];
        return cell;
    } else if (indexPath.section == 1) {
        CRStopwatchControlCell* cell = nil;
        cell = [tableView dequeueReusableCellWithIdentifier:@"CRStopwatchControlCell"
                                               forIndexPath:indexPath];
        cell.delegate = self;
        return cell;
    } else {
        CRLapOverviewCell* cell = nil;
        cell = [tableView dequeueReusableCellWithIdentifier:@"LapCell"
                                               forIndexPath:indexPath];
        return cell;
    }
}

#pragma mark CRStopwatchControl delegate methods

- (void)stopWatchShouldStartTiming:(CRStopwatchControlCell*)control
{
    [self setupTiming];
}

- (void)stopWatchShouldStopTiming:(CRStopwatchControlCell*)control
{
    [self.timer invalidate];
}

- (void)stopWatchShouldResetTiming:(CRStopwatchControlCell*)control
{
    self.runTime = 0;
    self.lapRunTime = 0;
    [self clearLaps];
    [[self getStopwatchView] updateWithTimeInterval:self.runTime
                                withLapTimeInterval:self.lapRunTime];
}

- (void)stopWatchShouldAddLap:(CRStopwatchControlCell*)control
{
    dispatch_async(dispatch_get_main_queue(), ^(void) {
		[self addLap];
    });
}

@end
