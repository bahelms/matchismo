//
//  STUDeck.m
//  Matchismo
//
//  Created by Barrett Helms on 2/4/14.
//  Copyright (c) 2014 Stanford iTunes U. All rights reserved.
//
#import "STUDeck.h"

@interface STUDeck ()
@property (nonatomic) NSMutableArray *cards;
@end

@implementation STUDeck

- (NSMutableArray *)cards
{
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (void)addCard:(STUCard *)card atTop:(BOOL)atTop
{
    if (atTop)
        [self.cards insertObject:card atIndex:0];
    else
        [self.cards addObject:card];
    
}

- (void)addCard:(STUCard *)card
{
    [self addCard:card atTop:NO];
}

- (STUCard *)drawRandomCard
{
    STUCard *randomCard = nil;
    
    if ([self.cards count]) {
        unsigned index = arc4random() % [self.cards count];
        randomCard = self.cards[index];
        [self.cards removeObjectAtIndex:index];
    }
    
    return randomCard;
}

@end