//
//  ZHCollectionViewHeaderFooter.m
//  Pods
//
//  Created by 张行 on 2018/2/6.
//
//

#import "ZHCollectionViewHeaderFooter.h"

@implementation ZHCollectionViewHeaderFooter {
    ZHCollectionViewHeaderFooterCompletionHandle _headerBlock;
    ZHCollectionViewHeaderFooterCompletionHandle _footerBlock;
}

- (instancetype)initWithStyle:(ZHCollectionViewHeaderFooterStyle)style {
    if (self = [super init]) {
        _style = style;
    }
    return self;
}

- (void)setHeaderFooter:(UICollectionReusableView *)headerFooter section:(NSUInteger)section {
    switch (self.style) {
        case ZHCollectionViewHeaderFooterStyleHeader: {
            if (_headerBlock) {
                _headerBlock(headerFooter,section);
            }
        }
            break;
        case ZHCollectionViewHeaderFooterStyleFooter: {
            if (_footerBlock) {
                _footerBlock(headerFooter,section);
            }
        }
            break;
        default:
            break;
    }
}

- (void)configurationHeader:(void (^)(UICollectionReusableView *header, NSUInteger section))block {
    _headerBlock = block;
}

-(void)configurationFooter:(void (^)(UICollectionReusableView *footer, NSUInteger section))block {
    _footerBlock = block;
}

@end

