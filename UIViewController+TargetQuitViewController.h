//
//  UIViewController+TargetQuitViewController.h
//  LZLProject
//
//  Created by zhilong.lin on 16/3/2.
//  Copyright © 2016年 zhilong.lin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (TargetQuitViewController)

@property (nonatomic, weak) UIViewController *targetQuitViewController;

- (void)backToTargetQuitViewController;
@end
