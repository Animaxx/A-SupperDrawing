//
//  UITextField+ToNumber.h
//  A_SupperDrawing_Demo
//
//  Created by Animax Deng on 8/9/16.
//  Copyright © 2016 Animax. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (ToNumber)

- (double)toDouble;
- (void)setRandom:(double)start end:(double)end;

@end
