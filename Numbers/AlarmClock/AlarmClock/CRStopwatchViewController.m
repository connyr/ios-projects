//
//  CRStopwatchViewController.m
//  AlarmClock
//
//  Created by Cornelia Rehbein on 14/02/14.
//  Copyright (c) 2014 Cornelia Rehbein. All rights reserved.
//

#import "CRStopwatchViewController.h"

#import "FontAwesomeKit/FontAwesomeKit.h"

@interface CRStopwatchViewController ()

@property(weak, nonatomic) IBOutlet UITableView* tableView;
@property(nonatomic) NSUInteger numLaps;

@end

@implementation CRStopwatchViewController

- (void)awakeFromNib
{
    self.tabBarItem.title = @"Stopwatch";
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


#pragma mark UITableView delegate

@end
