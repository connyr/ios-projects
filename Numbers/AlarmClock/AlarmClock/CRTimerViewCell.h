//
//  CRTimeRangePickerCell.h
//  AlarmClock
//
//  Created by Cornelia Rehbein on 13/02/14.
//  Copyright (c) 2014 Cornelia Rehbein. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CRTimerViewCell : UITableViewCell

@property(weak, nonatomic) IBOutlet UILabel* countDownLabel;
@property(weak, nonatomic) IBOutlet UIDatePicker* timePicker;

- (NSTimeInterval)currentTimeInterval;

- (void)startTimerWithTimeInterval:(NSTimeInterval)timeInSeconds;
- (void)updateTimerWithTimeInterval:(NSTimeInterval)remainingTimeInSeconds;
- (void)stopTimer;

@end
