//
//  MainViewController.h
//  MyFirstFullApp
//
//  Created by Marcin Mackiewicz on 28/08/15.
//  Copyright (c) 2015 Marcin Mackiewicz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)addEmployee:(id)sender;
- (IBAction)reloadButton:(id)sender;
- (IBAction)editButton:(id)sender;
@end
