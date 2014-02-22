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
@property (nonatomic, readwrite) NSString *matchMessage;
@property (nonatomic, readwrite) NSMutableArray *matchHistory;
@property (nonatomic) NSMutableArray *cards;

@end

@implementation STUCardMatchingGame

static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;

// Designated init
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

- (NSMutableArray *)matchHistory
{
    if (!_matchHistory) _matchHistory = [NSMutableArray array];
    return _matchHistory;
}

- (NSMutableArray *)cards
{
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (STUCard *)cardAtIndex:(NSUInteger)index
{
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

- (void)chooseCardAtIndex:(NSUInteger)index
{
    STUCard *card = [self cardAtIndex:index];
    
    if (!card.isMatched) {
        if (card.isChosen) {
            card.chosen = NO;
            self.matchMessage = nil;
        }
        else {
            self.matchMessage = [NSString stringWithFormat:@"%@", card.contents];
            NSMutableArray *chosenCards = [self findChosenCards];
            if (!([chosenCards count] < self.gameMode))
                [self match:card withCards:chosenCards];
            self.score -= COST_TO_CHOOSE;
            card.chosen = YES;
        }
    }
}

- (NSMutableArray *)findChosenCards
{
    NSMutableArray *chosenCards = [[NSMutableArray alloc] init];
    
    for (STUCard *otherCard in self.cards)
        if (otherCard.isChosen && !otherCard.isMatched)
            if ([chosenCards count] < self.gameMode) [chosenCards addObject:otherCard];
    return chosenCards;
}

- (void)match:(STUCard *)card withCards:(NSMutableArray *)chosenCards
{
    // Match each card with self and record results
    for (STUCard *otherCard in chosenCards) {
        int matchScore = [card match:otherCard];
        NSString *message = nil;
        
        if (matchScore) {
            self.score += matchScore * MATCH_BONUS;
            card.matched = YES;
            otherCard.matched = YES;
            message = @"Matched %@ with %@!";
        } else {
            self.score -= MISMATCH_PENALTY - COST_TO_CHOOSE;
            otherCard.chosen = NO;
            message = @"%@ and %@ don't match";
        }
        
        // Disable all cards even if only some of them matched
        if (self.gameMode > 1 && card.isMatched) {
            otherCard.matched = YES;
            otherCard.chosen = YES;
        }
        
        self.matchMessage = [NSString stringWithFormat:message,
                             card.contents, otherCard.contents];
        [self.matchHistory addObject:self.matchMessage];
    }
    
    // Match other cards to themselves, if any
    if ([chosenCards count] > 1) {
        STUCard *nextCard = [chosenCards lastObject];
        [chosenCards removeLastObject];
        [self match:nextCard withCards:chosenCards];
    }
}

@end