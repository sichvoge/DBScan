 //
//  Cluster.m
//  DBScan
//
//  Created by Christian Vogel on 02.03.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Cluster.h"

@implementation Cluster

@synthesize points;

- (id)init {
    self = [super init];

    if (self)
        points = [NSMutableArray array];

    return self;
}

- (NSUInteger)count {
    return points.count;
}

- (void)addToCluster:(id)point {
    [points addObject:point];
}

- (BOOL)contains:(id)point {
    return [points containsObject:point];
}

- (id)getFromCluster:(int)index {
    return [points objectAtIndex:index];
}

- (NSString *)description {
    NSString *result = @"";

    result = [result stringByAppendingString:@"contained cluster points:\n"];

    for (int ptrIndex = 0; ptrIndex < points.count; ptrIndex++) {
        result = [result stringByAppendingString:[[points objectAtIndex:ptrIndex] description]];

        if (ptrIndex < (points.count - 1))
            result = [result stringByAppendingString:@"\n"];
    }

    return result;
}

@end