//
//  CRStopwatchControlCell.h
//  AlarmClock
//
//  Created by Cornelia Rehbein on 15/02/14.
//  Copyright (c) 2014 Cornelia Rehbein. All rights reserved.
//
#import <UIKit/UIKit.h>

@class CRStopwatchControlCell;

@protocol CRStopWatchControlDelegate <NSObject>

@required
- (void)stopWatchShouldStartTiming:(CRStopwatchControlCell*)control;
- (void)stopWatchShouldStopTiming:(CRStopwatchControlCell*)control;
- (void)stopWatchShouldResetTiming:(CRStopwatchControlCell*)control;
- (void)stopWatchShouldAddLap:(CRStopwatchControlCell*)control;

@end

@interface CRStopwatchControlCell : UITableViewCell

@property(weak, nonatomic) id<CRStopWatchControlDelegate> delegate;

@property(weak, nonatomic) IBOutlet UIButton* rightButton;
@property(weak, nonatomic) IBOutlet UIButton* leftButton;

@end
