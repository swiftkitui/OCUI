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
    
    UIColor *_uiBackgroundColor;
    
    DriverBlockContent *_uiDriverBlockContent;
    
    void(^_uiButtonAction)(void);
    
    CombineBind *_uiBind;
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

- (OCUINode * _Nonnull (^)(BOOL))isUseIntrinsicContentSize {
    return ^OCUINode *(BOOL isUseIntrinsicContentSize) {
        self->_uiIsUseIntrinsicContentSize = isUseIntrinsicContentSize;
        return self;
    };
}

- (OCUINode * _Nonnull (^)(UIEdgeInsets))contentEdgeInsets {
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

- (OCUINode * _Nonnull (^)(CGFloat))minFloatLengh {
    return ^OCUINode *(CGFloat minFloatLengh) {
        self->_uiMinFloatLengh = minFloatLengh;
        return self;
    };
}

- (OCUINode * _Nonnull (^)(CGFloat))floatLenght {
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

- (OCUINode * _Nonnull (^)(CGFloat))priority {
    return ^OCUINode *(CGFloat priority) {
        self->_uiPriority = priority;
        return self;
    };
}

@end

@implementation OCUINode (OCUIView)

- (UIColor *)uiBackgroundColor {
    return _uiBackgroundColor;
}

- (OCUINode * _Nonnull (^)(UIColor * _Nonnull))backgroundColor {
    return ^OCUINode *(UIColor *backgroundColor) {
        self->_uiBackgroundColor = backgroundColor;
        return self;
    };
}

@end

@implementation OCUINode (List)

- (DriverBlockContent *)uiDriverBlockContent {
    return _uiDriverBlockContent;
}

- (OCUINode * _Nonnull (^)(DriverBlockContent * _Nonnull (^ _Nonnull)(void)))driverBlockContent {
    return ^OCUINode *(DriverBlockContent *(^block)(void)) {
        if (block) {
            self->_uiDriverBlockContent = block();
        }
        return self;
    };
}

@end

@implementation OCUINode (Button)

- (void (^)(void))uiButtonAction {
    return _uiButtonAction;
}

- (OCUINode * _Nonnull (^)(void (^ _Nonnull)(void)))action {
    return ^OCUINode *(void (^action)(void)) {
        self->_uiButtonAction = action;
        return self;
    };
}

@end

@implementation OCUINode (Bind)

- (CombineBind *)uiBind {
    return _uiBind;
}

- (OCUINode * _Nonnull (^)(CombineBind * _Nonnull))bind {
    return ^OCUINode *(CombineBind *bind) {
        self->_uiBind = bind;
        return self;
    };
}

@end
