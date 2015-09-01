//
//  SubViewController.m
//  MyFirstFullApp
//
//  Created by Marcin Mackiewicz on 28/08/15.
//  Copyright (c) 2015 Marcin Mackiewicz. All rights reserved.
//

#import "SubViewController.h"
#import "Animator.h"
#import "CoreDataHelper.h"
#import "Employee.h"
#import "MainViewController.h"
#import <Parse/Parse.h>

@interface SubViewController ()
@end

@implementation SubViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSInteger leftMargin = 30;
    NSInteger topMargin = 15;
    CGRect rect = CGRectMake(leftMargin, topMargin, self.view.frame.size.width - leftMargin, self.view.frame.size.height - 150 - topMargin * 2);
    self.view.frame = rect;
    
    self.firstNameTextField.delegate = self;
    self.lastNameTextField.delegate = self;
    self.ageTextField.delegate = self;
    self.positionTextField.delegate = self;
    
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

- (IBAction)cancelAdd:(id)sender {
    [Animator addAnimationFadeToView:self.view];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SubViewControllerDismissed"
                                                        object:nil
                                                      userInfo:nil];
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
}

- (IBAction)addEmployee:(id)sender {
    /*
    Employee *newEmployee = [NSEntityDescription insertNewObjectForEntityForName:@"Employee" inManagedObjectContext:[CoreDataHelper mainManagedObjectContext]];
    
    if (newEmployee != nil){
        
         if (self.firstNameTextField.text.length == 0 || self.firstNameTextField.text.length == 0 || self.ageTextField.text.length == 0 || self.positionTextField.text.length == 0) {
            NSLog(@"Empty fields detected.");
            return;
        }
        
        newEmployee.firstName = self.firstNameTextField.text;
        newEmployee.lastName = self.lastNameTextField.text;
        
        NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
        f.numberStyle = NSNumberFormatterDecimalStyle;
        newEmployee.age = [f numberFromString:self.ageTextField.text];
        newEmployee.position = self.positionTextField.text;
        
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
    
    if (self.firstNameTextField.text.length == 0 || self.firstNameTextField.text.length == 0 || self.ageTextField.text.length == 0 || self.positionTextField.text.length == 0) {
        NSLog(@"Empty fields detected.");
        return;
    }
    
    PFObject *employee = [PFObject objectWithClassName:@"Employee"];
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
}

@end
