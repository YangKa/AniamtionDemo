//
//  YKPopViewController.h
//  TestDemo
//
//  Created by qianzhan on 16/1/15.
//  Copyright © 2016年 YangKa. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CompleteBlock)(BOOL finish);

@interface YKPopViewController : UIViewController

- (void)popEditViewForVC:(UIViewController*)VC completeBlock:(CompleteBlock)block;
@end
