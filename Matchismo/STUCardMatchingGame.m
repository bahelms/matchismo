//
//  STUCardMatchingGame.m
//  Matchismo
//
//  Created by Barrett Helms on 2/8/14.
//  Copyright (c) 2014 Stanford iTunes U. All rights reserved.
//
#import "STUCardMatchingGame.h"

@interface STUCardMatchingGame ()
@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic) NSMutableArray *cards;
@end

@implementation STUCardMatchingGame

static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;

- (NSMutableArray *)cards
{
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(STUDeck *)deck
{
    if (self = [super init]) {
        for (int i=0; i < count; i++) {
            STUCard *card = [deck drawRandomCard];
            if (card)
                [self.cards addObject:card];
            else {
                self = nil;
                break;
            }
        }
    }
    return self;
}

- (STUCard *)cardAtIndex:(NSUInteger)index
{
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

- (void)chooseCardAtIndex:(NSUInteger)index
{
    STUCard *card = [self cardAtIndex:index];
    
    if (!card.isMatched) {
        if (card.isChosen)
            card.chosen = NO;
        else {
            // Match against other chosen cards
            for (STUCard *otherCard in self.cards) {
                if (otherCard.isChosen && !otherCard.isMatched) {
                    int matchScore = [card match:@[otherCard]];
                    if (matchScore) {
                        self.score += matchScore * MATCH_BONUS;
                        card.matched = YES;
                        otherCard.matched = YES;
                    } else {
                        self.score -= MISMATCH_PENALTY;
                        otherCard.chosen = NO;
                    }
                    break;  // can only choose 2 cards
                }
            }
            self.score -= COST_TO_CHOOSE;
            card.chosen = YES;
        }
    }
}

@end