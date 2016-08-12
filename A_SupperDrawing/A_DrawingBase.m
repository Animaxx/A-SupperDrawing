//
//  A_DrawingBase.m
//  A_SupperDrawing
//
//  Created by Animax Deng on 7/29/16.
//  Copyright © 2016 Animax. All rights reserved.
//

#import "A_DrawingBase.h"
#include <math.h>

@implementation A_DrawingBase

- (UIBezierPath *)generatePathWithSize:(double)size zoomRate:(double)zoomRate precision:(double)precision lineWidth:(float)lineWidth {
    return [UIBezierPath bezierPath];
}

- (UIImage *)generateImageWithSize:(double)size zoomRate:(double)zoomRate precision:(double)precision
                         lineWidth:(float)lineWidth lineColor:(UIColor *)lineColor fillColor:(UIColor *)fillColor {
    CGFloat deviceScale = [UIScreen mainScreen].scale;
    
    UIBezierPath *path = [self generatePathWithSize:size zoomRate:zoomRate precision:precision lineWidth:lineWidth];
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(size, size), false, deviceScale);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    if (lineColor) {
        [lineColor setStroke];
    }
    if (fillColor) {
        [fillColor setFill];
    }
    [path stroke];
    
    // Style of Join
    CGContextSetLineJoin(context, kCGLineJoinRound);
    CGContextSetLineCap (context, kCGLineCapRound);
    
    UIImage *result = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    return result;
}

- (CAShapeLayer *)generateLayerWithSize:(double)size zoomRate:(double)zoomRate precision:(double)precision
                              lineWidth:(float)lineWidth lineColor:(UIColor *)lineColor fillColor:(UIColor *)fillColor {
    UIBezierPath *path = [self generatePathWithSize:size zoomRate:zoomRate precision:precision lineWidth:lineWidth];
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.path = path.CGPath;
    layer.strokeColor = [lineColor CGColor];
    layer.fillColor = [fillColor CGColor];
    return layer;
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
    return [self generateImageWithSize:size zoomRate:0.84 precision:6000 lineWidth:1.0 lineColor:[UIColor blackColor] fillColor:nil];
}
- (UIImage *)generateImageWithSize:(double)size lineColor:(UIColor *)lineColor {
    return [self generateImageWithSize:size zoomRate:0.84 precision:6000 lineWidth:1.0 lineColor:lineColor fillColor:nil];
}
- (UIImage *)generateImageWithSize:(double)size lineColor:(UIColor *)lineColor fillColor:(UIColor *)fillColor {
    return [self generateImageWithSize:size zoomRate:0.84 precision:6000 lineWidth:1.0 lineColor:lineColor fillColor:fillColor];
}
- (UIImage *)generateImageWithSize:(double)size lineWidth:(double)lineWidth {
    return [self generateImageWithSize:size zoomRate:0.84 precision:6000 lineWidth:lineWidth lineColor:[UIColor blackColor] fillColor:nil];
}
- (UIImage *)generateImageWithSize:(double)size lineWidth:(double)lineWidth lineColor:(UIColor *)lineColor {
    return [self generateImageWithSize:size zoomRate:0.84 precision:6000 lineWidth:lineWidth lineColor:lineColor fillColor:nil];
}
- (UIImage *)generateImageWithSize:(double)size fillColor:(UIColor *)fillColor {
    return [self generateImageWithSize:size zoomRate:0.84 precision:6000 lineWidth:0.0 lineColor:nil fillColor:fillColor];
}
- (UIImage *)generateImageWithSize:(double)size zoomRate:(double)zoomRate {
    return [self generateImageWithSize:size zoomRate:zoomRate precision:6000 lineWidth:1.0 lineColor:[UIColor blackColor] fillColor:nil];
}
- (UIImage *)generateImageWithSize:(double)size zoomRate:(double)zoomRate lineWidth:(double)lineWidth lineColor:(UIColor *)lineColor {
    return [self generateImageWithSize:size zoomRate:zoomRate precision:6000 lineWidth:lineWidth lineColor:lineColor fillColor:nil];
}
- (UIImage *)generateImageWithSize:(double)size zoomRate:(double)zoomRate lineColor:(UIColor *)lineColor fillColor:(UIColor *)fillColor {
    return [self generateImageWithSize:size zoomRate:zoomRate precision:6000 lineWidth:1.0 lineColor:lineColor fillColor:fillColor];
}
- (UIImage *)generateImageWithSize:(double)size zoomRate:(double)zoomRate lineWidth:(double)lineWidth lineColor:(UIColor *)lineColor fillColor:(UIColor *)fillColor {
    return [self generateImageWithSize:size zoomRate:zoomRate precision:6000 lineWidth:lineWidth lineColor:lineColor fillColor:fillColor];
}
- (UIImage *)generateImageWithSize:(double)size zoomRate:(double)zoomRate fillColor:(UIColor *)fillColor {
    return [self generateImageWithSize:size zoomRate:zoomRate precision:6000 lineWidth:0.0 lineColor:nil fillColor:fillColor];
}

