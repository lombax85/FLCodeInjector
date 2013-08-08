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