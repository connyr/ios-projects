//
//  CRAlarmClockViewController.m
//  AlarmClock
//
//  Created by Cornelia Rehbein on 12/02/14.
//  Copyright (c) 2014 Cornelia Rehbein. All rights reserved.
//

#import "CRAlarmClockViewController.h"

#import "FontAwesomeKit/FontAwesomeKit.h"

@interface CRAlarmClockViewController ()

@end

@implementation CRAlarmClockViewController

- (void)awakeFromNib
{
    self.title = @"Alarms";
    FAKFontAwesome* horn = [FAKFontAwesome bullhornIconWithSize:15];
    self.tabBarItem.image = [horn imageWithSize:CGSizeMake(15, 15)];
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

@end
