//
//  CRTimeRangePickerCell.h
//  AlarmClock
//
//  Created by Cornelia Rehbein on 13/02/14.
//  Copyright (c) 2014 Cornelia Rehbein. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CRTimeCell : UITableViewCell

@property(strong, nonatomic) UILabel* countDownLabel;
@property(strong, nonatomic) UIDatePicker* timePicker;

- (void)startTimer;
- (void)stopTimer;

- (void)pauseTimer;
- (void)resumeTimer;

@end
