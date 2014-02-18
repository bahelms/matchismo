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
@property (weak, nonatomic) IBOutlet UISlider *matchHistroySlider;
@property (nonatomic) STUCardMatchingGame *game;
@end

@implementation STUViewController

- (STUCardMatchingGame *)game
{
    if (!_game) _game = [self createGame];
    return _game;
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
    self.matchAlertLabel.text = [NSString stringWithFormat:@"%@", card.contents];
    [self.game chooseCardAtIndex:chosenButtonIndex];
    
    [self updateUI];
}

- (IBAction)dealAgainButton:(UIButton *)sender
{
    self.game = nil;
    self.gameModeSegment.enabled = YES;
    [self updateUI];
}

- (IBAction)changeMatchHistorySlider:(UISlider *)sender {
    NSUInteger index = (int)sender.value;
    
    if ([self.game.matchHistory count] > 0) {
        if (index <= [self.game.matchHistory count] - 1) {
            self.matchAlertLabel.text = self.game.matchHistory[index];
            if (sender.value+1 < sender.maximumValue)
                self.matchAlertLabel.alpha = 0.5;
            else
                self.matchAlertLabel.alpha = 1;
        }
    }
}

- (void)updateUI
{
    for (UIButton *cardButton in self.cardButtons) {
        int cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        STUCard *card = [self.game cardAtIndex:cardButtonIndex];
        [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card]
                              forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
    }
    self.matchAlertLabel.text = self.game.matchMessage;
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    
    self.matchHistroySlider.maximumValue = [self.game.matchHistory count];
    [self.matchHistroySlider setValue:self.matchHistroySlider.maximumValue animated:YES];
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