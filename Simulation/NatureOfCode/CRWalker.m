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

- (void)walk
{
    NSInteger x = self.pos.x;
    NSInteger y = self.pos.y;
    NSInteger direction = arc4random_uniform(4);
    if (direction == 0) {
        x++;
    } else if (direction == 1) {
        x--;
    } else if (direction == 2) {
        y++;
    } else {
        y--;
    }

    self.pos = CGPointMake(x, y);
}

@end
