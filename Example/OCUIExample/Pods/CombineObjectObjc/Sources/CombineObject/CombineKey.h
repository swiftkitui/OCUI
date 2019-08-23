//
//  CombineKey.h
//  CombineObject
//
//  Created by 张行 on 2019/8/5.
//  Copyright © 2019 张行. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_INLINE NSString * CombineKeyBox(NSString *key, NSString *normal) {
    if (!key || [key isEqualToString:@""]) {
        return normal;
    }
    return key;
}

@interface UIViewIdentifier : NSObject

@property (nonatomic, copy, class, readonly) NSString *userInteractionEnabled;
@property (nonatomic, copy, class, readonly) NSString *frame;
@property (nonatomic, copy, class, readonly) NSString *alpha;
@property (nonatomic, copy, class, readonly) NSString *hidden;
@property (nonatomic, copy, class, readonly) NSString *backgroundColor;

@end

@interface UILabelIdentifier : NSObject

@property (nonatomic, copy, class, readonly) NSString *text;
@property (nonatomic, copy, class, readonly) NSString *font;
@property (nonatomic, copy, class, readonly) NSString *textColor;
@property (nonatomic, copy, class, readonly) NSString *attributedText;

@end

@interface UISwitchIdentidier : NSObject

@property (nonatomic, copy, class, readonly) NSString *on;

@end

@interface UITextFieldIdentifier : NSObject

@property (nonatomic, copy, class, readonly) NSString *text;
@property (nonatomic, copy, class, readonly) NSString *placeholder;

@end

@interface UISliderIdentifier : NSObject

@property (nonatomic, copy, class, readonly) NSString *value;

@end

@interface UIProgressViewIdentifier : NSObject

@property (nonatomic, copy, class, readonly) NSString *progress;

@end

@interface UITextViewIdentifier : NSObject

@property (nonatomic, copy, class, readonly) NSString *text;

@end
