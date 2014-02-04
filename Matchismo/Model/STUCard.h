//
//  STUCard.h
//  Matchismo
//
//  Created by Barrett Helms on 2/4/14.
//  Copyright (c) 2014 Stanford iTunes U. All rights reserved.
//
#import <Foundation/Foundation.h>

@interface STUCard : NSObject

@property (nonatomic) NSString *contents;
@property (nonatomic, getter=isChosen) BOOL chosen;
@property (nonatomic, getter=isMatched) BOOL matched;

- (int)match:(NSArray *)otherCards;

@end