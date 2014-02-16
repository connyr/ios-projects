//
//  CRLifeform.m
//  Wator
//
//  Created by Cornelia Rehbein on 16/02/14.
//  Copyright (c) 2014 Cornelia Rehbein. All rights reserved.
//

#import "CRLifeform.h"

@implementation CRLifeform

- (void)swim
{
    NSLog(@"%f %f swam", self.pos.x, self.pos.y);
}

- (void)breed
{
    self.breedCounter++;
}

- (void)die
{
    NSLog(@"%f %f died", self.pos.x, self.pos.y);
}

@end
