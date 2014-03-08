//
//  CRWalkerViewController.m
//  NatureOfCode
//
//  Created by Cornelia Rehbein on 08/03/14.
//  Copyright (c) 2014 Cornelia Rehbein. All rights reserved.
//

#import "CRWalkerViewController.h"
#import "CRWalker.h"

@interface CRWalkerViewController ()

@property(nonatomic, strong) CRWalker* walkerModel;
@property(nonatomic, strong) NSTimer* timer;

@property(nonatomic, weak) IBOutlet UIView* walkerView;

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
    [self updateWalkerView];

    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.2
                                                  target:self
                                                selector:@selector(step)
                                                userInfo:nil
                                                 repeats:YES];
}

- (void)step
{
    NSLog(@"stepping");
    CGPoint direction = [self.walkerModel walk];
    // ignore direction for now?
    [self updateWalkerView];
    [self showDirection:direction];
}

- (void)updateWalkerView
{
    [self.walkerView setCenter:self.walkerModel.pos];
}

- (void)showDirection:(CGPoint)direction
{
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
