//
//  EditView.m
//  MyFirstFullApp
//
//  Created by Marcin Mackiewicz on 31/08/15.
//  Copyright (c) 2015 Marcin Mackiewicz. All rights reserved.
//

#import "EditViewController.h"
#import "Animator.h"
#import "CoreDataHelper.h"
#import <Parse/Parse.h>

@interface EditViewController ()

@end

@implementation EditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSInteger leftMargin = 30;
    NSInteger topMargin = 15;
    CGRect rect = CGRectMake(leftMargin, topMargin, self.view.frame.size.width - leftMargin, self.view.frame.size.height - 150 - topMargin * 2);
    self.view.frame = rect;
    
    self.firstNameTextField.delegate = self;
    self.lastNameTextField.delegate = self;
    self.ageTextField.delegate = self;
    self.positionTextField.delegate = self;
    
    self.firstNameTextField.text = self.employee.firstName;
    self.lastNameTextField.text = self.employee.lastName;
    
    self.ageTextField.text = [NSString stringWithFormat:@"%@", self.employee.age];
    self.positionTextField.text = self.employee.position;
    
    self.view.layer.cornerRadius = 8.5;
    self.view.layer.masksToBounds = YES;
    self.view.layer.borderWidth = 1.0;
    self.view.layer.borderColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5].CGColor;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)cancelButton:(id)sender {
    [Animator addAnimationFadeToView:self.view];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SubViewControllerDismissed" object:nil userInfo:nil];
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
}

- (IBAction)submitButton:(id)sender {
    /*
    if (self.employee != nil){
        
        if (self.firstNameTextField.text.length == 0 || self.firstNameTextField.text.length == 0 || self.ageTextField.text.length == 0 || self.positionTextField.text.length == 0) {
            NSLog(@"Empty fields detected.");
            return;
        }
        
        self.employee.firstName = self.firstNameTextField.text;
        self.employee.lastName = self.lastNameTextField.text;
        
        NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
        f.numberStyle = NSNumberFormatterDecimalStyle;
        self.employee.age = [f numberFromString:self.ageTextField.text];
        self.employee.position = self.positionTextField.text;
        
        NSError *savingError = nil;
        
        if ([[CoreDataHelper mainManagedObjectContext] save:&savingError]){
            NSLog(@"Successfully saved the employee.");
            [Animator addAnimationFadeToView:self.view];
            [self.view removeFromSuperview];
            [self removeFromParentViewController];
        } else {
            NSLog(@"Failed to save the context. Error = %@", savingError);
        }
    } else {
        NSLog(@"Failed to create the new Employee.");
    }
     */
    
    NSLog(@"Clicked submit in edit");
    
    if (self.firstNameTextField.text.length == 0 || self.firstNameTextField.text.length == 0 || self.ageTextField.text.length == 0 || self.positionTextField.text.length == 0) {
        NSLog(@"Empty fields detected.");
        return;
    }
    
    PFQuery *query = [PFQuery queryWithClassName:@"Employee"];
    
    [query getObjectInBackgroundWithId:self.employee.objectId block:^(PFObject *employee, NSError *error) {
        employee[@"firstName"] = self.firstNameTextField.text;
        employee[@"lastName"] = self.lastNameTextField.text;
        employee[@"age"] = self.ageTextField.text;
        employee[@"position"] = self.positionTextField.text;
        
        NSLog(@"Data set.");
        
        [employee saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (succeeded) {
                NSLog(@"Successfully saved the employee.");
                [Animator addAnimationFadeToView:self.view];
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"SubViewControllerDismissed" object:nil userInfo:nil];
                
                [self.view removeFromSuperview];
                [self removeFromParentViewController];
            } else {
                NSLog(@"Failed to create the new Employee.");
            }
        }];
        
    }];
}

@end
