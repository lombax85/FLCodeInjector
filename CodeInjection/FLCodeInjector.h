//
//  FLCodeInjector.h
//  FuelTracker
//
//  Created by Lombardo on 07/08/13.
//  Copyright (c) 2013 Lombardo. All rights reserved.
//
//  This Class, created by Fabio Lombardo ( http://www.lombax.it ) acts as a simple
//  code injector. It can be used to execute blocks of code BEFORE or AFTER a
//  specific method of an Objective-C object.
//  The main use is for debugging purposes
//  It uses method swizzling and supports the following features:
//
//  - Swizzling methods with return type of kind: int, float, long, double, id
//  - Swizzling methods with variable number of arguments, tested with the following type: int, float, long, double, id
//  - TODO: structs!!!
//
//  Feel free to add or modify features of this code.
//
//  How to use?
//
//
// This example implementation executes the NSLog each time inputView is called (even by the system) on UITextField
//
//    FLCodeInjector *anotherInjector = [FLCodeInjector injectorForClass:[UITextField class]];
//    [anotherInjector injectCodeBeforeSelector:@selector(inputView) code:^{
//        NSLog(@"Before Input View");
//    }];
//


#import <Foundation/Foundation.h>

@interface FLCodeInjector : NSObject

/**
 Instantiate a new injector. This is the designated (and only) initializer.
 For each class passed, it returns a singleton instance.
 So, if you call it two times on the same kind of class, the same instance is returned.
 However, if you call it two times on different kind of class, different instances are returned
 */
+ (FLCodeInjector *) injectorForClass:(Class)thisClass;

/**
 The main class associated with the instance
 */
@property (strong, nonatomic, readonly) Class mainClass;

/**
 This method inject and execute the code block before forwarding the call to the original selector
 */
- (void)injectCodeBeforeSelector:(SEL)method code:(void (^)())completionBlock;

/**
 This method inject and execute the code block after forwarding the call to the original selector
 However, the code block is executed (obviously) before returning the result up to the stack
 */
- (void)injectCodeAfterSelector:(SEL)method code:(void (^)())completionBlock;




@end
