//
//  CRTimerViewController.h
//  AlarmClock
//
//  Created by Cornelia Rehbein on 12/02/14.
//  Copyright (c) 2014 Cornelia Rehbein. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CRTimerControlCell.h"
#import <AVFoundation/AVFoundation.h>

@interface CRTimerViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, AVAudioPlayerDelegate, UIAlertViewDelegate, CRTimerControlCellDelegate>

@property(weak, nonatomic) IBOutlet UITableView* tableView;


- (void)updateInBackgroundPerSecond;


@end
