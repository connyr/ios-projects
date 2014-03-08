//
//  CRWalkerViewController.m
//  NatureOfCode
//
//  Created by Cornelia Rehbein on 08/03/14.
//  Copyright (c) 2014 Cornelia Rehbein. All rights reserved.
//

#import "CRWalkerViewController.h"
#import "CRWalker.h"
#import "CRWalkerView.h"

@interface CRWalkerViewController ()

@property(nonatomic, strong) CRWalker* walkerModel;
@property(nonatomic, strong) NSTimer* timer;

@property(nonatomic, weak) IBOutlet CRWalkerView* walkerView;

@end

@implementation CRWalkerViewController

- (id)initWithNibName:(NSString*)nibNameOrNil bundle:(NSBundle*)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil
                           bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.walkerModel = [[CRWalker alloc] init];
    [self.walkerModel setPos:CGPointMake(self.view.bounds.size.width / 2,
                                         self.view.bounds.size.height / 2)];
    [self updateWalkerViewWithDirection:CGPointZero];

    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.2
                                                  target:self
                                                selector:@selector(step)
                                                userInfo:nil
                                                 repeats:YES];
}

- (void)step
{
    CGPoint direction = [self.walkerModel walk];
    [self updateWalkerViewWithDirection:direction];
}

- (void)updateWalkerViewWithDirection:(CGPoint)direction
{
    [self.walkerView setDirection:direction];
    [UIView animateWithDuration:0.2
                     animations:^{
		[self.walkerView setCenter:self.walkerModel.pos];
                     }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
