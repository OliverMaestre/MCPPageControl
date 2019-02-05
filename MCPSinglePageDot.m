//
//  MCPSinglePageDot.m
//  LexusLoyalty
//
//  Created by Mario Chinchilla PlanetMedia on 16/10/15.
//  Copyright © 2015 Mario. All rights reserved.
//

#import "MCPSinglePageDot.h"

@implementation MCPSinglePageDot

-(id)initWithSize:(CGFloat)size andBackgroundColor:(UIColor*)backgroundColor andBorderColor:(UIColor*)borderColor andBorderWidth:(CGFloat)borderWidth{
    
    self = [super initWithFrame:CGRectMake(0, 0, size, size)];
    if(!self) return nil;

    /**** Circle border mask ***/
    CGPoint boundsCenter = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    UIBezierPath *circlePath = [UIBezierPath bezierPathWithArcCenter:boundsCenter radius:self.frame.size.width/2 startAngle:.0f endAngle:M_PI*2.f clockwise:YES];
    CAShapeLayer *circleMask = [CAShapeLayer new];
    circleMask.path = circlePath.CGPath;
    
    /**** Circle Border Layer ****/
    CAShapeLayer *frameLayer = [CAShapeLayer new];
    frameLayer.path = circlePath.CGPath;
    frameLayer.lineWidth = borderWidth;
    frameLayer.strokeColor = borderColor.CGColor;
    frameLayer.fillColor = nil;
    
    [self.layer removeFromSuperlayer];
    [self.layer addSublayer:frameLayer];
    [self.layer setMask:circleMask]; // Estos pasos son necesarios para no ver el borde con una delgada línea de puntos, consecuencia del cornerRadius

    
    /**** Other settings ****/
    self.backgroundColor = backgroundColor;
    self.layer.masksToBounds = YES;
    self.clipsToBounds = YES;
    
    return self;
}

@end
