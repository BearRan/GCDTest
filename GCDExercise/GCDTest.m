//
//  GCDTest.m
//  GCDExercise
//
//  Created by apple on 16/3/14.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "GCDTest.h"

@implementation GCDTest

- (void)viewDidLoad
{
    [self demo2];
}

//  创建主列队 (串行)
- (void)MainQueue
{
    dispatch_queue_t queue = dispatch_get_main_queue();
}

//  自己创建的列队
- (void)MyQueue
{
    dispatch_queue_t queue1 = dispatch_queue_create("BearQueue1", NULL);
    
    //  串行
    dispatch_queue_t queue2 = dispatch_queue_create("BearQueue2", DISPATCH_QUEUE_SERIAL);
    
    //  并行
    dispatch_queue_t queue3 = dispatch_queue_create("BearQueue3", DISPATCH_QUEUE_CONCURRENT);
}

//  全局列队 (并行)
- (void)GlobalQueue
{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
}

- (void)demo1
{
    NSLog(@"之前 - %@", [NSThread currentThread]);
    dispatch_sync(dispatch_get_main_queue(), ^{
        NSLog(@"sync - %@", [NSThread currentThread]);
    });
    
    NSLog(@"之后 - %@", [NSThread currentThread]);
}

- (void)demo2
{
    
    dispatch_queue_t queue = dispatch_queue_create("BearQueue", DISPATCH_QUEUE_SERIAL);
    NSLog(@"之前 - %@", [NSThread currentThread]);
    
    dispatch_async(queue, ^{
        NSLog(@"sync 之前 - %@", [NSThread currentThread]);
        
        dispatch_sync(queue, ^{
            NSLog(@"sync - %@", [NSThread currentThread]);
        });
        
        NSLog(@"sync之后 - %@", [NSThread currentThread]);
    });
    
    NSLog(@"之后 - %@", [NSThread currentThread]);
}

@end
