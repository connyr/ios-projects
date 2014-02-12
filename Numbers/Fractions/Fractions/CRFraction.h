//
//  CRFraction.h
//  Fractions
//
//  Created by Cornelia Rehbein on 11/02/14.
//  Copyright (c) 2014 Cornelia Rehbein. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CRFraction : NSObject

@property(nonatomic) NSInteger numerator;
@property(nonatomic) NSInteger denominator;

- initWithNumerator:(NSInteger)num withDenominator:(NSInteger)denom;
- (CRFraction*)addFraction:(CRFraction*)anotherFraction;
- (CRFraction*)substractFraction:(CRFraction*)anotherFraction;
- (CRFraction*)multiplyWithFraction:(CRFraction*)anotherFraction;
- (CRFraction*)multiplyWithWholeNumber:(NSInteger)number;
- (CRFraction*)divideWithFraction:(CRFraction*)anotherFraction;
- (CRFraction*)divideWithWholeNumber:(NSInteger)number;

@end
