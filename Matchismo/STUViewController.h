//
//  STUViewController.h
//  Matchismo
//
//  Created by Barrett Helms on 2/3/14.
//  Copyright (c) 2014 Stanford iTunes U. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "STUDeck.h"

@interface STUViewController : UIViewController

- (STUDeck *)createDeck;  // abstract

@end