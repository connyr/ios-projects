//
//  CRWalker.h
//  NatureOfCode
//
//  Created by Cornelia Rehbein on 08/03/14.
//  Copyright (c) 2014 Cornelia Rehbein. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CRWalker : NSObject

@property(nonatomic) CGPoint pos;
@property(nonatomic) NSInteger walkRange;

- (CGPoint)walk;
- (CGPoint)walk9Directions;

@end
