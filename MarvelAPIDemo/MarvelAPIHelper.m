//
//  MarveAPIHelper.m
//  MarvelAPIDemo
//
//  Created by Diego Freniche Brito on 02/07/14.
//  Copyright (c) 2014 Diego Freniche Brito. All rights reserved.
//

#import "MarvelAPIHelper.h"
#import "NSString+MD5.h"

#define MARVEL_BASE_URL @"http://gateway.marvel.com/v1/"

@implementation MarvelAPIHelper

- (NSString *)authorizationStringWithPublicKey:(NSString *)publicKey andSecretKey:(NSString *)secretKey andTimeStamp:(NSString *)ts {
    
    NSString *preHash = [NSString stringWithFormat:@"%@%@%@", ts, secretKey, publicKey];
    
    return [preHash MD5];
}

- (NSArray *)allComicsUsingPublicKey:(NSString *)publicKey andSecretKey:(NSString *)secretKey andTimeStamp:(NSString *)ts {

    NSString *authString = [self authorizationStringWithPublicKey:publicKey andSecretKey:secretKey andTimeStamp:ts];
    NSString *get = [NSString stringWithFormat:@"%@%@?ts=%@&apikey=%@&hash=%@", MARVEL_BASE_URL, @"comics", ts, publicKey, authString];
    
    NSArray *comics;
    
    NSURL *url = [NSURL URLWithString:get];
    
    NSData *data = [NSData dataWithContentsOfURL:url];
    
    return comics;
}
@end
