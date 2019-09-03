//
//  OCUIiOSViewParse.m
//  OCUIExample
//
//  Created by 张行 on 2019/9/3.
//  Copyright © 2019 张行. All rights reserved.
//

#import "OCUIiOSViewParse.h"
#import "OCUIMaker.h"

@implementation OCUIiOSViewParse

+ (void)loadParse {
    [self loadView];
    [self loadImage];
    [self loadText];
}

+ (void)loadView {
    [OCUIView<UIView *, OCUIView *> loadViewWithClassName:OCUIView.self makeViewBlock:^UIView * _Nonnull{
        return UIView.new;
    } configViewBlock:^(UIView * _Nonnull view, OCUIView * _Nonnull node) {
        if (node.uiBackgroundColor) {
            view.backgroundColor = node.uiBackgroundColor;
        }
    }];
}

+ (void)loadImage {
    [OCUIView<UIImageView *, OCUIImage *> loadViewWithClassName:OCUIImage.self makeViewBlock:^UIImageView * _Nonnull{
        return UIImageView.new;
    } configViewBlock:^(UIImageView * _Nonnull view, OCUIImage * _Nonnull node) {
        [node configViewWithClassName:OCUIView.self];
        if (node.contentImage) {
            view.image = node.contentImage;
        }
    }];
}

+ (void)loadText {
    [OCUIView<UILabel *, OCUIText *> loadViewWithClassName:OCUIText.self makeViewBlock:^UILabel * _Nonnull{
        return UILabel.new;
    } configViewBlock:^(UILabel * _Nonnull view, OCUIText * _Nonnull node) {
        [node configViewWithClassName:UIView.self];
        if (node.content) {
            view.text = node.content;
        }
        if (node.uiTextBind) {
            view.viewBind(node.uiTextBind, UILabelIdentifier.text);
        }
    }];
}

@end
