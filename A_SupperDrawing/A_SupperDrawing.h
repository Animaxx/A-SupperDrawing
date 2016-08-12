//
//  A_SupperDrawing.h
//  A_SupperDrawing
//
//  Created by Animax Deng on 7/25/16.
//  Copyright © 2016 Animax. All rights reserved.
//


#import "A_DrawingBase.h"

@interface A_SupperDrawing : A_DrawingBase

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


@end
