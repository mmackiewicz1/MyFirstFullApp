//
//  CoreDataHelper.h
//  MyFirstFullApp
//
//  Created by Marcin Mackiewicz on 28/08/15.
//  Copyright (c) 2015 Marcin Mackiewicz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Employee.h"

@interface CoreDataHelper : NSObject
+ (NSManagedObjectContext *)mainManagedObjectContext;
+ (NSArray *)fetchDataWithEntityName:(NSString *)entityName;
+ (NSArray *)fetchDataWithEntityName:(NSString *)entityName predicate:(NSPredicate *)predicate;
+ (NSFetchedResultsController *)mainFetchController:(NSString *)entityName sortAttributeName:(NSString *)sortAttributeName;
+ (NSFetchedResultsController *)mainFetchController:(NSString *)entityName sortAttributeName:(NSString *)sortAttributeName predicate:(NSPredicate *)predicate;
+ (NSFetchedResultsController *)mainFetchController:(NSString *)entityName sortDescriptors:(NSArray *)sortDescriptors predicate:(NSPredicate *)predicate searchLimit:(NSNumber *)limit;

+ (BOOL)createNewEmployeeWithFirstName:(NSString *)paramFirstName lastName:(NSString *)paramLastName
                            age:(NSUInteger)paramAge position: (NSString *)paramPosition;
+ (BOOL) deleteEmployee:(Employee *)employee;
@end
