//
//  CStopwatchViewCell.h
//  AlarmClock
//
//  Created by Cornelia Rehbein on 15/02/14.
//  Copyright (c) 2014 Cornelia Rehbein. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CRStopwatchViewCell : UITableViewCell

@property(weak, nonatomic) IBOutlet UILabel* timeLabel;

- (void)updateTimeWithTimesInterval:(NSTimeInterval)timePassed;
+ (NSString*)stringFromTimeInterval:(NSTimeInterval)time;

@end
