//
//  ViewController.m
//  CodeInjection
//
//  Created by Lombardo on 07/08/13.
//  Copyright (c) 2013 Lombardo. All rights reserved.
//

#import "ViewController.h"
#import "FLCodeInjector.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    FLCodeInjector *injector = [FLCodeInjector injectorForClass:[self class]];
    
    [injector injectCodeBeforeSelector:@selector(methodWithString:andInteger:andFloat:) code:^(id sender) {
        NSLog(@"This code should be injected in: %@", sender);
    }];
    
    /*
    FLCodeInjector *anotherInjector = [FLCodeInjector injectorForClass:[UITextField class]];
    [anotherInjector injectCodeBeforeSelector:@selector(inputView) code:^{
        NSLog(@"Before Input View");
    }];
    
    [anotherInjector injectCodeAfterSelector:@selector(inputView) code:^{
        NSLog(@"This is after");
    }];
    */
    
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)anAction:(id)sender {
    
    
    NSLog(@"%@", [self methodWithString:@"pippo" andInteger:2 andFloat:4.0f]);
    
    /*
    
    FLCodeInjector *frameInjector = [FLCodeInjector injectorForClass:[UIView class]];
    [frameInjector injectCodeBeforeSelector:@selector(frame) code:^{
        NSLog(@"frame?");
    }];
    
    NSLog(@"View Frame is: %@", NSStringFromCGRect(self.view.frame));
     */
    /*
    
    CGRect* aRect = malloc(sizeof(CGRect));
    CGRect anotherRect = CGRectMake(10, 10, 10, 10);
    
    int pippo = 10;
    int* pluto = malloc(sizeof(int));
    */
    
    
}

-(NSString *)methodWithString:(NSString *)firstString andInteger:(int)anInteger andFloat:(float)aFloat
{
    NSLog(@"String: %@ - integer: %i - float: %f", firstString, anInteger, aFloat);
    return @"anotherString";
}



@end
