//
//  CRLabOverviewCell.m
//  AlarmClock
//
//  Created by Cornelia Rehbein on 16/02/14.
//  Copyright (c) 2014 Cornelia Rehbein. All rights reserved.
//

#import "CRLapOverviewCell.h"

@interface CRLapOverviewCell ()

@end

@implementation CRLapOverviewCell

- (void)awakeFromNib
{
    self.tableView.dataSource = self;
    [self.tableView registerClass:[UITableViewCell class]
           forCellReuseIdentifier:@"LapDetailCell"];

    self.laps = [[NSMutableArray alloc] init];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
}

- (void)setLaps:(NSMutableArray*)laps
{
    _laps = laps;
    [self.tableView reloadData];
}

#pragma mark UITableview datasource methods

- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.laps.count;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"LapDetailCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:@"LapDetailCell"];
    }
    cell.textLabel.text = self.laps[indexPath.row];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"Lap %li", indexPath.row + 1];

    return cell;
}

@end
