//
//  MarvelAPIHelperTests.m
//  MarvelAPIDemo
//
//  Created by Diego Freniche Brito on 02/07/14.
//  Copyright (c) 2014 Diego Freniche Brito. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MarvelAPIHelper.h"

@interface MarvelAPIHelperTests : XCTestCase

@end

@implementation MarvelAPIHelperTests



- (void)testGetComics {
    MarvelAPIHelper *mah = [[MarvelAPIHelper alloc] init];
        
    [mah allComicsUsingPublicKey:@"bd8f8a972db1c721bb21aaf100f2e707" andSecretKey:@"8a73988fb7552d0013a1c3148739962c2e7c477e" andTimeStamp:@"10"];

    
}

@end
