//
//  GCDImageTest.m
//  GCDExercise
//
//  Created by apple on 16/3/11.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "GCDImageTest.h"

@interface GCDImageTest ()
{
    UIImageView *imageView;
}

@end


@implementation GCDImageTest

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    imageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 50, 300, 200)];
    imageView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:imageView];
    
    [self GCDImageTest];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)GCDImageTest
{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        
        __block UIImage *image = nil;
        dispatch_sync(queue, ^{
            NSString *urlString = @"http://cms.csdnimg.cn/article/201310/09/5254b7b6c74cb.jpg";
            NSURL *url = [NSURL URLWithString:urlString];
            NSData *imageData = [NSData dataWithContentsOfURL:url];
            if (imageData) {
                image = [UIImage imageWithData:imageData];
            }
        });
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            if (image) {
                imageView.image = image;
            }
        });
    });
}

@end
