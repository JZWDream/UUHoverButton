//
//  UUHoverButton.h
//  UUIDDemo
//
//  Created by wdgeeker on 2020/1/15.
//  Copyright © 2020 100uu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UUHoverButtonDelegate;

NS_ASSUME_NONNULL_BEGIN

@interface UUHoverButton : UIButton

@property (nonatomic, weak) id<UUHoverButtonDelegate> delegate;

@end

NS_ASSUME_NONNULL_END


@protocol UUHoverButtonDelegate <NSObject>

/// 点击悬浮球
- (void)tapHoverButton:(UUHoverButton *_Nullable)btn;

/// 开始拖拽悬浮球
- (void)panHoverButton:(UUHoverButton *_Nullable)btn beginPoint:(CGPoint)point;

/// 拖拽悬浮球移动
- (void)panHoverButton:(UUHoverButton *_Nullable)btn changePoint:(CGPoint)point;

/// 结束拖拽
- (void)panHoverButton:(UUHoverButton *_Nullable)btn endPoint:(CGPoint)point;

@end
