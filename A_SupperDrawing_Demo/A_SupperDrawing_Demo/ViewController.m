//
//  ViewController.m
//  A_SupperDrawing_Demo
//
//  Created by Animax Deng on 7/25/16.
//  Copyright © 2016 Animax. All rights reserved.
//

#import "ViewController.h"
#import <A_SupperDrawing/A_SupperDrawing.h>
#import "UITextField+ToNumber.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *demoImageView;


@end

@implementation ViewController {
    CAShapeLayer *imageLayer;
    
    __weak IBOutlet UIButton *drawBtn;
    __weak IBOutlet UIButton *randomBtn;
    
    __weak IBOutlet UITextField *_aTxt;
    __weak IBOutlet UITextField *_bTxt;
    __weak IBOutlet UITextField *_n1Txt;
    __weak IBOutlet UITextField *_n2Txt;
    __weak IBOutlet UITextField *_n3Txt;
    __weak IBOutlet UITextField *_yTxt;
    __weak IBOutlet UITextField *_zTxt;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    drawBtn.layer.borderWidth = 0.5f;
    drawBtn.layer.borderColor = [UIColor blackColor].CGColor;
    
    randomBtn.layer.borderWidth = 0.5f;
    randomBtn.layer.borderColor = [UIColor blackColor].CGColor;
}

- (void)viewWillAppear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShown:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHidden:) name:UIKeyboardWillHideNotification object:nil];
}
- (void)viewWillDisappear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self drawPhotograph];
}

- (void)keyboardShown:(NSNotification *)notification {
    [self.view setBounds:CGRectMake(0, 216, self.view.frame.size.width, self.view.frame.size.height)];
}
- (void)keyboardHidden:(NSNotification *)notification {
    [self.view setBounds:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
}

- (void)drawPhotograph {
    [self.view endEditing:YES];
    [drawBtn setEnabled:NO];
    [randomBtn setEnabled:NO];
    
    A_SupperDrawing *drawing = [A_SupperDrawing A_SupperDrawingWithA:[_aTxt toDouble]
                                                                   b:[_bTxt toDouble]
                                                                  n1:[_n1Txt toDouble]
                                                                  n2:[_n2Txt toDouble]
                                                                  n3:[_n3Txt toDouble]
                                                                   y:[_yTxt toDouble]
                                                                   z:[_zTxt toDouble]];
    
    if (!imageLayer) {
        [CATransaction begin]; {
            [CATransaction setCompletionBlock:^{
                [drawBtn setEnabled:YES];
                [randomBtn setEnabled:YES];
            }];
            
            imageLayer = [drawing generateLayerWithSize:_demoImageView.frame.size.width zoomRate:0.5f];
            [self.demoImageView.layer addSublayer:imageLayer];
            
            CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
            pathAnimation.duration = 3.0;
            pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
            pathAnimation.toValue = [NSNumber numberWithFloat:1.0f];
            [imageLayer addAnimation:pathAnimation forKey:@"strokeEndAnimation"];
            
            imageLayer.strokeEnd = 1.0f;
            
        } [CATransaction commit];
    } else {
        __block UIBezierPath *path = [drawing generatePathWithSize:_demoImageView.frame.size.width zoomRate:0.5f];
        
        [CATransaction begin]; {
            [CATransaction setCompletionBlock:^{
                imageLayer.path = path.CGPath;
                [imageLayer removeAllAnimations];
                
                [drawBtn setEnabled:YES];
                [randomBtn setEnabled:YES];
            }];
            
            CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
            pathAnimation.duration = 1.2;
            pathAnimation.toValue =  (__bridge id)imageLayer.path;
            pathAnimation.toValue =  (__bridge id)path.CGPath;
            pathAnimation.removedOnCompletion = false;
            pathAnimation.fillMode = @"forwards";
            [imageLayer addAnimation:pathAnimation forKey:@"pathAnimation"];
            
        } [CATransaction commit];
    }
}

- (IBAction)onClickDraw:(id)sender {
    [self drawPhotograph];
}
- (IBAction)onClickRandom:(id)sender {
    [_aTxt setRandom:0.1 end:10.0];
    [_bTxt setRandom:0.1 end:10.0];
    
    [_n1Txt setRandom:-10.0 end:10.0];
    [_n2Txt setRandom:0.1 end:1.5];
    [_n3Txt setRandom:0.1 end:1.5];
    
    [_yTxt setRandom:1 end:100];
    [_zTxt setRandom:1 end:100];
    
    [self drawPhotograph];
}
- (IBAction)onClickBackground:(id)sender {
    [self.view endEditing:YES];
}


@end
