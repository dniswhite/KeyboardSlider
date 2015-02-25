//
//  ViewController.h
//  KeyboardSlider
//
//  Created by Dennis White on 2/24/15.
//  Copyright (c) 2015 dniswhite. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *hiddenTextField;
@property (weak, nonatomic) IBOutlet UITextField *hiddenTextField2;

@property (weak, nonatomic) IBOutlet UITextField *visibleTextField;
@property (weak, nonatomic) IBOutlet UITextField *visibleTextField2;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UIControl *activeField;

@end

