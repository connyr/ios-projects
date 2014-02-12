//
//  CRFraction.m
//  Fractions
//
//  Created by Cornelia Rehbein on 11/02/14.
//  Copyright (c) 2014 Cornelia Rehbein. All rights reserved.
//

#import "CRFraction.h"

@interface CRFraction ()

@end

@implementation CRFraction

- initWithNumerator:(NSInteger)num withDenominator:(NSInteger)denom
{
    self = [super init];
    if (self) {
        self.numerator = num;
        self.denominator = denom;
    }
    return self;
}

- initWithDecimal:(double)decimalValue
{
    self = [super init];
    if (self) {
        [self setToDecimalValue:decimalValue];
    }
    return self;
}

- (CRFraction*)addFraction:(CRFraction*)anotherFraction
{
    CRFraction* result = [CRFraction fractionByAdding:anotherFraction
                                                   to:self];
    [self copyValuesFromFraction:result];
    return self;
}

- (CRFraction*)subtractFraction:(CRFraction*)anotherFraction
{
    CRFraction* result = [CRFraction fractionBySubtracting:anotherFraction
                                                      from:self];
    [self copyValuesFromFraction:result];
    return self;
}

- (CRFraction*)multiplyWithFraction:(CRFraction*)anotherFraction
{
    CRFraction* result = [CRFraction fractionByMultiplying:self
                                                      with:anotherFraction];
    [self copyValuesFromFraction:result];
    return self;
}

- (CRFraction*)divideWithFraction:(CRFraction*)anotherFraction
{
    CRFraction* result = [CRFraction fractionByDividing:self
                                                     by:anotherFraction];
    [self copyValuesFromFraction:result];
    return self;
}

- (double)decimalValue
{
    double value = (double)self.numerator / self.denominator;
    return value;
}

- (void)setToDecimalValue:(double)decimal;
{
    self.numerator = floor(decimal * 1000000);
    self.denominator = 1000000;
    [self simplify];
}

#pragma mark Utilities

- (void)normalize
{
    if (self.denominator < 0) {
        self.numerator = -self.numerator;
        self.denominator = -self.denominator;
    }
    [self simplify];
    [self setMixedFractionValues];
}

- (void)simplify
{
    NSInteger gcd = [self greatestCommonDividerForNumber:self.numerator
                                              withNumber:self.denominator];
    self.numerator /= gcd;
    self.denominator /= gcd;
}

- (NSInteger)leastCommonMultipleForFraction:(CRFraction*)frac1 withFraction:(CRFraction*)frac2
{
    NSInteger gcd = [self greatestCommonDividerForNumber:frac1.denominator
                                              withNumber:frac2.denominator];
    NSInteger lcm = (frac1.numerator / gcd) * frac2.numerator;

    return lcm;
}

- (NSInteger)greatestCommonDividerForNumber:(NSInteger)num1 withNumber:(NSInteger)num2
{
    while (num2 != 0) {
        NSInteger remainder = num1 % num2;
        num1 = num2;
        num2 = remainder;
    }
    return num1;
}

- (void)setMixedFractionValues
{
    CRFraction* mixedFraction = [[CRFraction alloc] initWithNumerator:self.numerator
                                                      withDenominator:self.denominator];

    NSInteger factor = mixedFraction.numerator / mixedFraction.denominator;
    if (factor == 0) {
        self.mixedWholeNumber = 0;
        return;
    } else {
        mixedFraction.mixedWholeNumber = factor;
        mixedFraction.numerator -= factor * mixedFraction.denominator;
    }
}

- (void)copyValuesFromFraction:(CRFraction*)result
{
    self.numerator = result.numerator;
    self.denominator = result.denominator;
}

#pragma mark class functions

+ (CRFraction*)fractionByAdding:(CRFraction*)op1
                             to:(CRFraction*)op2
{
    CRFraction* result = [[CRFraction alloc] init];
    if (op1.denominator == op2.denominator) {
        result.numerator = op1.numerator + op2.numerator;
        result.denominator = op1.denominator;
    } else {
        // Find a common denominator with the crossproduct
        result.numerator = (op1.numerator * op2.denominator) + (op1.denominator * op2.numerator);
        result.denominator = op1.denominator * op2.denominator;
    }
    [result normalize];
    return result;
}

+ (CRFraction*)fractionBySubtracting:(CRFraction*)op1 from:(CRFraction*)op2
{
    CRFraction* result = [[CRFraction alloc] init];
    if (op1.denominator == op2.denominator) {
        result.numerator = op2.numerator - op1.numerator;
        result.denominator = op2.denominator;
    } else {
        // Find a common denominator with the crossproduct
        result.numerator = (op1.denominator * op2.numerator) - (op1.numerator * op2.denominator);
        result.denominator = op1.denominator * op2.denominator;
    }
    [result normalize];
    return result;
}

+ (CRFraction*)fractionByMultiplying:(CRFraction*)op1 with:(CRFraction*)op2
{
    CRFraction* result = [[CRFraction alloc] init];
    result.numerator = op1.numerator * op2.numerator;
    result.denominator = op1.denominator * op2.denominator;
    [result normalize];
    return result;
}

+ (CRFraction*)fractionByDividing:(CRFraction*)op1 by:(CRFraction*)op2
{
    // reciprocal
    CRFraction* temp = [[CRFraction alloc] initWithNumerator:op2.denominator
                                             withDenominator:op2.numerator];

    CRFraction* result = [CRFraction fractionByMultiplying:op1
                                                      with:temp];
    return result;
}

@end