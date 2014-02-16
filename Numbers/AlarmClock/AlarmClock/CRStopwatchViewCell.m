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
    self.dateFormatter = [[NSDateFormatter alloc] init];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self updateWithTimeInterval:0
             withLapTimeInterval:0];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
}

- (void)updateWithTimeInterval:(NSTimeInterval)timePassed withLapTimeInterval:(NSTimeInterval)lapTimePassed;
{
    self.timeLabel.text = [CRStopwatchViewCell stringFromTimeInterval:timePassed];
    self.lapTimeLabel.text = [CRStopwatchViewCell stringFromTimeInterval:lapTimePassed];
}

@end
