//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Litie Zhu on 7/2/14.
//  Copyright (c) 2014 zhul6. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()
@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, strong) NSMutableArray *cards; // of card

@end

@implementation CardMatchingGame

- (NSMutableArray *)cards {
    if (!_cards) {
        _cards = [[NSMutableArray alloc] init];
    }
    return _cards;
}

- (NSInteger) maxMatchingCards
{
    if (_maxMatchingCards < 2) {
        _maxMatchingCards = 2;
    }
    return _maxMatchingCards;
}

- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck {
    self = [self init];
    if (self) {
        for (int i = 0; i < count; i++) {
            Card *card = [deck drawRandomCard];
            if (card) {
                [self.cards addObject:card];
            }
            else {
                self = nil;
                break;
            }
        }
    }
    return self;
}

#define MISMATCH_PENALTY 2
#define MATCH_BONUS 4
#define COST_TO_CHOOSE 1

- (void)chooseCardAtIndex:(NSUInteger)index {
    Card *card = [self.cards objectAtIndex:index];
    if (card) {
        if (!card.isMatched) {
            if (card.isChosen) {
                card.chosen = NO;
            }
            else {
                for (Card *otherCard in self.cards) {
                    if (otherCard.isChosen && !otherCard.isMatched) {
                        int matchScore = [card match:@[otherCard]];
                        if (matchScore) {
                            self.score += matchScore * MATCH_BONUS;
                            card.matched = YES;
                            otherCard.matched = YES;
                        }
                        else {
                            self.score -= MISMATCH_PENALTY;
                            otherCard.chosen = NO;
                        }
                        break;
                    }
                }
                card.chosen = YES;
                self.score -= COST_TO_CHOOSE;
            }
        }
    }
}

- (Card *)cardAtIndex:(NSUInteger)index {
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

@end
