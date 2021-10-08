//
//  Controller.h
//  7.计算器
//
//  Created by mac on 2021/9/27.
//  Copyright © 2021 mac. All rights reserved.
//

#import "ViewController.h"
#import "View.h"
#import "Model.h"


NS_ASSUME_NONNULL_BEGIN

@interface Controller : ViewController <sendPrintDelegate>

@property (nonatomic, strong) View* calculatorView;
@property (nonatomic, strong) Model* calculatorModel;
@property (nonatomic, copy) NSString* answer;

- (void)sendPrint:(NSString *)printString;

@end


NS_ASSUME_NONNULL_END
