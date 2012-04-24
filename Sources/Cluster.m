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

-(id)init
{
    self = [super init];
    
    if(self)
    {
        points = [NSMutableArray array];
    }
    
    return self;
}

-(int)size
{
    return points.count;
}

-(void)addPointToCluster:(CPoint*)point
{
    [points addObject:point];
}

-(BOOL)contains:(CPoint *)point
{
    return [points containsObject:point];
}

-(CPoint*)getPointFromCluster:(int) index
{
    return [points objectAtIndex:index];
}

-(NSString*)stringValue
{
    NSString *result = @"";
    
    result = [result stringByAppendingString:@"contained cluster points:\n"];
    
    for(int ptrIndex = 0; ptrIndex < points.count; ptrIndex++)
    {
        result = [result stringByAppendingString:[[points objectAtIndex:ptrIndex]stringValue]];
        
        if(ptrIndex < (points.count - 1))
        {
            result = [result stringByAppendingString:@"\n"];
        }
    }
    
    return result;
}

@end
