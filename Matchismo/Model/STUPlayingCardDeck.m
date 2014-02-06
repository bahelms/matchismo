//
//  STUPlayingCardDeck.m
//  Matchismo
//
//  Created by Barrett Helms on 2/6/14.
//  Copyright (c) 2014 Stanford iTunes U. All rights reserved.
//
#import "STUPlayingCardDeck.h"
#import "STUPlayingCard.h"

@implementation STUPlayingCardDeck

- (instancetype)init
{
    if (self = [super init]) {
        for (NSString *suit in [STUPlayingCard validSuits]) {
            for (NSUInteger rank=1; rank <= [STUPlayingCard maxRank]; rank++) {
                STUPlayingCard *card = [[STUPlayingCard alloc] init];
                card.suit = suit;
                card.rank = rank;
                [self addCard:card];
            }
        }
    }
    return self;
}

@end