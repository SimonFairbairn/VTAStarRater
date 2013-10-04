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


@end

@implementation VTASRStarLine


#pragma mark - Properties

-(void)setRating:(NSUInteger)rating {
    _rating = rating;
    [self setNeedsDisplay];
}


-(void)setLastPosition:(CGFloat)lastPosition {
    
    CGFloat newPos;
    CGFloat width = (self.bounds.size.width / 10 );
    
    CGFloat tempPos = lastPosition / width;
    

    if ( tempPos > 0.5 ) {
        self.rating = ceil(tempPos);
    } else {
        self.rating = floor(tempPos);
    }
    
    
    newPos = self.rating * width;
    
    _lastPosition = newPos;
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

}



// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    
    CGRect backgroundFrame = self.bounds;
    CGRect fullBackgroundFrame = backgroundFrame;
    
    CGFloat width = (self.bounds.size.width / 10 );
    
    backgroundFrame.size.width = self.rating * width;

    
    CGRect starBounds = self.bounds;
    starBounds.size.width = floor(self.bounds.size.width / 5);
    
    // Drawing code
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    UIBezierPath *starPath = [[UIBezierPath alloc] init];
    
    for ( int i = 0; i < 5; i++ ) {
        

        
        UIBezierPath *path = [[UIBezierPath alloc] init];
        
        CGFloat quarter = floor(CGRectGetWidth(starBounds) / 8);
        CGFloat third = floor(CGRectGetWidth(starBounds) / 3);
        //    CGFloat diff = floor( (third / 4) * 3 );
        
        [path moveToPoint:CGPointMake(CGRectGetMidX(starBounds), 0.0)];
        [path addLineToPoint:CGPointMake(starBounds.origin.x + quarter, CGRectGetHeight(starBounds))];
        //    [path addLineToPoint:CGPointMake(CGRectGetMidX(self.bounds), third * 2)];
        //    [path addLineToPoint:CGPointMake(CGRectGetMidX(self.bounds), third + diff)];
        
        [path addLineToPoint:CGPointMake(starBounds.origin.x + CGRectGetWidth(starBounds), third)];
        [path addLineToPoint:CGPointMake(starBounds.origin.x, third)];
        
        //    [path addLineToPoint:CGPointMake(CGRectGetMidX(self.bounds), third + diff)];
        //    [path addLineToPoint:CGPointMake(CGRectGetMidX(self.bounds), third * 2)];
        [path addLineToPoint:CGPointMake(starBounds.origin.x + (quarter * 7), CGRectGetHeight(starBounds))];
        [path closePath];
        
        starBounds.origin.x = starBounds.origin.x + starBounds.size.width;
        
        [starPath appendPath:path];
        
    }
    [starPath addClip];
    
    UIBezierPath *fullBackground = [UIBezierPath bezierPathWithRect:fullBackgroundFrame];
    [[UIColor blackColor] setFill];
    [fullBackground fill];

    
    UIBezierPath *background = [UIBezierPath bezierPathWithRect:backgroundFrame];
    [self.tintColor setFill];
    [background fill];

    
    CGContextAddPath(ctx, starPath.CGPath);
    CGContextAddPath(ctx, background.CGPath);
//    CGContextAddPath(ctx, fullBackground.CGPath);
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self updatePositionWithTouches:touches];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [self updatePositionWithTouches:touches];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self updatePositionWithTouches:touches];
}

-(void)updatePositionWithTouches:(NSSet *)touches {
    CGPoint locationInView = [[touches anyObject] locationInView:self];
    self.lastPosition = locationInView.x;
    [self setNeedsDisplay];
}



@end
