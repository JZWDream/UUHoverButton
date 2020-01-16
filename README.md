UUHoverButton
===

一个简单的悬浮球按钮

## Install

### From cocoapods
```
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '9.0'

target 'projectName' do
pod 'UUHoverButton', '~> 0.0.1'
end
```

### Manually
下载项目到本地，将UUHoverButton文件夹添加到项目中

## How To Use
```
hoverButton.delegate = self;//设置代理

/// 点击悬浮球
- (void)tapHoverButton:(UUHoverButton *_Nullable)btn;

/// 开始拖拽悬浮球
- (void)panHoverButton:(UUHoverButton *_Nullable)btn beginPoint:(CGPoint)point;

/// 拖拽悬浮球移动
- (void)panHoverButton:(UUHoverButton *_Nullable)btn changePoint:(CGPoint)point {
	hoverBtn.frame = CGRectMake(self.hoverBtnCenter.x + point.x, self.hoverBtnCenter.y + point.y, self.hoverBtn.bounds.size.width, self.hoverBtn.bounds.size.height);
}

/// 结束拖拽
- (void)panHoverButton:(UUHoverButton *_Nullable)btn endPoint:(CGPoint)point {
	CGFloat newX = self.hoverBtnCenter.x + point.x;
    CGFloat newY = self.hoverBtnCenter.y + point.y;
    CGFloat newWidth = self.hoverBtn.bounds.size.width;
    CGFloat newHeight = self.hoverBtn.bounds.size.height;
    
    newX = (newX < [UIScreen mainScreen].bounds.size.width / 2.0 ? 10 : [UIScreen mainScreen].bounds.size.width - newWidth - 10);
    
    [UIView animateWithDuration:0.2 animations:^{
        
        hoverBtn.frame = CGRectMake(newX, newY, newWidth, newHeight);
    } completion:^(BOOL finished) {
        //hoverBtnCenter:记录按钮原始位置的中心点
        hoverBtnCenter = self.hoverBtn.center;
    }];
}
```
具体细节请参看demo

