//
//  View.m
//  7.计算器
//
//  Created by mac on 2021/9/27.
//  Copyright © 2021 mac. All rights reserved.
//

#import "View.h"
#import "Masonry.h"
#define SIZE (([UIScreen mainScreen].bounds.size.width - 15) / 4 - 15)

@implementation View

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    self.backgroundColor= [UIColor blackColor];
    
    _printArray = [[NSMutableArray alloc] init];
    _printString = [[NSString alloc] init];
    NSArray* grayArray = [[NSArray alloc] init];
    NSArray* orangeArray = [[NSArray alloc] init];
    grayArray = [NSArray arrayWithObjects:@"AC", @"(", @")", nil];
    orangeArray = [NSArray arrayWithObjects:@"+", @"-", @"×", @"÷", nil];
    _symbolJudgeFlag = 0;

    for (int i = 0; i < 4; i++) {
        for (int j = 0; j < 4; j++) {
            _baseButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            _baseButton.titleLabel.font = [UIFont systemFontOfSize:42];
            _baseButton.layer.cornerRadius = SIZE / 2;
            [_baseButton addTarget:self action:@selector(pressButton:) forControlEvents:UIControlEventTouchUpInside];
            _baseButton.tag = 204 + j + i * 4;
            [self addSubview:_baseButton];
            [_baseButton mas_makeConstraints:^(MASConstraintMaker* make) {
                make.bottom.equalTo(self).offset(-(90 + (SIZE + 15) * (i + 1)));
                make.left.equalTo(self).offset(15 + (SIZE + 15) * j);
                make.width.equalTo(@SIZE);
                make.height.equalTo(@SIZE);
            }];
            if (j < 3) {
                if (i < 3) {
                    [_baseButton setBackgroundColor:[UIColor colorWithWhite:0.15 alpha:1]];
                    [_baseButton setTitle:[NSString stringWithFormat:@"%d", i * 3 + j + 1]    forState:UIControlStateNormal];
                    [_baseButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                } else {
                    [_baseButton setBackgroundColor:[UIColor lightGrayColor]];
                    [_baseButton setTitle:grayArray[j] forState:UIControlStateNormal];
                    [_baseButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                }
            } else {
                [_baseButton setBackgroundColor:[UIColor colorWithRed:0.9 green:0.58 blue:0 alpha:1]];
                [_baseButton setTitle:orangeArray[i] forState:UIControlStateNormal];
                [_baseButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            }
        }
    }
    
    _zeroButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _zeroButton.titleLabel.font = [UIFont systemFontOfSize:42];
    _zeroButton.layer.cornerRadius = SIZE / 2;
    [_zeroButton addTarget:self action:@selector(pressButton:) forControlEvents:UIControlEventTouchUpInside];
    _zeroButton.tag = 201;
    [_zeroButton setBackgroundColor:[UIColor colorWithWhite:0.15 alpha:1]];
    [_zeroButton setTitle:@"0" forState:UIControlStateNormal];
    [_zeroButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self addSubview:_zeroButton];
    [_zeroButton mas_makeConstraints:^(MASConstraintMaker* make) {
        make.bottom.equalTo(self).offset(-90);
        make.left.equalTo(self).offset(15);
        make.width.equalTo(@(SIZE * 2 + 15));
        make.height.equalTo(@SIZE);
    }];
    UIButton* firstButton = [self viewWithTag:204];
    [_zeroButton.titleLabel mas_makeConstraints:^(MASConstraintMaker* make) {
        make.left.equalTo(firstButton.titleLabel);
    }];
    
    _pointButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _pointButton.titleLabel.font = [UIFont systemFontOfSize:42];
    _pointButton.layer.cornerRadius = SIZE / 2;
    [_pointButton addTarget:self action:@selector(pressButton:) forControlEvents:UIControlEventTouchUpInside];
    _pointButton.tag = 202;
    [_pointButton setBackgroundColor:[UIColor colorWithWhite:0.15 alpha:1]];
    [_pointButton setTitle:@"." forState:UIControlStateNormal];
    [_pointButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self addSubview:_pointButton];
    [_pointButton mas_makeConstraints:^(MASConstraintMaker* make) {
        make.bottom.equalTo(self).offset(-90);
        make.left.equalTo(_zeroButton.mas_right).offset(15);
        make.width.equalTo(@SIZE);
        make.height.equalTo(@SIZE);
    }];
    
    _equalButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _equalButton.titleLabel.font = [UIFont systemFontOfSize:42];
    _equalButton.layer.cornerRadius = SIZE / 2;
    [_equalButton addTarget:self action:@selector(pressEqualButton) forControlEvents:UIControlEventTouchUpInside];
    _equalButton.tag = 203;
    [_equalButton setBackgroundColor:[UIColor colorWithRed:0.9 green:0.58 blue:0 alpha:1]];
    [_equalButton setTitle:@"=" forState:UIControlStateNormal];
    [_equalButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self addSubview:_equalButton];
    [_equalButton mas_makeConstraints:^(MASConstraintMaker* make) {
        make.bottom.equalTo(self).offset(-90);
        make.left.equalTo(_pointButton.mas_right).offset(15);
        make.width.equalTo(@SIZE);
        make.height.equalTo(@SIZE);
    }];
    
    _printLabel = [[UILabel alloc] init];
    _printLabel.text = @"0";
    _printLabel.font = [UIFont systemFontOfSize:94];
    _printLabel.backgroundColor = [UIColor blackColor];
    _printLabel.textAlignment = NSTextAlignmentRight;
    _printLabel.textColor = [UIColor whiteColor];
    [self addSubview:_printLabel];
    [_printLabel mas_makeConstraints:^(MASConstraintMaker* make) {
        make.top.equalTo(self).offset(50);
        make.left.equalTo(self).offset(15);
        make.width.equalTo(@([UIScreen mainScreen].bounds.size.width - 30));
        make.height.equalTo(@([UIScreen mainScreen].bounds.size.height * 0.3));
    }];
    
    return self;
}

- (void)pressButton:(UIButton*)button {
    if (button.tag == 216) {
        _firstSymbol = [[NSString alloc] init];
        _secondSymbol = [[NSString alloc] init];
        _printString = [[NSString alloc] init];
        _printLabel.text = @"0";
        _printLabel.font = [UIFont systemFontOfSize:94];
        _symbolJudgeFlag = 0;
    } else {
        if (button.tag == 217) {
            _parenthesesNumber++;
        }
        if (button.tag == 218) {
            if (_parenthesesNumber == 0) {
                _symbolJudgeFlag = 1;
            }
            else _parenthesesNumber--;
        }
        if (_symbolJudgeFlag == 0) {
            _secondSymbol = button.titleLabel.text;
            if ([self isSymbolJudgeFlag:_firstSymbol :_secondSymbol]) {
                _symbolJudgeFlag = 1;
            }
            _firstSymbol = _secondSymbol;
        }
        _printString = [_printString stringByAppendingString:button.titleLabel.text];
        CGFloat printWidth=[(NSString *)_printString boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, 21) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:_printLabel.font.pointSize]} context:nil].size.width;
        if (printWidth > [UIScreen mainScreen].bounds.size.width - 30) {
            _printLabel.font = [UIFont systemFontOfSize:_printLabel.font.pointSize * 0.88];
            if (_printLabel.font.pointSize <= 25) {
                _firstSymbol = [[NSString alloc] init];
                _secondSymbol = [[NSString alloc] init];
                _printString = [[NSString alloc] init];
                _printLabel.text = @"少输点";
                _printLabel.font = [UIFont systemFontOfSize:94];
                _symbolJudgeFlag = 0;
                _parenthesesNumber = 0;
                _fontSizeJudgeFlag = 1;
            }
        }
        if (_fontSizeJudgeFlag == 0) {
            _printLabel.text = _printString;
        } else {
            _fontSizeJudgeFlag = 0;
        }
    }
}

