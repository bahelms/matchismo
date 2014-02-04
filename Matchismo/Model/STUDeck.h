//
//  STUDeck.h
//  Matchismo
//
//  Created by Barrett Helms on 2/4/14.
//  Copyright (c) 2014 Stanford iTunes U. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "STUCard.h"

@interface STUDeck : NSObject

- (void)addCard:(STUCard *)card atTop:(BOOL)atTop;
- (void)addCard:(STUCard *)card;
- (STUCard *)drawRandomCard;

@end