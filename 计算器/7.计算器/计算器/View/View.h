//
//  View.h
//  7.计算器
//
//  Created by mac on 2021/9/27.
//  Copyright © 2021 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol sendPrintDelegate <NSObject>

- (void)sendPrint:(NSString*)printString;

@end

@interface View : UIView

@property (nonatomic, strong) UIButton* baseButton;
@property (nonatomic, strong) UIButton* equalButton;
@property (nonatomic, strong) UIButton* zeroButton;
@property (nonatomic, strong) UIButton* pointButton;
@property (nonatomic, strong) UILabel* printLabel;
@property (nonatomic, copy) NSString* printString;
@property (nonatomic, copy) NSString* firstSymbol;
@property (nonatomic, copy) NSString* secondSymbol;
@property (nonatomic, strong) NSMutableArray* printArray;
@property (nonatomic, assign) int symbolJudgeFlag;
@property (nonatomic, assign) int fontSizeJudgeFlag;
@property (nonatomic, assign) int parenthesesNumber;
@property (nonatomic, assign) id<sendPrintDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
