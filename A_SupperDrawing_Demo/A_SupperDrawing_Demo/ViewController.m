//
//  ViewController.m
//  A_SupperDrawing_Demo
//
//  Created by Animax Deng on 7/25/16.
//  Copyright © 2016 Animax. All rights reserved.
//

#import "ViewController.h"
#import <A_SupperDrawing/A_SupperDrawing.h>

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *demoImageView;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    A_SupperDrawing *drawing = [A_SupperDrawing A_SupperDrawingWithA:1.0 b:1.0 n1:3.0 n2:1.0 n3:1.0 y:4.0 z:6.0];
    UIImage *image = [drawing generateImageWithSize:_demoImageView.frame.size.width zoomRate:0.45 precision:6000 lineWidth:1.0 color:[UIColor blackColor]];
    [self.demoImageView setImage:image];
}

@end
