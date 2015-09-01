//
//  Animator.m
//  MyFirstFullApp
//
//  Created by Marcin Mackiewicz on 28/08/15.
//  Copyright (c) 2015 Marcin Mackiewicz. All rights reserved.
//

#import "Animator.h"

@implementation Animator

+ (void)addAnimationFadeToView:(UIView *)view {
    CATransition *transition = [CATransition animation];
    transition.duration = 0.12;
    transition.type = kCATransitionFade;
    
    [view.layer addAnimation:transition forKey:kCATransition];
}

+ (void)addAnimationFromRightSideToView:(UIView *)view {
    CATransition *transition = [CATransition animation];
    transition.duration = 0.2;
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromRight;
    
    [view.layer addAnimation:transition forKey:nil];
}
@end
