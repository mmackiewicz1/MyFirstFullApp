//
//  EditView.h
//  MyFirstFullApp
//
//  Created by Marcin Mackiewicz on 31/08/15.
//  Copyright (c) 2015 Marcin Mackiewicz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Employee.h"

@interface EditViewController : UIViewController<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *firstNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *ageTextField;
@property (weak, nonatomic) IBOutlet UITextField *positionTextField;
@property (weak, nonatomic) Employee *employee;

- (IBAction)cancelButton:(id)sender;
- (IBAction)submitButton:(id)sender;

@end
