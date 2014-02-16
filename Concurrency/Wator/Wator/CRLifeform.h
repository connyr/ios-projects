//
//  CRLifeform.h
//  Wator
//
//  Created by Cornelia Rehbein on 16/02/14.
//  Copyright (c) 2014 Cornelia Rehbein. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CRLifeform : NSObject

@property(nonatomic) NSUInteger breedCounter;

@property(atomic) CGPoint pos;

- (void)swim;
- (void)die;
- (void)breed;

@end
