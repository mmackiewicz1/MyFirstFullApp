//
//  CoreDataHelper.m
//  MyFirstFullApp
//
//  Created by Marcin Mackiewicz on 28/08/15.
//  Copyright (c) 2015 Marcin Mackiewicz. All rights reserved.
//

#import "CoreDataHelper.h"
#import "AppDelegate.h"
#import "Employee.h"

@interface CoreDataHelper ()

@property (nonatomic, strong) NSManagedObjectModel *managedObjectModel;

@end

@implementation CoreDataHelper

#pragma mark - Main NSManagedObjectContext setup

+ (NSManagedObjectContext *)mainManagedObjectContext {
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    return delegate.managedObjectContext;
}

+ (BOOL) createNewEmployeeWithFirstName:(NSString *)paramFirstName lastName:(NSString *)paramLastName
                                    age:(NSUInteger)paramAge position: (NSString *)paramPosition{
    BOOL result = NO;
    if ([paramFirstName length] == 0 || [paramLastName length] == 0){
        NSLog(@"First and Last names are mandatory.");
        return NO;
    }
    Employee *newEmployee = [NSEntityDescription
                             insertNewObjectForEntityForName:@"Employee"
                             inManagedObjectContext:[self mainManagedObjectContext]];
    if (newEmployee == nil){
        NSLog(@"Failed to create the new Employee.");
        return NO;
    }
    newEmployee.firstName = paramFirstName;
    newEmployee.lastName = paramLastName;
    newEmployee.age = @(paramAge);
    NSError *savingError = nil;
    if ([[self mainManagedObjectContext] save:&savingError]){
        return YES;
    } else {
        NSLog(@"Failed to save the new Employee. Error = %@", savingError);
    }
    return result;
}


+ (BOOL) deleteEmployee:(Employee *)employee {
    /*
    [[self mainManagedObjectContext] deleteObject:employee];
    NSError *savingError = nil;
    if ([[self mainManagedObjectContext] save:&savingError]){
        NSLog(@"Successfully deleted.");
    } else {
            NSLog(@"Failed to delete.");
    }
     */
    return YES;
}

+ (NSArray *)fetchDataWithEntityName:(NSString *)entityName {
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:entityName];
    NSError *requestError = nil;
    
    return [[self mainManagedObjectContext] executeFetchRequest:fetchRequest error:&requestError];
}

+ (NSArray *)fetchDataWithEntityName:(NSString *)entityName predicate:(NSPredicate *)predicate {
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:entityName];
    fetchRequest.predicate = predicate;
    
    return [[self mainManagedObjectContext] executeFetchRequest:fetchRequest error:nil];
}

+ (NSFetchedResultsController *)mainFetchController:(NSString *)entityName sortAttributeName:(NSString *)sortAttributeName {
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:[self mainManagedObjectContext]];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:sortAttributeName ascending:YES];
    
    fetchRequest.sortDescriptors = @[ sortDescriptor ];
    fetchRequest.entity = entity;
    
    NSFetchedResultsController *fetchResultController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:[self mainManagedObjectContext] sectionNameKeyPath:nil cacheName:nil];
    
    if ([fetchResultController performFetch:nil]) {
        NSLog(@"Data fetched successfully.");
    } else {
        NSLog(@"Cannot fetch data");
    }
    
    return fetchResultController;
}

+ (NSFetchedResultsController *)mainFetchController:(NSString *)entityName sortAttributeName:(NSString *)sortAttributeName predicate:(NSPredicate *)predicate {
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:[self mainManagedObjectContext]];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:sortAttributeName ascending:YES];
    
    fetchRequest.predicate = predicate;
    fetchRequest.sortDescriptors = @[ sortDescriptor ];
    fetchRequest.entity = entity;
    
    NSFetchedResultsController *fetchResultController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:[self mainManagedObjectContext] sectionNameKeyPath:nil cacheName:nil];
    
    if ([fetchResultController performFetch:nil]) {
        NSLog(@"Data fetched successfully.");
    } else {
        NSLog(@"Cannot fetch data");
    }
    
    return fetchResultController;
}

+ (NSFetchedResultsController *)mainFetchController:(NSString *)entityName sortDescriptors:(NSArray *)sortDescriptors predicate:(NSPredicate *)predicate searchLimit:(NSNumber *)limit{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:[self mainManagedObjectContext]];
    
    fetchRequest.fetchLimit = [limit integerValue];
    fetchRequest.predicate = predicate;
    fetchRequest.sortDescriptors = sortDescriptors;
    fetchRequest.entity = entity;
    
    NSFetchedResultsController *fetchResultController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:[self mainManagedObjectContext] sectionNameKeyPath:nil cacheName:nil];
    
    if ([fetchResultController performFetch:nil]) {
        NSLog(@"Data fetched successfully.");
    } else {
        NSLog(@"Cannot fetch data");
    }
    
    return fetchResultController;
}

@end