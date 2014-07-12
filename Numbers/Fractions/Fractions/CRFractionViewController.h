//
//  CRFractionViewController.h
//  Fractions
//
//  Created by Cornelia Rehbein on 12/02/14.
//  Copyright (c) 2014 Cornelia Rehbein. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CRFractionViewController : UIViewController <UIAlertViewDelegate>

@property(weak, nonatomic) IBOutlet UILabel* leftNumeratorLabel;
@property(weak, nonatomic) IBOutlet UILabel* leftDenominatorLabel;

@property(weak, nonatomic) IBOutlet UILabel* rightNumeratorLabel;
@property(weak, nonatomic) IBOutlet UILabel* rightDenominatorLabel;

@property(weak, nonatomic) IBOutlet UILabel* resultNumerator;
@property(weak, nonatomic) IBOutlet UILabel* resultDenominator;
@property (weak, nonatomic) IBOutlet UIButton *plusButton;
@property (weak, nonatomic) IBOutlet UIButton *minusButton;
@property (weak, nonatomic) IBOutlet UIButton *divideButton;
@property (weak, nonatomic) IBOutlet UIButton *multiplyButton;
@property (weak, nonatomic) IBOutlet UIButton *leftEditButton;
@property (weak, nonatomic) IBOutlet UIButton *rightEditButton;

- (IBAction)addFractions:(UIButton*)sender;
- (IBAction)subtractFractions:(UIButton*)sender;
- (IBAction)multiplyFractions:(UIButton*)sender;
- (IBAction)divideFractions:(UIButton*)sender;

- (IBAction)changeLeftFraction:(UIButton*)sender;
- (IBAction)changeRightFraction:(UIButton*)sender;

@end
