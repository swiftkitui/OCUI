//
//  OCUIHeader.h
//  OCUIExample
//
//  Created by 张行 on 2019/9/3.
//  Copyright © 2019 张行. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <CombineObjectObjc/NSObject+CombineBind.h>

#if TARGET_OS_IPHONE || TARGET_OS_TV

#import <UIKit/UIKit.h>

#define OC_VIEW UIView

#elif TARGET_OS_MAC

#import <AppKit/AppKit.h>

#define OC_VIEW NSView

#endif
