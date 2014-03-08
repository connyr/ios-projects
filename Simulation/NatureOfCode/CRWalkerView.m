//
//  CRWalkerView.m
//  NatureOfCode
//
//  Created by Cornelia Rehbein on 08/03/14.
//  Copyright (c) 2014 Cornelia Rehbein. All rights reserved.
//

#import "CRWalkerView.h"

@implementation CRWalkerView

- (void)awakeFromNib
{
    [self setOpaque:NO];
    self.backgroundColor = [UIColor clearColor];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setOpaque:NO];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)setDirection:(CGPoint)direction
{
    _direction = direction;
    [self setNeedsDisplay];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();

    CGContextSetLineWidth(context, 2.0);
    CGContextSetFillColorWithColor(context, [UIColor blackColor].CGColor);
    CGContextSetStrokeColorWithColor(context, [UIColor grayColor].CGColor);

    CGRect ellipseBounds = CGRectInset(rect, rect.size.width / 3, rect.size.width / 3);
    CGContextFillEllipseInRect(context, ellipseBounds);
    CGContextStrokeRect(context, rect);

    CGFloat normalizedXDirection = (self.direction.x + 1) / 2;
    CGFloat normalizedYDirection = (self.direction.y + 1) / 2;

    CGPoint outerContactPoint = CGPointMake(rect.size.width * normalizedXDirection, rect.size.height * normalizedYDirection);
    CGContextMoveToPoint(context, outerContactPoint.x, outerContactPoint.y);
    CGContextAddLineToPoint(context, rect.size.width / 2, rect.size.height / 2);
    CGContextStrokePath(context);

    // Drawing code
}

@end
