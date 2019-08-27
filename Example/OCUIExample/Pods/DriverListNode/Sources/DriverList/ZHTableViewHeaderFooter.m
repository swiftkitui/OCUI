//
//  ZHTableViewHeaderFooter.m
//  Pods
//
//  Created by 张行 on 2017/3/18.
//
//

#import "ZHTableViewHeaderFooter.h"

@implementation ZHTableViewHeaderFooter {
    ZHTableViewHeaderFooterCompletionHandle _headerBlock;
    ZHTableViewHeaderFooterCompletionHandle _footerBlock;
}

- (instancetype)initWithStyle:(ZHTableViewHeaderFooterStyle)style {
    if (self = [super init]) {
        _style = style;
    }
    return self;
}

- (void)setHeaderFooter:(UITableViewHeaderFooterView *)headerFooter section:(NSUInteger)section {
    switch (self.style) {
        case ZHTableViewHeaderFooterStyleHeader: {
            if (_headerBlock) {
                _headerBlock(headerFooter,section);
            }
        }
            break;
        case ZHTableViewHeaderFooterStyleFooter: {
            if (_footerBlock) {
                _footerBlock(headerFooter,section);
            }
        }
            break;
        default:
            break;
    }
}

- (void)configurationHeader:(void (^)(UITableViewHeaderFooterView *header, NSUInteger section))block {
    _headerBlock = block;
}

-(void)configurationFooter:(void (^)(UITableViewHeaderFooterView *footer, NSUInteger section))block {
    _footerBlock = block;
}

@end
