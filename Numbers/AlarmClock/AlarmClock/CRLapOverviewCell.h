//
//  CRLabOverviewCell.h
//  AlarmClock
//
//  Created by Cornelia Rehbein on 16/02/14.
//  Copyright (c) 2014 Cornelia Rehbein. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CRLapOverviewCell : UITableViewCell <UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong) NSMutableArray* laps;
@property(nonatomic, weak) IBOutlet UITableView* tableView;

@end
