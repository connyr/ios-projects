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

// only for display, not used in calculations
@property(nonatomic) NSInteger mixedWholeNumber;
@property(nonatomic) NSInteger mixedNumerator;
@property(nonatomic) NSInteger mixedDenominator;

- initWithNumerator:(NSInteger)num withDenominator:(NSInteger)denom;

- (CRFraction*)addFraction:(CRFraction*)anotherFraction;
- (CRFraction*)subtractFraction:(CRFraction*)anotherFraction;
- (CRFraction*)multiplyWithFraction:(CRFraction*)anotherFraction;
- (CRFraction*)divideWithFraction:(CRFraction*)anotherFraction;

+ (CRFraction*)fractionByAdding:(CRFraction*)op1 to:(CRFraction*)op2;
+ (CRFraction*)fractionBySubtracting:(CRFraction*)op1 from:(CRFraction*)op2;
+ (CRFraction*)fractionByMultiplying:(CRFraction*)op1 with:(CRFraction*)op2;
+ (CRFraction*)fractionByDividing:(CRFraction*)op1 by:(CRFraction*)op2;

- (void)normalize;
- (double)decimalValue;
- (void)setToDecimalValue:(double)decimal;
@end
