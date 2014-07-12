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
    [self setupButtons];
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
    [self.frac1 normalize];
    self.leftNumeratorLabel.text = [NSNumber numberWithInt:self.frac1.numerator].stringValue;
    self.leftDenominatorLabel.text = [NSNumber numberWithInt:self.frac1.denominator].stringValue;

    [self.frac2 normalize];
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

- (void)setupButtons{
    [self.plusButton setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    [self.minusButton setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    [self.multiplyButton setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    [self.divideButton setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    [self.leftEditButton setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    [self.rightEditButton setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
}

- (void)parseFractionInput:(NSString*)inputText
{
    NSArray* components = [inputText componentsSeparatedByString:@"/"];
    if (components.count == 2) {
        self.editingFraction.numerator = ((NSString*)components[0]).integerValue;
        self.editingFraction.denominator = ((NSString*)components[1]).integerValue;
        [self updateFractionLabels];
    } else if (inputText.doubleValue) {
        [self.editingFraction setToDecimalValue:inputText.doubleValue];
        [self updateFractionLabels];
    } else {
        [self showParsingAlertWithText:inputText];
    }
}

- (void)showParsingAlertWithText:(NSString*)inputText
{
    UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Could not parse fraction input"
                                                        message:@"An error occured when parsing the input for your fraction. Please try again with a differen entry"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
    [alertView setAlertViewStyle:UIAlertViewStyleDefault];
    [alertView show];
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
