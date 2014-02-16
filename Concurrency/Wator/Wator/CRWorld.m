//
//  CRWorld.m
//  Wator
//
//  Created by Cornelia Rehbein on 16/02/14.
//  Copyright (c) 2014 Cornelia Rehbein. All rights reserved.
//

#import "CRWorld.h"

@implementation CRWorld

- (id)initWithSize:(CGSize)worldSize
{
    self = [super init];
    if (self) {
        self.worldSize = worldSize;
    }
    return self;
}

- (void)loopWithCompletionBlock:(void (^)(void))block
{
	// run thro
}

@end
