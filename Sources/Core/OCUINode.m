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
    BOOL _uiIsUseIntrinsicContentSize;
    UIEdgeInsets _uiContentEdgeInsets;
    
    CGFloat _uiMinFloatLengh;
    CGFloat _uiFloatLenght;
    OCUIConstraints *_uiFloatLenghtContraints;
    
    CGFloat _uiPriority;
    void(^_uiButtonAction)(void);
}
#pragma mark - OCUIRenderView

- (instancetype)init {
    if (self= [super init]) {
         _uiPriority = 1000;
        _uiIsUseIntrinsicContentSize = YES;
        _uiFloatLenghtContraints = [[OCUIConstraints alloc] initWithValue:0];
    }
    return self;
}

#pragma mark - OCUIRenderView
- (UIView *)makeOCUIView {
    return nil;
}

- (void)configOCUIView:(UIView *)view {}

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

- (BOOL)uiIsUseIntrinsicContentSize {
    return _uiIsUseIntrinsicContentSize;
}

- (UIEdgeInsets)uiContentEdgeInsets {
    return _uiContentEdgeInsets;
}

- (instancetype(^)(CGFloat))width {
    return ^OCUINode *(CGFloat width) {
        self->_uiWidth = width;
        return self;
    };
}

- (instancetype(^)(CGFloat))height {
    return ^OCUINode *(CGFloat height) {
        self->_uiHeight = height;
        return self;
    };
}

- (instancetype(^)(CGSize))size {
    return ^OCUINode *(CGSize size) {
        self->_uiWidth = size.width;
        self->_uiHeight = size.height;
        return self;
    };
}

- (instancetype(^)(BOOL))isUseIntrinsicContentSize {
    return ^OCUINode *(BOOL isUseIntrinsicContentSize) {
        self->_uiIsUseIntrinsicContentSize = isUseIntrinsicContentSize;
        return self;
    };
}

- (instancetype(^)(UIEdgeInsets))contentEdgeInsets {
    return ^OCUINode *(UIEdgeInsets contentEdgeInsets) {
        self->_uiContentEdgeInsets = contentEdgeInsets;
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

- (OCUIConstraints *)uiFloatLenghtContraints {
    return _uiFloatLenghtContraints;
}

- (instancetype(^)(CGFloat))minFloatLengh {
    return ^OCUINode *(CGFloat minFloatLengh) {
        self->_uiMinFloatLengh = minFloatLengh;
        return self;
    };
}

- (instancetype(^)(CGFloat))floatLenght {
    return ^OCUINode *(CGFloat floatLenght) {
        self->_uiFloatLenght = floatLenght;
        self.uiFloatLenghtContraints.valueBind.wrappedContent = @(floatLenght);
        return self;
    };
}

@end

@implementation OCUINode (Priority)

- (NSUInteger)uiPriority {
    return _uiPriority;
}

- (instancetype(^)(CGFloat))priority {
    return ^OCUINode *(CGFloat priority) {
        self->_uiPriority = priority;
        return self;
    };
}

@end
