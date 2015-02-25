//
//  ViewController.m
//  KeyboardSlider
//
//  Created by Dennis White on 2/24/15.
//  Copyright (c) 2015 dniswhite. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
<UITextFieldDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    [[self view] addGestureRecognizer:recognizer];
    
    [[self hiddenTextField] setDelegate:self];
    [[self hiddenTextField2] setDelegate:self];
    [[self visibleTextField] setDelegate:self];
    [[self visibleTextField2] setDelegate:self];
}

-(void) viewDidAppear:(BOOL)animated {
    [self registerForKeyboardNotifications];
}

-(void) viewDidDisappear:(BOOL)animated {
    [self deregisterFromKeyboardNotifications];
}

-(void) textFieldDidBeginEditing:(UITextField *)textField {
    [self setActiveField:textField];
}

-(void) textFieldDidEndEditing:(UITextField *)textField {
    [self hideKeyboard];
    [self setActiveField:nil];
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField {
    if (textField == [self visibleTextField]) {
        [self hideKeyboard];
        [[self visibleTextField2] becomeFirstResponder];
    } else if (textField == [self visibleTextField2]) {
        [self hideKeyboard];
        [[self hiddenTextField2] becomeFirstResponder];
    } else if (textField == [self hiddenTextField2]) {
        [self hideKeyboard];
        [[self hiddenTextField] becomeFirstResponder];
    } else if (textField == [self hiddenTextField]) {
        [self hideKeyboard];
    }
    
    return YES;
}

- (void)registerForKeyboardNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHidden:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)deregisterFromKeyboardNotifications {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void)keyboardWasShown:(NSNotification *)notification {
    NSDictionary* info = [notification userInfo];
    
    CGSize keyboardSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    CGPoint hiddenField = [[self activeField] frame].origin;
    CGFloat hiddenFieldHeight = [[self activeField] frame].size.height;
    
    CGRect visibleRect = [[self view] frame];
    visibleRect.size.height -= keyboardSize.height;
    
    if (!CGRectContainsPoint(visibleRect, hiddenField)) {
        CGPoint scrollPoint = CGPointMake(0.0, hiddenField.y - visibleRect.size.height + hiddenFieldHeight);
        [[self scrollView] setContentOffset:scrollPoint animated:YES];
    }
}

- (void)keyboardWillBeHidden:(NSNotification *)notification {
    [[self scrollView] setContentOffset:CGPointZero animated:YES];
}

-(void)hideKeyboard {
    [[self view] endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
