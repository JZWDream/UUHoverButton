//
//  UUHoverButton.m
//  UUIDDemo
//
//  Created by wdgeeker on 2020/1/15.
//  Copyright © 2020 100uu. All rights reserved.
//

#import "UUHoverButton.h"

@interface UUHoverButton ()
/// 当前是不是点出了悬浮球菜单。YES悬浮球菜单显示，NO悬浮球菜单贴边（隐藏一半）
@property (nonatomic, assign, getter=isOpenMenu) BOOL openMenu;
/// 选择菜单。YES从悬浮球菜单弹出多选项菜单 NO隐藏多选项菜单，只有悬浮球菜单
@property (nonatomic, assign, getter=isChooseMenu) BOOL chooseMenu;
/// GCD定时器
@property(nonatomic,strong)dispatch_source_t timer;
/// 时间段
@property (nonatomic, assign) int timeInterval;

@end

@implementation UUHoverButton

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        //添加单击手势
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
        [self addGestureRecognizer:tapGesture];
        
        //添加拖拽手势
        UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
        [self addGestureRecognizer:panGesture];
        
        [self loadTimer];
    }
    return self;
}

//定时器设置
-(void)loadTimer{
    if (self.timer) {
        dispatch_cancel(self.timer);
        self.timer = nil;
    }
    
    
    dispatch_queue_t queue = dispatch_get_main_queue();
    //创建一个定时器（dispatch_source_t本质上还是一个OC对象）
    self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    //设置定时器的各种属性
    dispatch_time_t start = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0*NSEC_PER_SEC));
    uint64_t interval = (uint64_t)(1.0*NSEC_PER_SEC);
    dispatch_source_set_timer(self.timer, start, interval, 0);
    
    
    //设置回调
    __weak typeof(self) weakSelf = self;
    dispatch_source_set_event_handler(self.timer, ^{
        //定时器需要执行的操作
        [weakSelf timerAction];
       
    });
    //启动定时器（默认是暂停）
    dispatch_resume(self.timer);
    
}

/// 启动定时器
- (void)resume {
    //重新加载一次定时器
    self.alpha = 1;
    self.timeInterval = 0;
    [self loadTimer];
    
}

/// 结束定时器
- (void)pause {
    self.timeInterval = 0;
    
    CGFloat newX = self.frame.origin.x;
    CGFloat newY = self.frame.origin.y;
    CGFloat newWidth = self.bounds.size.width;
    CGFloat newHeight = self.bounds.size.height;
    
    newX = (newX < [UIScreen mainScreen].bounds.size.width / 2.0 ? -20 : [UIScreen mainScreen].bounds.size.width - newWidth + 20);
    
    [UIView animateWithDuration:0.2 animations:^{
        self.alpha = 0.4;
        self.frame = CGRectMake(newX, newY, newWidth, newHeight);
    }];
    
    if (self.timer) {
        dispatch_cancel(self.timer);
        self.timer = nil;
    }
    
}

#pragma mark - 手势响应方法
- (void)handleTap:(UITapGestureRecognizer *)sender {
    
    NSLog(@"^^^^点击了悬浮球");
    
    if ([_delegate respondsToSelector:@selector(tapHoverButton:)]) {
        [_delegate tapHoverButton:self];
    }
    
}

- (void)handlePan:(UIPanGestureRecognizer *)sender {
    //获取偏移量
    CGPoint point = [sender translationInView:self];
    
    self.alpha = 1;
    
    switch (sender.state) {
            
        case UIGestureRecognizerStateBegan: {
            NSLog(@"拖拽手势开始----%f  %f", point.x, point.y);
            
            if ([_delegate respondsToSelector:@selector(panHoverButton:beginPoint:)]) {
                [_delegate panHoverButton:self beginPoint:point];
            }
        }
            break;
            
            case UIGestureRecognizerStateChanged: {
                NSLog(@"拖拽手势正在移动>>>>  %f  %f", point.x, point.y);
                
                if ([_delegate respondsToSelector:@selector(panHoverButton:changePoint:)]) {
                    [_delegate panHoverButton:self changePoint:point];
                }
            }
                break;
            
            case UIGestureRecognizerStateEnded: {
                
                //恢复定时器
                [self resume];
                
                //还原
                [sender setTranslation:CGPointZero inView:self];
                
                NSLog(@"拖拽手势结束====  %f   %f", point.x, point.y);
                
                if ([_delegate respondsToSelector:@selector(panHoverButton:endPoint:)]) {
                    [_delegate panHoverButton:self endPoint:point];
                }
            }
                break;
            
        default:
            break;
    }
    
}

#pragma mark - 定时器响应方法
- (void)timerAction {
    if (self.timeInterval >= 5) {
        [self pause];
    } else {
        self.timeInterval += 1;
        NSLog(@"开始计时-----%d", self.timeInterval);
    }
}

@end
