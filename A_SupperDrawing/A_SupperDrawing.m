//
//  A_SupperDrawing.m
//  A_SupperDrawing
//
//  Created by Animax Deng on 7/25/16.
//  Copyright © 2016 Animax. All rights reserved.
//

#import "A_SupperDrawing.h"
#include <math.h>

@implementation A_SupperDrawing {
    double _a;
    double _b;
}

@synthesize a = _a ,b = _b;

#pragma mark - Init function
+ (A_SupperDrawing *)A_SupperDrawingWithA:(double)a b:(double)b
                                       n1:(double)n1 n2:(double)n2 n3:(double)n3
                                        y:(double)y z:(double)z {
    
    A_SupperDrawing *drawing = [[A_SupperDrawing alloc] init];
    
    [drawing setA:a];
    [drawing setB:b];
    [drawing setN1:n1];
    [drawing setN2:n2];
    [drawing setN3:n3];
    [drawing setY:y];
    [drawing setZ:z];
    [drawing setReversal:NO];
    
    return drawing;
}

+ (A_SupperDrawing *)A_SupperDrawingWithA:(double)a b:(double)b
                                       n1:(double)n1 n2:(double)n2 n3:(double)n3
                                        m:(double)m {
    return [A_SupperDrawing A_SupperDrawingWithA:a b:b n1:n1 n2:n2 n3:n3 y:m z:m];
}

#pragma mark - Properties
- (void)setA:(double)a {
    if (a != 0) _a = a;
    else _a = 1.0;
}
- (void)setB:(double)b {
    if (b != 0) _b = b;
    else _b = 1.0;
}

#pragma mark - Calculate functions
- (CGPoint)calculatePoint:(double)t size:(double)size zoomRate:(double)zoomRate {
    double screenCenterPoint = size * 0.5;
    double coordRate = size * zoomRate * 0.5;
    
    double raux = pow(fabs( cos((_y*t)/4) / _a ), _n2) +  pow(fabs( sin((_z*t)/4) / _b ), _n3);
    double r = pow(raux, (1/_n1));
    
    if (!_reversal && r != 0) {
        r = 1/r;
    }
    double pointX = r * cos(t) * coordRate + screenCenterPoint;
    double pointY = r * sin(t) * coordRate + screenCenterPoint;
    
    return CGPointMake(pointX, pointY);
}

- (UIBezierPath *)generatePathWithSize:(double)size zoomRate:(double)zoomRate precision:(double)precision lineWidth:(float)lineWidth {
    if (precision < 100.0) precision = 100.0l;
    else if (precision > 10000.0) precision = 10000.0;
    
    double piDouble = M_PI * 2.0;
    double frame = piDouble / precision;
    
    UIBezierPath *bezier = [UIBezierPath bezierPath];
    
    [bezier moveToPoint:[self calculatePoint:frame size:size zoomRate:zoomRate]];
    for (double t = frame; t <= piDouble; t += 0.001) {
        CGPoint p = [self calculatePoint:t size:size zoomRate:zoomRate];
        [bezier addLineToPoint:p];
    }
    
    [bezier closePath];
    [bezier setLineWidth:lineWidth];
    
    return bezier;
}
- (UIImage *)generateImageWithSize:(double)size zoomRate:(double)zoomRate precision:(double)precision
                         lineWidth:(float)lineWidth color:(UIColor *)color {
    CGFloat deviceScale = [UIScreen mainScreen].scale;
    
    UIBezierPath *path = [self generatePathWithSize:size zoomRate:zoomRate precision:precision lineWidth:lineWidth];
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(size, size), false, deviceScale);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // Change the angle
//    CGContextTranslateCTM(context, size/2, size/2);
//    CGContextRotateCTM(context, 45*M_PI/180);
//    CGContextTranslateCTM(context, -size/2, -size/2);

    [color setStroke];
    [path stroke];
    
    // Style of Join
    CGContextSetLineJoin(context, kCGLineJoinRound);
    CGContextSetLineCap (context, kCGLineCapRound);
    
    UIImage *result = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    return result;
}

#pragma mark - Extra helping functions
- (UIBezierPath *)generatePathWithSize:(double)size {
    return [self generatePathWithSize:size zoomRate:0.84 precision:6000 lineWidth:1.0];
}
- (UIBezierPath *)generatePathWithSize:(double)size lineWidth:(float)lineWidth {
    return [self generatePathWithSize:size zoomRate:0.84 precision:6000 lineWidth:lineWidth];
}
- (UIBezierPath *)generatePathWithSize:(double)size zoomRate:(double)zoomRate {
    return [self generatePathWithSize:size zoomRate:zoomRate precision:6000 lineWidth:1.0];
}
- (UIBezierPath *)generatePathWithSize:(double)size zoomRate:(double)zoomRate lineWidth:(float)lineWidth {
    return [self generatePathWithSize:size zoomRate:zoomRate precision:6000 lineWidth:lineWidth];
}
- (UIBezierPath *)generatePathWithSize:(double)size zoomRate:(double)zoomRate precision:(double)precision {
    return [self generatePathWithSize:size zoomRate:zoomRate precision:precision lineWidth:1.0];
}
- (UIBezierPath *)generatePathWithSize:(double)size precision:(double)precision lineWidth:(float)lineWidth {
    return [self generatePathWithSize:size zoomRate:0.84 precision:precision lineWidth:lineWidth];
}

- (UIImage *)generateImageWithSize:(double)size {
    return [self generateImageWithSize:size zoomRate:0.84 precision:6000 lineWidth:1.0 color:[UIColor blackColor]];
}
- (UIImage *)generateImageWithSize:(double)size color:(UIColor *)color {
    return [self generateImageWithSize:size zoomRate:0.84 precision:6000 lineWidth:1.0 color:color];
}
- (UIImage *)generateImageWithSize:(double)size lineWidth:(double)lineWidth {
    return [self generateImageWithSize:size zoomRate:0.84 precision:6000 lineWidth:lineWidth color:[UIColor blackColor]];
}
- (UIImage *)generateImageWithSize:(double)size lineWidth:(double)lineWidth color:(UIColor *)color {
    return [self generateImageWithSize:size zoomRate:0.84 precision:6000 lineWidth:lineWidth color:color];
}
- (UIImage *)generateImageWithSize:(double)size zoomRate:(double)zoomRate {
    return [self generateImageWithSize:size zoomRate:zoomRate precision:6000 lineWidth:1.0 color:[UIColor blackColor]];
}
- (UIImage *)generateImageWithSize:(double)size zoomRate:(double)zoomRate lineWidth:(double)lineWidth color:(UIColor *)color {
    return [self generateImageWithSize:size zoomRate:zoomRate precision:6000 lineWidth:lineWidth color:color];
}



@end
