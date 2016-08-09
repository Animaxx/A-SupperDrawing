//
//  A_SupperDrawing.h
//  A_SupperDrawing
//
//  Created by Animax Deng on 7/25/16.
//  Copyright © 2016 Animax. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface A_SupperDrawing : NSObject

// Formula parameters
@property (nonatomic) double a;
@property (nonatomic) double b;
@property (nonatomic) double n1;
@property (nonatomic) double n2;
@property (nonatomic) double n3;
@property (nonatomic) double y;
@property (nonatomic) double z;

// Extra paramters
@property (nonatomic) BOOL reversal;

+ (A_SupperDrawing *)A_SupperDrawingWithA:(double)a b:(double)b
                                       n1:(double)n1 n2:(double)n2 n3:(double)n3
                                        y:(double)y z:(double)z;

+ (A_SupperDrawing *)A_SupperDrawingWithA:(double)a b:(double)b
                                       n1:(double)n1 n2:(double)n2 n3:(double)n3
                                        m:(double)m;
/**
 *  Generate the path base on params which set
 *
 *  @param size      Height and Width of the canvas
 *  @param zoomRate  The Rate of zoom, [0~1.0], default 0.84
 *  @param precision Bigger number of precision will be more perfect of the path, [100.0~10000.0], defaule 6000
 *  @param lineWidth The width of the line, default 1.0
 *
 *  @return UIBezierPath
 */
- (UIBezierPath *)generatePathWithSize:(double)size zoomRate:(double)zoomRate precision:(double)precision
                             lineWidth:(float)lineWidth;

/**
 *  Generate the UIImage base on params which set
 *
 *  @param size      Height and Width of the canvas
 *  @param zoomRate  The Rate of zoom, [0~1.0], default 0.84
 *  @param precision Bigger number of precision will be more perfect of the path, [100.0~10000.0], defaule 6000
 *  @param lineWidth The width of the line, default 1.0
 *  @param color     Color of the line.
 *
 *  @return UIImage
 */
- (UIImage *)generateImageWithSize:(double)size zoomRate:(double)zoomRate precision:(double)precision
                         lineWidth:(float)lineWidth lineColor:(UIColor *)lineColor fillColor:(UIColor *)fillColor;

#pragma mark - extra helping functions
- (UIBezierPath *)generatePathWithSize:(double)size;
- (UIBezierPath *)generatePathWithSize:(double)size lineWidth:(float)lineWidth;
- (UIBezierPath *)generatePathWithSize:(double)size zoomRate:(double)zoomRate;
- (UIBezierPath *)generatePathWithSize:(double)size zoomRate:(double)zoomRate lineWidth:(float)lineWidth;
- (UIBezierPath *)generatePathWithSize:(double)size zoomRate:(double)zoomRate precision:(double)precision;
- (UIBezierPath *)generatePathWithSize:(double)size precision:(double)precision lineWidth:(float)lineWidth;

- (UIImage *)generateImageWithSize:(double)size;
- (UIImage *)generateImageWithSize:(double)size fillColor:(UIColor *)fillColor;
- (UIImage *)generateImageWithSize:(double)size lineColor:(UIColor *)lineColor;
- (UIImage *)generateImageWithSize:(double)size lineColor:(UIColor *)lineColor fillColor:(UIColor *)fillColor;
- (UIImage *)generateImageWithSize:(double)size lineWidth:(double)lineWidth;
- (UIImage *)generateImageWithSize:(double)size lineWidth:(double)lineWidth lineColor:(UIColor *)lineColor;
- (UIImage *)generateImageWithSize:(double)size fillColor:(UIColor *)fillColor;
- (UIImage *)generateImageWithSize:(double)size zoomRate:(double)zoomRate;
- (UIImage *)generateImageWithSize:(double)size zoomRate:(double)zoomRate lineWidth:(double)lineWidth lineColor:(UIColor *)lineColor;
- (UIImage *)generateImageWithSize:(double)size zoomRate:(double)zoomRate lineColor:(UIColor *)lineColor fillColor:(UIColor *)fillColor;
- (UIImage *)generateImageWithSize:(double)size zoomRate:(double)zoomRate lineWidth:(double)lineWidth lineColor:(UIColor *)lineColor fillColor:(UIColor *)fillColor;
- (UIImage *)generateImageWithSize:(double)size zoomRate:(double)zoomRate fillColor:(UIColor *)fillColor;

- (CAShapeLayer *)generateLayerWithSize:(double)size;
- (CAShapeLayer *)generateLayerWithSize:(double)size lineColor:(UIColor *)lineColor;
- (CAShapeLayer *)generateLayerWithSize:(double)size lineWidth:(double)lineWidth;
- (CAShapeLayer *)generateLayerWithSize:(double)size lineWidth:(double)lineWidth lineColor:(UIColor *)lineColor;
- (CAShapeLayer *)generateLayerWithSize:(double)size lineWidth:(double)lineWidth lineColor:(UIColor *)lineColor fillColor:(UIColor *)fillColor;
- (CAShapeLayer *)generateLayerWithSize:(double)size zoomRate:(double)zoomRate;
- (CAShapeLayer *)generateLayerWithSize:(double)size zoomRate:(double)zoomRate lineColor:(UIColor *)lineColor;
- (CAShapeLayer *)generateLayerWithSize:(double)size zoomRate:(double)zoomRate lineWidth:(double)lineWidth lineColor:(UIColor *)lineColor;
- (CAShapeLayer *)generateLayerWithSize:(double)size zoomRate:(double)zoomRate lineWidth:(double)lineWidth lineColor:(UIColor *)lineColor fillColor:(UIColor *)fillColor;

@end
