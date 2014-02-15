//
//  CRStopwatchViewController.h
//  AlarmClock
//
//  Created by Cornelia Rehbein on 14/02/14.
//  Copyright (c) 2014 Cornelia Rehbein. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CRStopwatchControlCell.h"

@interface CRStopwatchViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, CRStopWatchControlDelegate>

- (void)updateInBackgroundPerSecond;

@end
