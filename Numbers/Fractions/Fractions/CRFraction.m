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

- (CRFraction*)
    addFraction:(CRFraction*)anotherFraction
{
    if (self.denominator == anotherFraction.denominator) {
        self.numerator += anotherFraction.numerator;
    } else {
        // Find a common denominator with the crossproduct
        self.numerator = (self.numerator * anotherFraction.denominator) + (self.denominator * anotherFraction.numerator);
        self.denominator = self.denominator * anotherFraction.denominator;
        [self normalize];
    }
    return self;
}

- (CRFraction*)substractFraction:(CRFraction*)anotherFraction
{
    if (self.denominator == anotherFraction.denominator) {
        self.numerator -= anotherFraction.numerator;
    } else {
        // Find a common denominator with the crossproduct
        self.numerator = (self.numerator * anotherFraction.denominator) - (self.denominator * anotherFraction.numerator);
        self.denominator = self.denominator * anotherFraction.denominator;
    }
    [self normalize];
    return self;
}

- (CRFraction*)multiplyWithFraction:(CRFraction*)anotherFraction
{
    self.numerator *= anotherFraction.numerator;
    self.denominator *= anotherFraction.denominator;
    [self normalize];
    return self;
}

- (CRFraction*)multiplyWithWholeNumber:(NSInteger)number
{
    self.numerator *= number;
    [self normalize];
    return self;
}

- (CRFraction*)divideWithFraction:(CRFraction*)anotherFraction
{
    // reciprocal
    NSInteger temp = self.numerator;
    self.numerator = self.denominator;
    self.denominator = temp;

    return [self multiplyWithFraction:anotherFraction];
}

- (CRFraction*)divideWithWholeNumber:(NSInteger)number
{
    self.denominator /= number;
    [self normalize];
    return self;
}

#pragma mark Utilities

- (void)normalize
{
    if (self.denominator < 0) {
        self.numerator = -self.numerator;
        self.denominator = -self.denominator;
    }
}

@end