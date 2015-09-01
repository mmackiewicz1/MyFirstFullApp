//
//  Employee.h
//  MyFirstFullApp
//
//  Created by Marcin Mackiewicz on 31/08/15.
//  Copyright (c) 2015 Marcin Mackiewicz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Employee : NSObject

@property (nonatomic, strong) NSNumber * age;
@property (nonatomic, strong) NSString * firstName;
@property (nonatomic, strong) NSString * lastName;
@property (nonatomic, strong) NSString * position;
@property (nonatomic, strong) NSString * objectId;

@end
