//
//  OCUINode.m
//  OCUI
//
//  Created by 张行 on 2019/8/22.
//  Copyright © 2019 张行. All rights reserved.
//

#import "OCUINode.h"

@implementation OCUINode {
    CGFloat _uiWidth;
    CGFloat _uiHeight;
    CGFloat _uiMinFloatLengh;
    CGFloat _uiFloatLenght;
    CGFloat _uiPriority;
}
#pragma mark - OCUIRenderView

- (instancetype)init {
    if (self= [super init]) {
         _uiPriority = 1000;
    }
    return self;
}

@end

@implementation OCUINode (Frame)

- (CGFloat)uiWidth {
    return _uiWidth;
}

- (CGFloat)uiHeight {
    return _uiHeight;
}

- (CGSize)uiSize {
    return CGSizeMake(_uiWidth, _uiHeight);
}

- (OCUINode * _Nonnull (^)(CGFloat))width {
    return ^OCUINode *(CGFloat width) {
        self->_uiWidth = width;
        return self;
    };
}

- (OCUINode * _Nonnull (^)(CGFloat))height {
    return ^OCUINode *(CGFloat height) {
        self->_uiHeight = height;
        return self;
    };
}

- (OCUINode * _Nonnull (^)(CGSize))size {
    return ^OCUINode *(CGSize size) {
        self->_uiWidth = size.width;
        self->_uiHeight = size.height;
        return self;
    };
}


@end

@implementation OCUINode (FloatLayout)

- (CGFloat)uiFloatLenght {
    return MAX(_uiMinFloatLengh, _uiFloatLenght);
}

- (CGFloat)uiMinFloatLenght {
    return _uiMinFloatLengh;
}

- (OCUINode * _Nonnull (^)(CGFloat))minFloatLengh {
    return ^OCUINode *(CGFloat minFloatLengh) {
        self->_uiMinFloatLengh = minFloatLengh;
        return self;
    };
}

- (OCUINode * _Nonnull (^)(CGFloat))floatLenght {
    return ^OCUINode *(CGFloat floatLenght) {
        self->_uiFloatLenght = floatLenght;
        return self;
    };
}

@end

@implementation OCUINode (Priority)

- (NSUInteger)uiPriority {
    return _uiPriority;
}

- (OCUINode * _Nonnull (^)(CGFloat))priority {
    return ^OCUINode *(CGFloat priority) {
        self->_uiPriority = priority;
        return self;
    };
}

@end
