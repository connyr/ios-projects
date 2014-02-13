//
//  CRTimerViewController.h
//  AlarmClock
//
//  Created by Cornelia Rehbein on 12/02/14.
//  Copyright (c) 2014 Cornelia Rehbein. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CRTimerControlCell.h"

@interface CRTimerViewController : UIViewController <UITableViewDelegate, CRTimerControlCellProtocol, UITableViewDataSource>

@property(weak, nonatomic) IBOutlet UITableView* tableView;

@end
