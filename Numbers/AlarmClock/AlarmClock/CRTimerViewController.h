//
//  CRTimerViewController.h
//  AlarmClock
//
//  Created by Cornelia Rehbein on 12/02/14.
//  Copyright (c) 2014 Cornelia Rehbein. All rights reserved.
//

#import "CRTimerControlCell.h"

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface CRTimerViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, AVAudioPlayerDelegate, UIAlertViewDelegate, CRTimerControlCellDelegate>
//- (void)updateInBackgroundPerSecond;

@end
