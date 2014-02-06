//
//  STUViewController.m
//  Matchismo
//
//  Created by Barrett Helms on 2/3/14.
//  Copyright (c) 2014 Stanford iTunes U. All rights reserved.
//
#import "STUViewController.h"
#import "STUPlayingCardDeck.h"

@interface STUViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) STUDeck *deck;
@property (nonatomic) int flipCount;
@end

@implementation STUViewController

- (STUDeck *)deck
{
    if (!_deck) _deck = [[STUPlayingCardDeck alloc] init];
    return _deck;
}

- (void)setFlipCount:(int)flipCount
{
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
}

- (IBAction)touchCardButton:(UIButton *)sender
{
    if ([sender.currentTitle length]) {
        [sender setBackgroundImage:[UIImage imageNamed:@"cardback"]
                          forState:UIControlStateNormal];
        [sender setTitle:@"" forState:UIControlStateNormal];
    } else {
        [sender setBackgroundImage:[UIImage imageNamed:@"cardfront"]
                          forState:UIControlStateNormal];
        [sender setTitle:@"A♣︎" forState:UIControlStateNormal];
    }
    self.flipCount++;
}

@end