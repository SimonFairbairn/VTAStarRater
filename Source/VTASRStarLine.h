//
//  VTASRStarLine.h
//  VTAStarRater
//
//  Created by Simon Fairbairn on 04/10/2013.
//  Copyright (c) 2013 Simon Fairbairn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VTASRStarView.h"

@class VTASRStarLine;

@protocol VTAStarLineDelegate <NSObject>

@optional

-(void)vtaStarLineDidChangeRating:(VTASRStarLine *)starline;

@end

@interface VTASRStarLine : UIView

@property (nonatomic, weak) id delegate;

@property (nonatomic) NSUInteger rating;
@property (nonatomic, strong) UIColor *underStarColor;


@end
