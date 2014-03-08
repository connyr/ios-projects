//
//  CRWalker.m
//  NatureOfCode
//
//  Created by Cornelia Rehbein on 08/03/14.
//  Copyright (c) 2014 Cornelia Rehbein. All rights reserved.
//

#import "CRWalker.h"

@interface CRWalker ()

@end

@implementation CRWalker

- (id)init
{
    self = [super init];
    if (self) {
        self.walkRange = 10;
    }
    return self;
}

- (CGPoint)walk
{
    double x = (drand48() * 2) - 1;
    double y = (drand48() * 2) - 1;

    [self movePosWithDirectionVector:CGPointMake(x, y)];
    return CGPointMake(x, y);
}

- (CGPoint)walk9Directions
{
    NSInteger x = arc4random_uniform(3) - 1;
    NSInteger y = arc4random_uniform(3) - 1;

    [self movePosWithDirectionVector:CGPointMake(x, y)];
    return CGPointMake(x, y);
}

- (void)movePosWithDirectionVector:(CGPoint)direction
{
    self.pos = CGPointMake(self.pos.x + direction.x * self.walkRange,
                           self.pos.y + direction.y * self.walkRange);
}

@end
