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

- (CRTimerCell*)getTimer
{
    return (CRTimerCell*)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0
                                                                                 inSection:0]];
}

- (void)timerControlShouldStart:(CRTimerControlCell*)cell
{
    CRTimerCell* timerView = [self getTimer];
    [timerView startTimer];
}

- (void)timerControlShouldStop:(CRTimerControlCell*)cell
{
    CRTimerCell* timerView = [self getTimer];
    [timerView stopTimer];
}

- (void)timerControlShouldPause:(CRTimerControlCell*)cell
{
    CRTimerCell* timerView = [self getTimer];
    [timerView pauseTimer];
}

- (void)timerControlShouldResume:(CRTimerControlCell*)cell
{
    CRTimerCell* timerView = [self getTimer];
    [timerView resumeTimer];
}

@end
