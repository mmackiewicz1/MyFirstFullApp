//
//  MainViewController.m
//  MyFirstFullApp
//
//  Created by Marcin Mackiewicz on 28/08/15.
//  Copyright (c) 2015 Marcin Mackiewicz. All rights reserved.
//

#import "MainViewController.h"
#import "Employee.h"
#import "CoreDataHelper.h"
#import "EmployeeTableCellTableViewCell.h"
#import "SubViewController.h"
#import "Animator.h"
#import "EditViewController.h"
#import <Parse/Parse.h>

@interface MainViewController ()
@end

@implementation MainViewController

NSMutableArray *employees;

-(id)init {
    self = [super init];
    
    [self reloadEmployeeTable];

    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didDismissSubViewController) name:@"SubViewControllerDismissed" object:nil];
    
    self.tableView.allowsSelectionDuringEditing = YES;
    self.tableView.allowsSelection = NO;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)didDismissSubViewController {
    NSLog(@"Subview dismissed");
    [self reloadEmployeeTable];
}

- (IBAction)addEmployee:(id)sender {
    [Animator addAnimationFadeToView:self.view];
    SubViewController *subViewController = [[SubViewController alloc] initWithNibName:@"SubViewController" bundle:nil];
    
    [self.view addSubview:subViewController.view];
    [self addChildViewController:subViewController];
    [subViewController didMoveToParentViewController:self];
}


-(void)reloadEmployeeTable {
    PFQuery *query = [PFQuery queryWithClassName:@"Employee"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *employeesFromQuery, NSError *error) {
        employees = nil;
        employees = [[NSMutableArray alloc] init];
        for (PFObject *queryData in employeesFromQuery) {
            Employee *employee = [[Employee alloc] init];
            employee.objectId = queryData[@"objectId"];
            employee.firstName = queryData[@"firstName"];
            employee.lastName = queryData[@"lastName"];
            employee.age = queryData[@"age"];
            employee.position = queryData[@"position"];
            
            [employees addObject:employee];
        }
        [self.tableView reloadData];
    }];
}

- (IBAction)reloadButton:(id)sender {
    NSLog(@"Clicked reloaded");
    [self reloadEmployeeTable];
    
}

- (IBAction)editButton:(id)sender {
    if ([self.tableView isEditing]) {
        [self.tableView setEditing:NO animated:YES];
    } else {
        [self.tableView setEditing:YES animated:YES];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [employees count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *Cellidentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: Cellidentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier:Cellidentifier];
    }
    
    Employee *employee = [employees objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat: @"%@ %@", employee.firstName, employee.lastName];
    
    return cell;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        PFQuery *query = [PFQuery queryWithClassName:@"Employee"];
        NSLog(@"Clicked delete.");
        [query getObjectInBackgroundWithId:[[employees objectAtIndex: indexPath.row] objectId] block:^(PFObject *employee, NSError *getError) {
            NSLog(@"Got element to delete.");
            [employee deleteInBackgroundWithBlock:^(BOOL succeeded, NSError *deleteError) {
                NSLog(@"Deleting element.");
                if (succeeded && !deleteError) {
                    NSLog(@"Employee deleted.");
                    [employees removeObjectAtIndex:indexPath.row];
                    [self reloadEmployeeTable];
                } else {
                    NSLog(@"error: %@", deleteError);
                }
            }];
        }];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [Animator addAnimationFadeToView:self.view];
    EditViewController *editViewController = [[EditViewController alloc] initWithNibName:@"EditViewController" bundle:nil];
    editViewController.employee = [employees objectAtIndex: indexPath.row];
    [self.view addSubview:editViewController.view];
    [self addChildViewController:editViewController];
    [editViewController didMoveToParentViewController:self];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
@end
