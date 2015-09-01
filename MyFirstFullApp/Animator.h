//
//  Animator.h
//  MyFirstFullApp
//
//  Created by Marcin Mackiewicz on 28/08/15.
//  Copyright (c) 2015 Marcin Mackiewicz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Animator : NSObject

+ (void)addAnimationFadeToView:(UIView *)view;
+ (void)addAnimationFromRightSideToView:(UIView *)view;

@end

