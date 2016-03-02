//
//  UIViewController+TargetQuitViewController.m
//  LZLProject
//
//  Created by zhilong.lin on 16/3/2.
//  Copyright © 2016年 zhilong.lin. All rights reserved.
//

#import "UIViewController+TargetQuitViewController.h"

#import <objc/runtime.h>

static NSString *LZL_TARGET_QUIT_VIEWCONTROLLER_KEY = @"com.lzl.targetQuitViewController";

@implementation UIViewController(TargetQuitViewController)

#pragma setter and getter
- (void)setTargetQuitViewController:(UIViewController *)targetQuitViewController {
    objc_setAssociatedObject(self,
                             (__bridge const void *)LZL_TARGET_QUIT_VIEWCONTROLLER_KEY,
                             targetQuitViewController,
                             OBJC_ASSOCIATION_ASSIGN);
}

- (UIViewController *)targetQuitViewController {
    UIViewController *viewController = objc_getAssociatedObject(self,
                                                                (__bridge const void *)LZL_TARGET_QUIT_VIEWCONTROLLER_KEY);
    return viewController;
    
}

#pragma actions
- (void)backToTargetQuitViewController {
    if ([self isExistTargetQuitViewController:self.targetQuitViewController currentViewController:self]) {
        [self realBackToTargetQuitViewController:self.targetQuitViewController sourceViewController:self];
    }
}

- (BOOL)isExistTargetQuitViewController:(UIViewController *)target
                  currentViewController:(UIViewController *)current {
    UIViewController *tmpCurrent = current;
    UIViewController *tmpTarget = target;
    
    if (!tmpCurrent || !tmpTarget) {
        return NO;
    }
    
    if (tmpCurrent == tmpTarget) {
        return YES;
    } else if (tmpCurrent.navigationController) {
        NSArray *viewControllers = tmpCurrent.navigationController.viewControllers;
        if ([viewControllers containsObject:tmpTarget]) {
            return YES;
        } else {
            UIViewController *tmpVC = tmpCurrent.navigationController;
            if (tmpVC.presentingViewController) {
                tmpCurrent = tmpVC.presentingViewController;
                if ([tmpCurrent isKindOfClass:[UINavigationController class]]) {
                    tmpCurrent = ((UINavigationController *)tmpCurrent).viewControllers.lastObject;
                }
            } else {
                return NO;
            }
            return [self isExistTargetQuitViewController:tmpTarget
                                   currentViewController:tmpCurrent];
        }
    } else if (tmpCurrent.presentingViewController) {
        tmpCurrent = tmpCurrent.presentingViewController;
        if ([tmpCurrent isKindOfClass:[UINavigationController class]]) {
            tmpCurrent = ((UINavigationController *)tmpCurrent).viewControllers.lastObject;
        }
        return [self isExistTargetQuitViewController:tmpTarget
                               currentViewController:tmpCurrent];
    } else {
        return NO;
    }
    
    return NO;
}

- (void)realBackToTargetQuitViewController:(UIViewController *)target
                      sourceViewController:(UIViewController *)source {
    UIViewController *tmpSource = source;
    UIViewController *tmpTarget = target;
    
    if (tmpSource == tmpTarget) {
        return;
    } else if (tmpSource.navigationController
               && [tmpSource.navigationController.viewControllers containsObject:tmpTarget]) {
        NSArray *viewControllers = tmpSource.navigationController.viewControllers;
        if ([viewControllers containsObject:tmpTarget]) {
            NSMutableArray *multVCs = viewControllers.mutableCopy;
            for (NSInteger index = [multVCs indexOfObject:tmpTarget] + 1; index < multVCs.count;) {
                [multVCs removeObjectAtIndex:index];
            }
            [tmpSource.navigationController setViewControllers:multVCs.copy animated:YES];
        }
    } else if (tmpSource.presentingViewController) {
        dispatch_queue_t queue = dispatch_get_main_queue();
        dispatch_async(queue, ^{
            if (tmpTarget.navigationController) {
                NSArray *viewControllers = tmpTarget.navigationController.viewControllers;
                NSMutableArray *multVCs = viewControllers.mutableCopy;
                for (NSInteger index = [multVCs indexOfObject:tmpTarget] + 1; index < multVCs.count;) {
                    [multVCs removeObjectAtIndex:index];
                }
                
                [tmpTarget.navigationController setViewControllers:multVCs.copy animated:NO];
            }
        });
        dispatch_barrier_async(queue, ^{
            [tmpTarget dismissViewControllerAnimated:YES completion:nil];
        });
    } else {
        return;
    }
}
@end
