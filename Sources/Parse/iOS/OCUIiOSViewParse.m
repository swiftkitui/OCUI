//
//  OCUIiOSViewParse.m
//  OCUIExample
//
//  Created by 张行 on 2019/9/3.
//  Copyright © 2019 张行. All rights reserved.
//

#import "OCUIiOSViewParse.h"
#import "OCUI.h"

@implementation OCUIiOSViewParse

+ (void)loadParse {
    [self loadView];
    [self loadImage];
    [self loadText];
    [self loadList];
}

+ (void)loadView {
    [OCUIView<UIView *, OCUIView *> loadViewWithClassName:OCUIView.self makeViewBlock:^UIView * (OCUIView *node){
        return UIView.new;
    } configViewBlock:^(UIView * _Nonnull view, OCUIView * _Nonnull node) {
        
    }];
}

+ (void)loadImage {
    [OCUIView<UIImageView *, OCUIImage *> loadViewWithClassName:OCUIImage.self makeViewBlock:^UIImageView * (OCUIImage *node){
        return UIImageView.new;
    } configViewBlock:^(UIImageView * _Nonnull view, OCUIImage * _Nonnull node) {
        [node configViewWithClassName:OCUIView.self];
        if (node.contentImage) {
            view.image = node.contentImage;
        }
    }];
}

+ (void)loadText {
    [OCUIView<UILabel *, OCUIText *> loadViewWithClassName:OCUIText.self makeViewBlock:^UILabel * (OCUIText *node){
        return UILabel.new;
    } configViewBlock:^(UILabel * _Nonnull view, OCUIText * _Nonnull node) {
        [node configViewWithClassName:UIView.self];
        if (node.content) {
            view.text = node.content;
        }
        if (node.uiTextBind) {
            view.viewBind(node.uiTextBind, UILabelIdentifier.text);
        }
        if (node.isUIBold) {
            [self setFontDescriptorTraits:UIFontDescriptorTraitBold inLabel:view];
        }
        if (node.isUIItalic) {
            [self setFontDescriptorTraits:UIFontDescriptorTraitItalic inLabel:view];
        }
        
    }];
}

+ (void)loadList {
    [OCUIView<UITableView *, OCUIList *> loadViewWithClassName:OCUIList.self makeViewBlock:^UITableView * (OCUIList *node){
        if ([node.uiListStyle isKindOfClass:[OCUIGroupedListStyle class]]) {
            return [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        } else {
            return [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        }
    } configViewBlock:^(UITableView * _Nonnull view, OCUIList * _Nonnull node) {
        
    }];
}

+ (void)setFontDescriptorTraits:(UIFontDescriptorSymbolicTraits)traits
                        inLabel:(UILabel *)label {
    UIFont *font = label.font;
    UIFontDescriptorSymbolicTraits descriptorTraits = font.fontDescriptor.symbolicTraits | traits;
    UIFontDescriptor *descriptor = [font.fontDescriptor fontDescriptorWithSymbolicTraits:descriptorTraits];
    UIFont *traitsFont = [UIFont fontWithDescriptor:descriptor size:UIFont.systemFontSize];
    label.font = traitsFont;
}


@end
