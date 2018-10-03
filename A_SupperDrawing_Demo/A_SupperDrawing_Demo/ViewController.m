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

@interface ViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *demoImageView;
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *tapGestureRecognizer;

@end

@implementation ViewController {
    CAShapeLayer *imageLayer;
    
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
    
    randomBtn.layer.borderWidth = 0.5f;
    randomBtn.layer.borderColor = [UIColor blackColor].CGColor;
    
    _aTxt.delegate = self;
    _bTxt.delegate = self;
    _n1Txt.delegate = self;
    _n2Txt.delegate = self;
    _n3Txt.delegate = self;
    _yTxt.delegate = self;
    _zTxt.delegate = self;
    
    _tapGestureRecognizer.cancelsTouchesInView = NO;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShown:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHidden:) name:UIKeyboardWillHideNotification object:nil];
}
- (void)viewWillDisappear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [super viewWillDisappear:animated];
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
    [self->randomBtn setEnabled:NO];
    
    A_SupperDrawing *drawing = [A_SupperDrawing A_SupperDrawingWithA:[_aTxt toDouble]
                                                                   b:[_bTxt toDouble]
                                                                  n1:[_n1Txt toDouble]
                                                                  n2:[_n2Txt toDouble]
                                                                  n3:[_n3Txt toDouble]
                                                                   y:[_yTxt toDouble]
                                                                   z:[_zTxt toDouble]];
    
    if (!imageLayer) {
        __weak __typeof(self)weakSelf = self;
        [CATransaction begin]; {
            [CATransaction setCompletionBlock:^{
                __strong __typeof(weakSelf)strongSelf = weakSelf;
                if (strongSelf!=nil) {
                    [strongSelf->randomBtn setEnabled:YES];
                }
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
        __weak __typeof(self)weakSelf = self;
        [CATransaction begin]; {
            [CATransaction setCompletionBlock:^{
                __strong __typeof(weakSelf)strongSelf = weakSelf;
                if (strongSelf!=nil) {
                    strongSelf->imageLayer.path = path.CGPath;
                    [strongSelf->imageLayer removeAllAnimations];
                    
                    [strongSelf->randomBtn setEnabled:YES];
                }
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

- (IBAction)tapAction:(id)sender {
    // Dismiss keyboard by tapping outside keyboard on main view.
    [self.view endEditing:YES];
}

#pragma mark - UITextFieldDelegate protocol

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    // Restrict textField's to only allow numeric text.
    // The one exception is empty string which defaults to @"0" is also allowed.
    BOOL answer = YES;
    NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    if (newString.length==0) {
        answer = (textField.text.length != 0);
    } else {
        NSScanner *scanner = [NSScanner scannerWithString:newString];
        answer = [scanner scanDecimal:nil] && scanner.atEnd;
    };
    if (answer) {
        // Redraw with every allowed change since the drawing
        // algorithm seems fast enough.
        [self drawPhotograph];
    }
    return answer;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    // "The text field calls this method when it is asked to resign the first
    // responder status."
    // https://developer.apple.com/documentation/uikit/uitextfielddelegate/1619592-textfieldshouldendediting?language=objc
    if (textField.text.length==0) {
        textField.text = @"0";
    }
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField*)textField {
    NSInteger nextTag = textField.tag + 1;
    UIResponder* nextResponder = [textField.superview viewWithTag:nextTag];
    if (!nextResponder) {
        // Go back to the first textField .
        nextTag = 1;
        nextResponder = [textField.superview viewWithTag:nextTag];
    }
    if (nextResponder) {
        [nextResponder becomeFirstResponder];
    };
    [self drawPhotograph];
    return NO;
}

@end
