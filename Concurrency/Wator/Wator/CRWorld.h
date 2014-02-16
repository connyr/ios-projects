//
//  CRWorld.h
//  Wator
//
//  Created by Cornelia Rehbein on 16/02/14.
//  Copyright (c) 2014 Cornelia Rehbein. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CRWorld : NSObject

@property(atomic, strong) NSMutableArray* currentLifeForms;
@property(nonatomic) CGSize worldSize;

- (id)initWithSize:(CGSize)worldSize;

// loops over all lifeforms and
- (void)loopWithCompletionBlock:(void (^)(void))block;

@end
