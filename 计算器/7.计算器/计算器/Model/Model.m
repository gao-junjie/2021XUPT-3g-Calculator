//
//  Model.m
//  7.计算器
//
//  Created by mac on 2021/9/27.
//  Copyright © 2021 mac. All rights reserved.
//

#import "Model.h"

@implementation Model

- (NSString*)getAnswer {
    _numberStack = [[NSMutableArray alloc] init];
    _symbolStack = [[NSMutableArray alloc] init];
    for (int i = 0; i < _printString.length;) {
        char tempChar = [_printString characterAtIndex:i];
        NSString *tempString =[[NSString alloc] initWithFormat:@"%c",tempChar];
        if (![self isSymbol:tempString]) {
            _tempNumberString = [[NSString alloc] init];
            while (![self isSymbol:tempString]) {
                _tempNumberString = [_tempNumberString stringByAppendingString:tempString];
                i++;
                char tempChar = [_printString characterAtIndex:i];
                tempString =[[NSString alloc] initWithFormat:@"%c",tempChar];
            }
            double temp = [_tempNumberString doubleValue];
            [_numberStack addObject:[NSNumber numberWithDouble:temp]];
        } else {
            if ([[_symbolStack lastObject] isEqualToString:@"("]) {
                if ([_printString characterAtIndex:i] == ')') {
                    [_symbolStack removeLastObject];
                } else {
                    char tempChar = [_printString characterAtIndex:i];
                    NSString *tempString =[[NSString alloc] initWithFormat:@"%c",tempChar];
                    [_symbolStack addObject:tempString];
                }
                i++;
            } else {
                char tempChar = [_printString characterAtIndex:i];
                NSString *tempString =[[NSString alloc] initWithFormat:@"%c",tempChar];
                if (![self precede:[_symbolStack lastObject] :tempString]) {
                    [_symbolStack addObject:tempString];
                    i++;
                } else {
                    NSNumber* bTemp = [_numberStack lastObject];
                    double b = [bTemp doubleValue];
                    [_numberStack removeLastObject];
                    NSNumber* aTemp = [_numberStack lastObject];
                    double a = [aTemp doubleValue];
                    [_numberStack removeLastObject];
                    NSString* s = [_symbolStack lastObject];
                    [_symbolStack removeLastObject];
                    double temp = [self calculation:a :b :s];
                    [_numberStack addObject:[NSNumber numberWithDouble:temp]];
                    if ([_printString characterAtIndex:i] == '#' && _symbolStack.count == 0) {
                        i++;
                    }
                }
            }
        }
    }
    double answerNumber = [[_numberStack lastObject] doubleValue];
    _answer = [self switchDoubleToNSStringWithoutZero:answerNumber];
    _answer = [self removeFloatAllZeroByString:_answer];
    return _answer;
}

//判断运算符优先级
- (int)priority:(NSString*)s {
    if ([s isEqualToString:@"("]) {
        return 4;
    } else if ([s isEqualToString:@"×"] || [s isEqualToString:@"÷"]) {
        return 3;
    } else if ([s isEqualToString:@"+"] || [s isEqualToString:@"-"]) {
        return 2;
    } else if ([s isEqualToString:@")"]) {
        return 1;
    } else {
        return 0;
    }
}

//比较运算符优先级
- (int)precede:(NSString*)firstSymbol :(NSString*) secondSymbol {
    if ([self priority:firstSymbol] < [self priority:secondSymbol]) {
        return 0;
    }
    return 1;
}

//判断符号并运算
- (double)calculation:(double)a :(double)b :(NSString*)c {
    if ([c isEqualToString:@"+"]) {
        return a + b;
    } else if ([c isEqualToString:@"-"]) {
        return a - b;
    } else if ([c isEqualToString:@"×"]) {
        return a * b;
    } else if ([c isEqualToString:@"÷"]) {
        if(b == 0) {
            NSLog(@"要寄啦！");
        }
        return a / b;
    }
    return 0;
}
   
//判断是否是运算符
- (int)isSymbol:(NSString*)ch {
    if ([ch isEqualToString:@"("] || [ch isEqualToString:@")"] || [ch isEqualToString:@"+"] || [ch isEqualToString:@"-"] || [ch isEqualToString:@"×"] || [ch isEqualToString:@"÷"] || [ch isEqualToString:@"#"]) {
        return 1;
    }
    return 0;
}

//小数点后删零
- (NSString *)switchDoubleToNSStringWithoutZero:(double) doubleNumber {
    //如果小数点后面全是0
    if (doubleNumber == (NSInteger)doubleNumber) {
        return [NSString stringWithFormat:@"%.0f",doubleNumber];
    }
    //如果是小数
    NSString *str = [NSString stringWithFormat:@"%6f",doubleNumber];
    NSInteger index = [str rangeOfString:@"."].location;
    if (index) {
        NSString *tempStr = [str substringFromIndex:index + 1];
        if (![tempStr intValue]) {
            return [str substringToIndex:index];
        } else if(![[tempStr substringFromIndex:1] intValue]) {
            return [str substringToIndex:index + 2];
        } else {
            return str;
        }
    }
    return str;
}

- (NSString*)removeFloatAllZeroByString:(NSString *)testNumber {
    
    NSString * outNumber = [NSString stringWithFormat:@"%@",@(testNumber.floatValue)];
    return outNumber;
}

@end
