//
//  Controller.m
//  7.计算器
//
//  Created by mac on 2021/9/27.
//  Copyright © 2021 mac. All rights reserved.
//

#import "Controller.h"

@interface Controller ()

@end

@implementation Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    _calculatorView = [[View alloc] init];
    _calculatorView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [self.view addSubview:_calculatorView];
    _calculatorView.delegate = self;
    
    _calculatorModel = [[Model alloc] init];
}

- (void)sendPrint:(NSString *)printString {
    _calculatorModel.printString = printString;
    NSLog(@"%@",_calculatorModel.printString);
    _answer = [_calculatorModel getAnswer];
    _calculatorView.printString = [[NSString alloc] init];
    _calculatorView.printLabel.text = _answer;
    CGFloat printWidth=[(NSString *)_answer boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, 21) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:94]} context:nil].size.width;
    if (printWidth > [UIScreen mainScreen].bounds.size.width - 30) {
        _calculatorView.printLabel.font = [UIFont systemFontOfSize:_calculatorView.printLabel.font.pointSize * 0.88];
    } else _calculatorView.printLabel.font = [UIFont systemFontOfSize:94];
}

@end
