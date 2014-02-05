//
//  STUPlayingCard.m
//  Matchismo
//
//  Created by Barrett Helms on 2/5/14.
//  Copyright (c) 2014 Stanford iTunes U. All rights reserved.
//
#import "STUPlayingCard.h"

@implementation STUPlayingCard

- (NSString *)contents
{
    NSArray *rankStrings = @[
        @"?", @"A", @"2", @"3",
        @"4", @"5", @"6", @"7",
        @"8", @"9", @"10", @"J", @"Q", @"K"
    ];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

@synthesize suit = _suit;
- (void)setSuit:(NSString *)suit
{
    if ([@[@"♣︎", @"♥︎", @"♦︎", @"♠︎"] containsObject:suit])
        _suit = suit;
}
- (NSString *)suit
{
    return _suit ? _suit : @"?";
}

@end