//
//  STUViewController.m
//  Matchismo
//
//  Created by Barrett Helms on 2/3/14.
//  Copyright (c) 2014 Stanford iTunes U. All rights reserved.
//
#import "STUViewController.h"
#import "STUPlayingCardDeck.h"
#import "STUCardMatchingGame.h"

@interface STUViewController ()
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *gameModeSegment;
@property (weak, nonatomic) IBOutlet UILabel *matchAlertLabel;
@property (nonatomic) STUCardMatchingGame *game;
@property (nonatomic) NSMutableArray *matchHistory;
@end

@implementation STUViewController

- (STUCardMatchingGame *)game
{
    if (!_game) _game = [self createGame];
    return _game;
}

- (NSMutableArray *)matchHistory
{
    if (!_matchHistory) _matchHistory = [NSMutableArray array];
    return _matchHistory;
}

- (STUDeck *)createDeck
{
    return [[STUPlayingCardDeck alloc] init];
}

- (STUCardMatchingGame *)createGame
{
     return [[STUCardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                 usingDeck:[self createDeck]];
}

- (IBAction)touchCardButton:(UIButton *)sender
{
    int chosenButtonIndex = [self.cardButtons indexOfObject:sender];
    STUCard *card = [self.game cardAtIndex:chosenButtonIndex];
    
    self.gameModeSegment.enabled = NO;
    [self.game chooseCardAtIndex:chosenButtonIndex];
    
    self.matchAlertLabel.text = card.isChosen ? card.contents : nil;
    [self updateUI];
}

- (IBAction)dealAgainButton:(UIButton *)sender
{
    self.game = nil;
    self.gameModeSegment.enabled = YES;
    [self updateUI];
}

- (void)updateUI
{
    NSMutableArray *matches = [NSMutableArray array];
    
    for (UIButton *cardButton in self.cardButtons) {
        if (cardButton.enabled) {
            int cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
            STUCard *card = [self.game cardAtIndex:cardButtonIndex];
            [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
            [cardButton setBackgroundImage:[self backgroundImageForCard:card]
                                  forState:UIControlStateNormal];
            if (card.isMatched) {
                [matches addObject:card.contents];
            }
            cardButton.enabled = !card.isMatched;
        }
    }
    if ([matches count] > 0) {
        [self.matchHistory addObject:[NSString stringWithFormat:@"Matched %@ with %@",
                                      [matches firstObject], [matches lastObject]]];
        self.matchAlertLabel.text = [self.matchHistory lastObject];
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
}

- (NSString *)titleForCard:(STUCard *)card
{
    return card.isChosen ? card.contents : @"";
}

- (UIImage *)backgroundImageForCard:(STUCard *)card
{
    return [UIImage imageNamed:card.isChosen ? @"cardfront" : @"cardback"];
}

@end