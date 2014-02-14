//
//  CRTimerControlCell.h
//  AlarmClock
//
//  Created by Cornelia Rehbein on 13/02/14.
//  Copyright (c) 2014 Cornelia Rehbein. All rights reserved.
//

@class CRTimerControlCell;

@protocol CRTimerControlCellDelegate <NSObject>

@required
- (void)timerControlShouldStart:(CRTimerControlCell*)cell;
- (void)timerControlShouldPause:(CRTimerControlCell*)cell;
- (void)timerControlShouldStop:(CRTimerControlCell*)cell;
- (void)timerControlShouldResume:(CRTimerControlCell*)cell;

@end

#import <UIKit/UIKit.h>

@interface CRTimerControlCell : UITableViewCell

@property(strong, nonatomic) UIButton* leftButton;
@property(strong, nonatomic) UIButton* rightButton;

@property(weak, nonatomic) id<CRTimerControlCellDelegate> delegate;
@end