- (CAShapeLayer *)generateLayerWithSize:(double)size {
    return [self generateLayerWithSize:size zoomRate:0.84 precision:6000 lineWidth:1.0 lineColor:[UIColor blackColor] fillColor:[UIColor clearColor]];
}
- (CAShapeLayer *)generateLayerWithSize:(double)size lineColor:(UIColor *)lineColor {
    return [self generateLayerWithSize:size zoomRate:0.84 precision:6000 lineWidth:1.0 lineColor:lineColor fillColor:[UIColor clearColor]];
}
- (CAShapeLayer *)generateLayerWithSize:(double)size lineWidth:(double)lineWidth {
    return [self generateLayerWithSize:size zoomRate:0.84 precision:6000 lineWidth:lineWidth lineColor:[UIColor blackColor] fillColor:[UIColor clearColor]];
}
- (CAShapeLayer *)generateLayerWithSize:(double)size lineWidth:(double)lineWidth lineColor:(UIColor *)lineColor {
    return [self generateLayerWithSize:size zoomRate:0.84 precision:6000 lineWidth:lineWidth lineColor:lineColor fillColor:[UIColor clearColor]];
}
- (CAShapeLayer *)generateLayerWithSize:(double)size lineWidth:(double)lineWidth lineColor:(UIColor *)lineColor fillColor:(UIColor *)fillColor {
    return [self generateLayerWithSize:size zoomRate:0.84 precision:6000 lineWidth:lineWidth lineColor:lineColor fillColor:fillColor];
}
- (CAShapeLayer *)generateLayerWithSize:(double)size zoomRate:(double)zoomRate {
    return [self generateLayerWithSize:size zoomRate:zoomRate precision:6000 lineWidth:1.0 lineColor:[UIColor blackColor] fillColor:[UIColor clearColor]];
}
- (CAShapeLayer *)generateLayerWithSize:(double)size zoomRate:(double)zoomRate lineColor:(UIColor *)lineColor {
    return [self generateLayerWithSize:size zoomRate:zoomRate precision:6000 lineWidth:1.0 lineColor:lineColor fillColor:[UIColor clearColor]];
}
- (CAShapeLayer *)generateLayerWithSize:(double)size zoomRate:(double)zoomRate lineWidth:(double)lineWidth lineColor:(UIColor *)lineColor {
    return [self generateLayerWithSize:size zoomRate:zoomRate precision:6000 lineWidth:lineWidth lineColor:lineColor fillColor:[UIColor clearColor]];
}
- (CAShapeLayer *)generateLayerWithSize:(double)size zoomRate:(double)zoomRate lineWidth:(double)lineWidth lineColor:(UIColor *)lineColor fillColor:(UIColor *)fillColor {
    return [self generateLayerWithSize:size zoomRate:zoomRate precision:6000 lineWidth:lineWidth lineColor:lineColor fillColor:fillColor];
}


@end
