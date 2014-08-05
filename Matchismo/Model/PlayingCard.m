//
//  PlayingCard.m
//  Matchismo
//
//  Created by Litie Zhu on 6/30/14.
//  Copyright (c) 2014 zhul6. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

- (int)match:(NSArray *)otherCards {
    int score = 0;
    int numOtherCards = [otherCards count];
    
    if (numOtherCards) {
        for (Card* card in otherCards) {
            if ([card isKindOfClass: [PlayingCard class]]) {
                PlayingCard *otherCard = (PlayingCard *) card;
                if ([self.suit isEqualToString:otherCard.suit]) {
                    score += 1;
                }
                else if (self.rank == otherCard.rank) {
                    score += 4;
                }
            }
        }
    }
    if (numOtherCards > 1) {
        [[otherCards firstObject] match: [otherCards subarrayWithRange:NSMakeRange(1, numOtherCards-1)]];
    }
    return score;
}

+ (NSArray*) validSuits {
    return @[@"♥︎", @"♠︎", @"♦︎", @"♣︎"];
}

+ (NSUInteger) maxRank {
    return [[PlayingCard rankStrings] count] -1;
}

+ (NSArray*) rankStrings {
    return @[@"?", @"A", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"J", @"Q", @"K"];
}

- (NSString*) contents {
    NSArray* rankStrings = [PlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

@synthesize suit = _suit; // because we provide setter AND getter

- (NSString*) suit {
    return _suit ? _suit : @"?";
}

- (void) getSuit: (NSString*)suit {
    if ([[PlayingCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
}

@end
