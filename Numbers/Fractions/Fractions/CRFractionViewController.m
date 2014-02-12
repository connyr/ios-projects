//
//  CRFractionViewController.m
//  Fractions
//
//  Created by Cornelia Rehbein on 12/02/14.
//  Copyright (c) 2014 Cornelia Rehbein. All rights reserved.
//

#import "CRFractionViewController.h"

#import "CRFraction.h"

@interface CRFractionViewController ()

@property(strong, nonatomic) CRFraction* frac1;
@property(strong, nonatomic) CRFraction* frac2;
@property(strong, nonatomic) CRFraction* editingFraction;

@end

@implementation CRFractionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.frac1 = [[CRFraction alloc] initWithNumerator:1
                                       withDenominator:5];
    self.frac2 = [[CRFraction alloc] initWithNumerator:3
                                       withDenominator:5];

    self.resultDenominator.text = @"";
    self.resultNumerator.text = @"";

    [self updateFractionLabels];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addFractions:(UIButton*)sender
{
    CRFraction* result = [CRFraction fractionByAdding:self.frac1
                                                   to:self.frac2];
    [self updateResultWithFraction:result];
}

- (IBAction)subtractFractions:(id)sender
{
    CRFraction* result = [CRFraction fractionBySubtracting:self.frac2
                                                      from:self.frac1];
    [self updateResultWithFraction:result];
}

- (IBAction)multiplyFractions:(id)sender
{
    CRFraction* result = [CRFraction fractionByMultiplying:self.frac1
                                                      with:self.frac2];
    [self updateResultWithFraction:result];
}

- (IBAction)divideFractions:(UIButton*)sender
{
    CRFraction* result = [CRFraction fractionByDividing:self.frac1
                                                     by:self.frac2];
    [self updateResultWithFraction:result];
}

- (void)updateResultWithFraction:(CRFraction*)result
{
    self.resultNumerator.text = [NSNumber numberWithInt:result.numerator].stringValue;
    self.resultDenominator.text = [NSNumber numberWithInt:result.denominator].stringValue;
}

- (IBAction)changeLeftFraction:(id)sender
{
    self.editingFraction = self.frac1;
    [self showFractionInput];
}

- (IBAction)changeRightFraction:(UIButton*)sender
{
    self.editingFraction = self.frac2;
    [self showFractionInput];
}

- (void)updateFractionLabels
{
    self.leftNumeratorLabel.text = [NSNumber numberWithInt:self.frac1.numerator].stringValue;
    self.leftDenominatorLabel.text = [NSNumber numberWithInt:self.frac1.denominator].stringValue;

    self.rightNumeratorLabel.text = [NSNumber numberWithInt:self.frac2.numerator].stringValue;
    self.rightDenominatorLabel.text = [NSNumber numberWithInt:self.frac2.denominator].stringValue;
}

- (void)showFractionInput
{
    UIAlertView* inputDialog = [[UIAlertView alloc] initWithTitle:@"Please enter your fraction"
                                                          message:@"You can enter two integers with a slash: 1/4 . Or you can enter a decimal number: 2.75 "
                                                         delegate:self
                                                cancelButtonTitle:@"Cancel"
                                                otherButtonTitles:@"OK", nil];
    [inputDialog setAlertViewStyle:UIAlertViewStylePlainTextInput];

    UITextField* textField = [inputDialog textFieldAtIndex:0];
    textField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;

    [inputDialog show];
}

- (void)parseFractionInput:(NSString*)inputText
{
    if (inputText.doubleValue) {
        [self.editingFraction setToDecimalValue:inputText.doubleValue];
        [self updateFractionLabels];
    }

    // check
}

#pragma mark UIAlertView delegate methods
- (void)alertView:(UIAlertView*)alertView
    clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) // cancel
    {
        return;
    } else {
        [self parseFractionInput:[alertView textFieldAtIndex:0].text];
    }
}
@end
