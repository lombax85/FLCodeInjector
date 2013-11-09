This Class, created by Fabio Lombardo ( http://www.lombax.it ) acts as a simple
code injector. It can be used to execute blocks of code BEFORE or AFTER a
specific method of an Objective-C object.
The main use is for debugging purposes
It uses method swizzling and supports the following features:

- Swizzling methods with return type of kind: int, float, long, double, id and void
- Swizzling methods with variable number of arguments, tested with the following type: int, float, long, double, id
- TODO: structs!!!

Feel free to add or modify features of this code.

How to use?

This example implementation executes the NSLog each time inputView is called (even by the system) on UITextField

    FLCodeInjector *anotherInjector = [FLCodeInjector injectorForClass:[UITextField class]];
    [anotherInjector injectCodeBeforeSelector:@selector(inputView) code:^(id sender){
        NSLog(@"Before Input View. Method executed by %@", sender);
    }];
    
NOTE: take care when swizzling event handling method like touchesBegan:withEvent on UIView.
Let's look at this example:

Swizzle in this way:

    FLCodeInjector *injector = [FLCodeInjector injectorForClass:[UIView class]];
    [injector injectCodeBeforeSelector:@selector(touchesBegan:withEvent:) code:^(id sender){
        NSLog(@"Self: %@", sender);
    }];
    
then tap on a UITableViewCell --> your app will crash. Why?
Since FLCodeInjector forward the call to a swizzled selector (adding a SWZ prefix), there is a problem when the destination method forward the call to someone else.
When you swipe on UITableViewCell for example, the swipe is received by UITableViewCellContentView (UIView subclass) so the method is correctly swizzled and your code will be executed, but the original touchesBegan:withEvent method forwards that call upwards to the tableview controller (maybe to check if the swipe to edit is enabled). This forward seems to be made on the method signature (Apple internal implementation), since the method signature is different (SWZ prefix) you will receive an Unrecognized Selector exception on the UITableViewController instance.
I'm working on a solution to this problem, at the moment you'll have to try and try, adding a swizzle for each subsequent responder in the chain, until the chain ends (usually with AppDelegate) like this way

    FLCodeInjector *injector = [FLCodeInjector injectorForClass:[UIView class]];
    [injector injectCodeBeforeSelector:@selector(touchesBegan:withEvent:) code:^(id sender){
        NSLog(@"Self: %@", sender);
    }];

    FLCodeInjector *injector2 = [FLCodeInjector injectorForClass:[UIViewController class]];
    [injector2 injectCodeBeforeSelector:@selector(touchesBegan:withEvent:) code:^(id sender){
        NSLog(@"Self: %@", sender);
    }];
    
    FLCodeInjector *injector3 = [FLCodeInjector injectorForClass:[UIApplication class]];
    [injector3 injectCodeBeforeSelector:@selector(touchesBegan:withEvent:) code:^(id sender){
        NSLog(@"Self: %@", sender);
    }];
    
    FLCodeInjector *injector4 = [FLCodeInjector injectorForClass:[AppDelegate class]];
    [injector4 injectCodeBeforeSelector:@selector(touchesBegan:withEvent:) code:^(id sender){
        NSLog(@"Self: %@", sender);
    }];
    
    FLCodeInjector *injector5 = [FLCodeInjector injectorForClass:[UITableViewCellContentView class]];
    [injector5 injectCodeBeforeSelector:@selector(touchesBegan:withEvent:) code:^(id sender){
        NSLog(@"Self: %@", sender);
    }];
     
