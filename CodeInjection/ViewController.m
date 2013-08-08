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
    [injector injectCodeBeforeSelector:@selector(methodWithString:andInteger:andFloat:) code:^{
        NSLog(@"This code should be injected");
    }];
    
    FLCodeInjector *anotherInjector = [FLCodeInjector injectorForClass:[UITextField class]];
    [anotherInjector injectCodeBeforeSelector:@selector(inputView) code:^{
        NSLog(@"Before Input View");
    }];
    
    [anotherInjector injectCodeAfterSelector:@selector(inputView) code:^{
        NSLog(@"This is after");
    }];

    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)anAction:(id)sender {
    
    NSLog(@"%@", [self methodWithString:@"pippo" andInteger:2 andFloat:4.0f]);
    double aDouble = 10;
    NSLog(@"%g",aDouble);
}

-(NSString *)methodWithString:(NSString *)firstString andInteger:(int)anInteger andFloat:(float)aFloat
{
    NSLog(@"String: %@ - integer: %i - float: %f", firstString, anInteger, aFloat);
    return @"anotherString";
}



@end
