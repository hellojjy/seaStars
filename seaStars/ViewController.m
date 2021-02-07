//
//  ViewController.m
//  seaStars
//
//  Created by jjy on 2021/1/29.
//

#import "ViewController.h"
#import "GLView.h"


@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    int col = 0;
    int row = 0;
    CGFloat interval = 10;
    CGFloat width = (self.view.bounds.size.width - 4*interval)/3;
    CGFloat height = width;
    for (int index = 0; index < 3; index ++) {
        
        col = index % 3;
        row = index /3;
        GLView * view = [[GLView alloc] initWithFrame:CGRectMake(interval + col*(width + interval),80 + row * (height + interval) , width, height)];
        [self.view addSubview:view];
    }
    
  
}


@end
