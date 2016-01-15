//
//  YKPopViewController.m
//  TestDemo
//
//  Created by qianzhan on 16/1/15.
//  Copyright © 2016年 YangKa. All rights reserved.
//

#import "YKPopViewController.h"

@interface YKPopViewController ()
@property (nonatomic, strong) UIViewController *rootVC;
@property (nonatomic, strong) UIView *maskView;
@property (nonatomic, strong) CompleteBlock finishBlock;
@end

@implementation YKPopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height /2.0);
    
    self.view.backgroundColor = [UIColor grayColor];
    
    //加个阴影
    self.view.layer.shadowColor = [UIColor blackColor].CGColor;
    self.view.layer.shadowOffset = CGSizeMake(0.5, 0.5);
    self.view.layer.shadowOpacity = 0.8;
    self.view.layer.shadowRadius = 5;
    
    //关闭btn
    UIButton * closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    closeBtn.frame = CGRectMake(15, 0, 50, 40);
    [closeBtn setTitle:@"关闭" forState:UIControlStateNormal];
    [closeBtn setTitleColor:[UIColor colorWithRed:217/255.0 green:110/255.0 blue:90/255.0 alpha:1] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:closeBtn];
}

- (void)popEditViewForVC:(UIViewController*)VC completeBlock:(CompleteBlock)block{
    
    _rootVC = VC;
    _finishBlock = block;
    
    //rootVC上的maskView
    _maskView = ({
        UIView * maskView = [[UIView alloc]initWithFrame:_rootVC.view.frame];
        maskView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        maskView.alpha = 0;
        maskView;
    });
    [_rootVC.view addSubview:_maskView];

    [_rootVC addChildViewController:self];
    [_rootVC.view addSubview:self.view];
    
    [self show];
}


- (void)close{

    CGRect frame = self.view.frame;
    frame.origin.y += _rootVC.view.frame.size.height/2;
    
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        //maskView隐藏
        [_maskView setAlpha:0.f];
        //popView下降
        self.view.frame = frame;
        
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            //变为初始值
            [_rootVC.view.layer setTransform:CATransform3DIdentity];
            
        } completion:^(BOOL finished) {
            
            
            
            //移除
            [self.view removeFromSuperview];
            [self removeFromParentViewController];
            
            self.finishBlock(YES);
            
        }];
        
    }];
    
    
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        //和上个动画同时进行 感觉更丝滑
        [_rootVC.view.layer setTransform:[self firstTransform]];
        
    } completion:^(BOOL finished) {
        
    }];
    
    
}

- (void)show
{
    [[UIApplication sharedApplication].windows[0] addSubview:self.view];
    
    CGRect frame = self.view.frame;
    frame.origin.y = _rootVC.view.frame.size.height/2.0;
    
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        [_rootVC.view.layer setTransform:[self firstTransform]];
        
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            
            [_rootVC.view.layer setTransform:[self secondTransform]];
            //显示maskView
            [_maskView setAlpha:0.5f];
            //popView上升
            self.view.frame = frame;
            
        } completion:^(BOOL finished) {
            
        }];
        
    }];
    
}

- (CATransform3D)firstTransform{
    CATransform3D t1 = CATransform3DIdentity;
    t1.m34 = 1.0/-900;
    //带点缩小的效果
    t1 = CATransform3DScale(t1, 0.95, 0.95, 1);
    //绕x轴旋转
    t1 = CATransform3DRotate(t1, 15.0 * M_PI/180.0, 1, 0, 0);
    return t1;
    
}

- (CATransform3D)secondTransform{
    
    CATransform3D t2 = CATransform3DIdentity;
    t2.m34 = [self firstTransform].m34;
    //向上移
    t2 = CATransform3DTranslate(t2, 0, self.view.frame.size.height * (-0.08), 0);
    //第二次缩小
    t2 = CATransform3DScale(t2, 0.8, 0.8, 1);
    return t2;
}

@end
