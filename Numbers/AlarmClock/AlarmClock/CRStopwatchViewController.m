//
//  CRStopwatchViewController.m
//  AlarmClock
//
//  Created by Cornelia Rehbein on 14/02/14.
//  Copyright (c) 2014 Cornelia Rehbein. All rights reserved.
//

#import "CRStopwatchViewController.h"

#import "CRStopwatchViewCell.h"
#import "FontAwesomeKit/FontAwesomeKit.h"

@interface CRStopwatchViewController ()

@property(nonatomic, strong) NSTimer* timer;
@property(nonatomic) NSMutableArray* laps;
@property(nonatomic) NSTimeInterval runTime;
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
    [self.tableView registerClass:[UITableViewCell class]
           forCellReuseIdentifier:@"LapCell"];
    self.laps = [[NSMutableArray alloc] init];
}

- (void)updateInBackgroundPerSecond
{
}

- (void)setupTiming
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.01
                                                  target:self
                                                selector:@selector(updateClock)
                                                userInfo:nil
                                                 repeats:YES];
}

- (void)updateClock
{
    self.runTime += 0.01;
    dispatch_async(dispatch_get_main_queue(), ^(void) {
		[[self getStopwatchView] updateTimeWithTimesInterval:self.runTime];
    });
}

- (void)clearLaps
{
    self.laps = [[NSMutableArray alloc] init];
    [self.tableView reloadData];
}

- (void)addLap
{
    [self.laps addObject:[NSNumber
                             numberWithDouble:self.runTime]];
    [self.tableView reloadData];
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

- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath
{
    NSUInteger size = self.tableView.bounds.size.height;
    if (indexPath.section != 2) {
        return size / 3;
    } else {
        return 44;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section != 2) {
        return 1;
    } else
        return self.laps.count;
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
        UITableViewCell* cell = nil;
        cell = [tableView dequeueReusableCellWithIdentifier:@"LapCell"
                                               forIndexPath:indexPath];
        cell.textLabel.text = [NSString stringWithFormat:@"Lap %i", indexPath.row + 1];
        NSNumber* time = (NSNumber*)self.laps[indexPath.row];
        cell.textLabel.text = [CRStopwatchViewCell stringFromTimeInterval:time.doubleValue];
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
    [self clearLaps];
    [[self getStopwatchView] updateTimeWithTimesInterval:self.runTime];
}

- (void)stopWatchShouldAddLap:(CRStopwatchControlCell*)control
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void) {
		[self addLap];
    });
}

@end
