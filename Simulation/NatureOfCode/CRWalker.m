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

- (CGPoint)walk
{
    NSInteger x = arc4random_uniform(3) - 1;
    NSInteger y = arc4random_uniform(3) - 1;

    self.pos = CGPointMake(self.pos.x + x, self.pos.y + y);
    return CGPointMake(x, y);
}

@end
