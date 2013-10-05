//
//  VTASRStarLine.m
//  VTAStarRater
//
//  Created by Simon Fairbairn on 04/10/2013.
//  Copyright (c) 2013 Simon Fairbairn. All rights reserved.
//

#import "VTASRStarLine.h"


@interface VTASRStarLine ()

@property (nonatomic) CGFloat lastPosition;

@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, strong) VTASRStarView *stars;

@end

@implementation VTASRStarLine

@synthesize underStarColor = _underStarColor;

#pragma mark - Properties

-(void)setUnderStarColor:(UIColor *)underStarColor {
    _underStarColor = underStarColor;
    self.backgroundColor = underStarColor;
}

-(UIColor *)underStarColor {
    if ( !_underStarColor ) {
        float h,s,b,a;
        [self.tintColor getHue:&h saturation:&s brightness:&b alpha:&a];
        
        _underStarColor = [UIColor colorWithHue:h saturation:s brightness:b * 0.5 alpha:a];
        
    }
    return _underStarColor;
}


-(void)setRating:(NSUInteger)rating {
    _rating = rating;
    CGFloat width = CGRectGetWidth(self.bounds) / 10;
    CGRect backgroundFrame = self.backgroundView.frame;
    backgroundFrame.size.width = width * rating;
    self.backgroundView.frame = backgroundFrame;
    
}


-(void)setLastPosition:(CGFloat)lastPosition {
    
    _lastPosition = lastPosition;
}

-(UIView *)backgroundView {
    if ( !_backgroundView ) {
        _backgroundView = [[UIView alloc] initWithFrame:self.bounds];
        _backgroundView.backgroundColor = self.tintColor;
    }
    return _backgroundView;
}

-(VTASRStarView *)stars {
    if ( !_stars ) {
        _stars = [[VTASRStarView alloc] initWithFrame:self.bounds];
        _stars.numberOfStars = 5;
    }
    return _stars;
}


#pragma mark - Initialisation

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setup];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if ( self ) {
        [self setup];
    }
    return self;
}

-(void)setup {
    [self addSubview:self.backgroundView];
    [self addSubview:self.stars];
    self.stars.frameColor = self.backgroundColor;
    self.backgroundColor = self.underStarColor;
}

#pragma mark - Touches

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self updatePositionWithTouches:touches didFinish:NO];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [self updatePositionWithTouches:touches didFinish:NO];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self updatePositionWithTouches:touches didFinish:YES];
    
}

-(void)updatePositionWithTouches:(NSSet *)touches didFinish:(BOOL)finish {
    
    CGPoint locationInView = [[touches anyObject] locationInView:self];
    self.lastPosition = locationInView.x;
    if ( self.lastPosition >= CGRectGetWidth(self.bounds)) self.lastPosition = CGRectGetWidth(self.bounds);
    
    if ( finish ) {
        CGFloat width = (self.bounds.size.width / 10 );
        CGFloat tempPos = self.lastPosition / width;
        NSUInteger rating;
        int beforeDecimal = (int)tempPos;
        float noInt = tempPos - beforeDecimal;
        if ( noInt > 0.5 ) {
            rating = ceil(tempPos);
        } else {
            rating = floor(tempPos);
        }
        
        self.lastPosition = rating * width;
        [UIView animateWithDuration:0.3 animations:^{
            [self updateBackground];
        } completion:^(BOOL finished) {
            self.rating = rating;
            if ( [self.delegate respondsToSelector:@selector(vtaStarLineDidChangeRating:)]) {
                [self.delegate vtaStarLineDidChangeRating:self];
            }
            
        }];
    } else {
        [self updateBackground];
    }
}

-(void) updateBackground {
    CGRect backgroundViewFrame = self.backgroundView.frame;
    backgroundViewFrame.size.width = self.lastPosition;
    self.backgroundView.frame = backgroundViewFrame;
    
}


@end
