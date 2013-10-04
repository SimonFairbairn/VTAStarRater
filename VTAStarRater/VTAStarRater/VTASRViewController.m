//
//  VTASRViewController.m
//  VTAStarRater
//
//  Created by Simon Fairbairn on 04/10/2013.
//  Copyright (c) 2013 Simon Fairbairn. All rights reserved.
//

#import "VTASRViewController.h"
#import "VTASRStarLine.h"

@interface VTASRViewController ()

@property (nonatomic, strong) IBOutlet VTASRStarLine *starLine;

@end

@implementation VTASRViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)setRating:(UIStepper *)sender {
    

    self.starLine.rating = sender.value;
}

@end
