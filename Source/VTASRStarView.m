//
//  VTASRStarView.m
//  VTAStarRater
//
//  Created by Simon Fairbairn on 05/10/2013.
//  Copyright (c) 2013 Simon Fairbairn. All rights reserved.
//

#import "VTASRStarView.h"

@interface VTASRStarView ()


@end

@implementation VTASRStarView

@synthesize numberOfStars = _numberOfStars;

#pragma mark - Properties

-(void)setNumberOfStars:(NSUInteger)numberOfStars {
    _numberOfStars = numberOfStars;
    [self setNeedsDisplay];
}

-(NSUInteger)numberOfStars {
    if ( _numberOfStars == 0 ) _numberOfStars = 5;
    return _numberOfStars;
}

-(void)setFrameColor:(UIColor *)frameColor {
    _frameColor  = frameColor;
    [self setNeedsDisplay];
}

#pragma mark - Initialisation

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

-(void)setup {
        self.backgroundColor = [UIColor clearColor];
}

#pragma mark - Drawing

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGFloat inset = 5.0f;
    
    // Surrounding rectangle
    CGPoint topLeft = CGPointMake(0, 0);
    CGPoint topRight = CGPointMake(CGRectGetWidth(self.bounds), 0.0f);
    CGPoint bottomRight = CGPointMake(CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds));
    CGPoint bottomLeft = CGPointMake(0.0f, CGRectGetHeight(self.bounds));
    
    // Create Path
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    // Draw rectangle
    [path moveToPoint:topLeft];
    [path addLineToPoint:bottomLeft];
    [path addLineToPoint:bottomRight];
    [path addLineToPoint:topRight];
    
    UIColor *color = ( self.frameColor ) ? self.frameColor : [UIColor blackColor];
    [color setFill];
    
    NSUInteger points = 10;
    
    float innerAngle = ( M_PI * 2 ) / points;
    float radius = CGRectGetMidY(self.bounds) - inset;
    float innerRadius = radius * 0.4;
    
    CGFloat starWidth = CGRectGetWidth(self.bounds) / self.numberOfStars;
    CGFloat xPos = starWidth / 2;
    
    for ( int s = 1; s <= self.numberOfStars; s++ ) {
        // Put the pint at the top
        [path moveToPoint:CGPointMake(xPos + radius * cos(3 * M_PI_2), CGRectGetMidY(self.bounds) + radius * sin(3 * M_PI_2 ))];
        
        for ( int i = 1; i <= points; i ++ ) {
            
            float r = radius;
            if ( i % 2 != 0 ) {
                r = innerRadius;
            }
            
            float x = xPos + r * cos(3 * M_PI_2 + innerAngle * i);
            float y = CGRectGetMidY(self.bounds) + r * sin(3 * M_PI_2 + innerAngle * i);
            
            [path addLineToPoint:CGPointMake(x, y)];
            

        }
            xPos += starWidth;
        [path closePath];
    }
    

    [path fill];
 
    
    CGContextAddPath(ctx, path.CGPath);
    
}




@end
