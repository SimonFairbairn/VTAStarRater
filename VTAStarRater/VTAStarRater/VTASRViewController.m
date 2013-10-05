//
//  VTASRViewController.m
//  VTAStarRater
//
//  Created by Simon Fairbairn on 04/10/2013.
//  Copyright (c) 2013 Simon Fairbairn. All rights reserved.
//

#import "VTASRViewController.h"

@interface VTASRViewController ()

@property (nonatomic, weak) IBOutlet VTASRStarLine *starLine;
@property (nonatomic, weak) IBOutlet UIStepper *stepper;

@end

@implementation VTASRViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.starLine.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)setRating:(UIStepper *)sender {
    

    self.starLine.rating = sender.value;
}

-(void)vtaStarLineDidChangeRating:(VTASRStarLine *)starline {
    
    self.stepper.value = starline.rating;
}

@end