- (void)pressEqualButton {
    if (_symbolJudgeFlag == 1 || _parenthesesNumber != 0) {
        _firstSymbol = [[NSString alloc] init];
        _secondSymbol = [[NSString alloc] init];
        _printString = [[NSString alloc] init];
        _printLabel.text = @"傻杯";
        _printLabel.font = [UIFont systemFontOfSize:94];
        _symbolJudgeFlag = 0;
        _parenthesesNumber = 0;
    } else {
        _printString = [_printString stringByAppendingString:@"#"];
        [_delegate sendPrint:_printString];
    }
}

- (BOOL) isSymbolJudgeFlag:(NSString*)first :(NSString*)second {
    int firstFlag = 0;
    int secondFlag = 0;
    if ([first isEqualToString:@"+"] || [first isEqualToString:@"-"] || [first isEqualToString:@"×"] || [first isEqualToString:@"÷"]) {
        firstFlag = 1;
    }
    if ([second isEqualToString:@"+"] || [second isEqualToString:@"-"] || [second isEqualToString:@"×"] || [second isEqualToString:@"÷"]) {
        secondFlag = 1;
    }
    if ([first isEqualToString:@"÷"] && [second isEqualToString:@"0"]) {
        return true;
    }
    if ([first isEqualToString:@"("] && [second isEqualToString:@")"]) {
        return true;
    }
    if ([first isEqualToString:@"("] && ([second isEqualToString:@"+"] || [second isEqualToString:@"-"] || [second isEqualToString:@"×"] || [second isEqualToString:@"÷"])) {
        return true;
    }
    if ([second isEqualToString:@"("] && (![first isEqualToString:@"+"] && ![first isEqualToString:@"-"] && ![first isEqualToString:@"×"] && ![first isEqualToString:@"÷"] && ![first isEqualToString:@""])) {
        return true;
    }
    if (firstFlag == 1 && secondFlag == 1) {
        return true;
    } else {
        return false;
    }
}
@end
