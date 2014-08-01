//
//  PlayingCard.h
//  Matchismo
//
//  Created by Litie Zhu on 6/30/14.
//  Copyright (c) 2014 zhul6. All rights reserved.
//

#import "Card.h"

@interface PlayingCard : Card

@property (strong, nonatomic) NSString* suit;
@property (nonatomic) NSUInteger rank;

+ (NSArray*)validSuits;
+ (NSUInteger)maxRank;

@end
