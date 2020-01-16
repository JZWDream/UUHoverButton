//
//  ViewController.m
//  UUHoverButtonDemo
//
//  Created by wdgeeker on 2020/1/16.
//  Copyright © 2020 100uu. All rights reserved.
//

#import "ViewController.h"
#import <UUHoverButton.h>

@interface ViewController ()<UUHoverButtonDelegate>
//悬浮球按钮
@property (nonatomic, strong) UUHoverButton *hoverBtn;
//记录按钮的初始位置
@property (nonatomic, assign) CGPoint hoverBtnCenter;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(20, 100, 50, 20);
    btn.backgroundColor = [UIColor purpleColor];
    [btn addTarget:self action:@selector(showHoverBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)showHoverBtn {
    self.hoverBtnCenter = self.hoverBtn.center;
}

#pragma mark - UUHoverButtonDelegate
- (void)tapHoverButton:(UUHoverButton *)btn {
    
}

- (void)panHoverButton:(UUHoverButton *)btn beginPoint:(CGPoint)point {
    NSLog(@"+++++++ x = %f y = %f", self.hoverBtn.frame.origin.x, self.hoverBtn.frame.origin.y);
}

- (void)panHoverButton:(UUHoverButton *)btn changePoint:(CGPoint)point {
    self.hoverBtn.frame = CGRectMake(self.hoverBtnCenter.x + point.x, self.hoverBtnCenter.y + point.y, self.hoverBtn.bounds.size.width, self.hoverBtn.bounds.size.height);
}

- (void)panHoverButton:(UUHoverButton *)btn endPoint:(CGPoint)point {
    
    CGFloat newX = self.hoverBtnCenter.x + point.x;
    CGFloat newY = self.hoverBtnCenter.y + point.y;
    CGFloat newWidth = self.hoverBtn.bounds.size.width;
    CGFloat newHeight = self.hoverBtn.bounds.size.height;
    
    newX = (newX < [UIScreen mainScreen].bounds.size.width / 2.0 ? 10 : [UIScreen mainScreen].bounds.size.width - newWidth - 10);
    
    [UIView animateWithDuration:0.2 animations:^{
        
        self.hoverBtn.frame = CGRectMake(newX, newY, newWidth, newHeight);
    } completion:^(BOOL finished) {
        
        self.hoverBtnCenter = self.hoverBtn.center;
        NSLog(@"////// hoverBtn.frame x = %f y = %f", self.hoverBtn.frame.origin.x, self.hoverBtn.frame.origin.y);
    }];
}


- (UUHoverButton *)hoverBtn {
    if (!_hoverBtn) {
        _hoverBtn = [UUHoverButton buttonWithType:UIButtonTypeCustom];
        _hoverBtn.frame = CGRectMake(10, 100, 50, 50);
        _hoverBtn.backgroundColor = [UIColor blueColor];
        _hoverBtn.clipsToBounds = YES;
        _hoverBtn.layer.cornerRadius = 25;
        _hoverBtn.delegate = self;
        
        if (@available(iOS 13.0, *)) {
            [[UIApplication sharedApplication].windows[0] addSubview:_hoverBtn];
        } else {
            [[UIApplication sharedApplication].delegate.window addSubview:_hoverBtn];
        }
    }
    return _hoverBtn;
}

@end
