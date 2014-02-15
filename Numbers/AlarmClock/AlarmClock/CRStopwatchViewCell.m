//
//  CStopwatchViewCell.m
//  AlarmClock
//
//  Created by Cornelia Rehbein on 15/02/14.
//  Copyright (c) 2014 Cornelia Rehbein. All rights reserved.
//

#import "CRStopwatchViewCell.h"

@interface CRStopwatchViewCell ()

@property(nonatomic, strong) NSDateFormatter* dateFormatter;

@end

@implementation CRStopwatchViewCell

+ (NSString*)stringFromTimeInterval:(NSTimeInterval)time
{
    NSMutableString* output = [[NSMutableString alloc] init];
    unsigned long roundedMilliseconds = time * 100;
    unsigned long seconds = time;
    unsigned long minutes = seconds / 60;
    seconds %= 60;
    unsigned long hours = minutes / 60;
    minutes %= 60;
    roundedMilliseconds %= 100;

    [output appendFormat:@"%02lu:", hours];
    [output appendFormat:@"%02lu:", minutes];
    [output appendFormat:@"%02lu", seconds];
    [output appendFormat:@".%02lu", roundedMilliseconds];

    return output;
}

- (void)awakeFromNib
{
    [self setupTimeLabel];
    self.dateFormatter = [[NSDateFormatter alloc] init];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
}

- (void)setupTimeLabel
{
    [self.timeLabel setFrame:self.contentView.bounds];
    [self.timeLabel setTextAlignment:NSTextAlignmentCenter];
    UIFont* font = [UIFont systemFontOfSize:40];
    [self.timeLabel setFont:font];
    [self updateTimeWithTimesInterval:0];
}

- (void)updateTimeWithTimesInterval:(NSTimeInterval)timePassed;
{
    self.timeLabel.text = [CRStopwatchViewCell stringFromTimeInterval:timePassed];
}

@end
