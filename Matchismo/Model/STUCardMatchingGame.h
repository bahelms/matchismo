//
//  STUCardMatchingGame.h
//  Matchismo
//
//  Created by Barrett Helms on 2/8/14.
//  Copyright (c) 2014 Stanford iTunes U. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "STUDeck.h"
#import "STUCard.h"

@interface STUCardMatchingGame : NSObject

@property (nonatomic, readonly) NSInteger score;
@property (nonatomic, readonly) NSString *matchMessage;

// Designated init
- (instancetype)initWithCardCount:(NSUInteger)count
                        usingDeck:(STUDeck *)deck;
- (void)chooseCardAtIndex:(NSUInteger)index;
- (STUCard *)cardAtIndex:(NSUInteger)index;

@end