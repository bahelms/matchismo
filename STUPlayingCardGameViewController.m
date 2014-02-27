//
//  STUPlayingCardGameViewController.m
//  Matchismo
//
//  Created by Barrett Helms on 2/25/14.
//  Copyright (c) 2014 Stanford iTunes U. All rights reserved.
//
#import "STUPlayingCardGameViewController.h"
#import "STUPlayingCardDeck.h"

@implementation STUPlayingCardGameViewController

- (STUDeck *)createDeck {
    return [[STUPlayingCardDeck alloc] init];
}


- (STUCardMatchingGame *)createGame {
    return [[STUCardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                usingDeck:[self createDeck]
                                              matchNumber:1];
}
@end