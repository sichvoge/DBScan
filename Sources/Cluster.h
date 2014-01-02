//
//  Cluster.h
//  DBScan
//
//  Created by Christian Vogel on 02.03.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Cluster : NSObject
{
    NSMutableArray *points;
}

@property (readonly) NSArray *points;

- (BOOL)contains:(id)point;

- (void)addToCluster:(id)point;
- (id)getFromCluster:(int)index;
- (NSUInteger)count;
- (NSString *)description;

@end