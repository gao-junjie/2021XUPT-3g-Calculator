//
//  Model.h
//  7.计算器
//
//  Created by mac on 2021/9/27.
//  Copyright © 2021 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Model : NSObject

@property (nonatomic, copy) NSString* printString;
@property (nonatomic, strong) NSMutableArray* numberStack;
@property (nonatomic, strong) NSMutableArray* symbolStack;
@property (nonatomic, copy) NSString* answer;
@property (nonatomic, copy) NSString* tempNumberString;

- (NSString*)getAnswer;
- (int)priority:(NSString*)s;
- (int)precede:(NSString*)firstSymbol :(NSString*) secondSymbol;
- (double)calculation:(double)a :(double)b :(NSString*)c;
- (int)isSymbol:(NSString*)ch;
- (NSString *)switchDoubleToNSStringWithoutZero:(double) doubleNumber;
@end

NS_ASSUME_NONNULL_END
