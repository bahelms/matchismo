//
//  STUPlayingCard.h
//  Matchismo
//
//  Created by Barrett Helms on 2/5/14.
//  Copyright (c) 2014 Stanford iTunes U. All rights reserved.
//
#import "STUCard.h"

@interface STUPlayingCard : STUCard

@property (nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;

+ (NSArray *)validSuits;
+ (NSUInteger)maxRank;

@end