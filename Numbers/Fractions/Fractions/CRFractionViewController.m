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

@end

@implementation CRFractionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)plusButton:(id)sender
{
}
- (IBAction)addFractions:(UIButton*)sender
{
}

- (IBAction)subtractFractions:(id)sender
{
}

- (IBAction)multiplyFractions:(id)sender
{
}

- (IBAction)divideFractions:(UIButton*)sender
{
}

- (IBAction)changeLeftFraction:(id)sender
{
}

- (IBAction)changeRightFraction:(UIButton*)sender
{
}
@end
