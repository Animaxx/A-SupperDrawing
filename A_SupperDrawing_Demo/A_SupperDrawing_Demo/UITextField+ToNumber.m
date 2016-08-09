//
//  UITextField+ToNumber.m
//  A_SupperDrawing_Demo
//
//  Created by Animax Deng on 8/9/16.
//  Copyright © 2016 Animax. All rights reserved.
//

#import "UITextField+ToNumber.h"

@implementation UITextField (ToNumber)

- (double)toDouble {
    if (self.text && self.text.length > 0) {
        return [self.text doubleValue];
    } else {
        return 1.0;
    }
}

@end
