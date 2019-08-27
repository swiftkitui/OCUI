//
//  AutomitcHeightCell.m
//  DriverListExample
//
//  Created by 张行 on 2019/8/19.
//  Copyright © 2019 张行. All rights reserved.
//

#import "AutomitcHeightCell.h"
#import <Masonry/Masonry.h>

@interface AutomitcHeightCell ()

@property (nonatomic, strong) UILabel *multiLineLabel;

@end

@implementation AutomitcHeightCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.multiLineLabel];
        [self.multiLineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_offset(12);
            make.top.mas_offset(12);
            make.trailing.mas_offset(-12);
        }];
    }
    return self;
}

- (CGSize)sizeThatFits:(CGSize)size {
    self.multiLineLabel.preferredMaxLayoutWidth = size.width - 12 - 12;
    return CGSizeMake(size.width, 12 + self.multiLineLabel.intrinsicContentSize.height + 12);
}

- (UILabel *)multiLineLabel {
    if (!_multiLineLabel) {
        _multiLineLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _multiLineLabel.numberOfLines = 0;
        _multiLineLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    return _multiLineLabel;
}

@end
