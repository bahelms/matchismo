//
//  STUCard.m
//  Matchismo
//
//  Created by Barrett Helms on 2/4/14.
//  Copyright (c) 2014 Stanford iTunes U. All rights reserved.
//
#import "STUCard.h"

@implementation STUCard

- (int)match:(id)otherCard
{
    int score = 0;
   
    for (STUCard *card in otherCard)
        if ([card.contents isEqualToString:self.contents])
            score = 1;
    return score;
}

@end