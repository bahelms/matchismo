//
//  STUPlayingCard.m
//  Matchismo
//
//  Created by Barrett Helms on 2/5/14.
//  Copyright (c) 2014 Stanford iTunes U. All rights reserved.
//
#import "STUPlayingCard.h"

@implementation STUPlayingCard

+ (NSArray *)validSuits
{
    return @[@"♣︎", @"♥︎", @"♦︎", @"♠︎"];
}

+ (NSArray *)rankStrings
{
    return @[@"?", @"A", @"2", @"3",
             @"4", @"5", @"6", @"7",
             @"8", @"9", @"10", @"J", @"Q", @"K"];
}

+ (NSUInteger)maxRank { return [[self rankStrings] count] - 1; }

- (NSString *)contents
{
    NSArray *rankStrings = [[self class] rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

@synthesize suit = _suit;
- (void)setSuit:(NSString *)suit
{
    if ([[[self class] validSuits] containsObject:suit])
        _suit = suit;
}
- (NSString *)suit
{
    return _suit ? _suit : @"?";
}

- (void)setRank:(NSUInteger)rank
{
    if (rank <= [[self class] maxRank])
        _rank = rank;
}

- (int)match:(NSArray *)otherCards
{
    int score = 0;
    
    if ([otherCards count] == 1) {
        STUPlayingCard *otherCard = [otherCards firstObject];
        if (otherCard.rank == self.rank)
            score = 4;
        else if ([otherCard.suit isEqualToString:self.suit])
            score = 1;
    }
    return score;
}

@end