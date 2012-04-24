//
//  DBScan.m
//  DBScan
//
//  Created by Christian Vogel on 02.03.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DBScan.h"
#import "EuclidianDistanceFunction.h"

@implementation DBScan

-(NSArray*)cluster:(NSArray*)points :(float)eps: (int)minPtr :(id <DistanceFunction>) function;
{
    epsilon = eps;
    pointSet = points;
    minNumberOfPoint = minPtr;
    distfunction = function;
    [self computeDistanceMatrix:points];
    
    return [self compute];
}

-(NSArray*)cluster:(NSArray*)points :(float)eps: (int)minPtr
{
    epsilon = eps;
    pointSet = points;
    minNumberOfPoint = minPtr;
    distfunction = [EuclidianDistanceFunction new];
    
    [self computeDistanceMatrix:points];
    
    return [self compute];
}

-(NSArray*)compute
{
    int numberOfPoints = pointSet.count;
    
    pointsMappedTocluster = [NSMutableArray arrayWithCapacity:numberOfPoints];
    visitedPoints = [NSMutableArray arrayWithCapacity:numberOfPoints];
    noise = [NSMutableArray array];
    
    NSMutableArray* result = [NSMutableArray array];
    
    for(int index=0;index < numberOfPoints; index++) 
    {
        CPoint *current = [pointSet objectAtIndex:index];
        
        if(![visitedPoints containsObject:current]) 
        {
            [visitedPoints addObject:current];
            
            NSMutableArray* neighbors = [self findNeighbors:index];
            
            if(neighbors.count < minNumberOfPoint) 
            {
                [noise addObject:current];
            } 
            else 
            {
                Cluster *cluster = [self expandCluster:current :neighbors];
                
                [result addObject:cluster];
            }
        }
    }
    
    NSLog(@"%i points mapped to cluster",(int)pointsMappedTocluster.count);
    NSLog(@"%i noise points",(int)noise.count);
    
    return result;
}

-(NSMutableArray*)findNeighbors:(int)point_id
{
    NSMutableArray* neighbors = [NSMutableArray array];
    
    for(int ptrIndex = 0; ptrIndex < distanceM.count; ptrIndex++)
    {
        if((point_id != ptrIndex) && ([[[distanceM objectAtIndex:ptrIndex]objectAtIndex:point_id]floatValue] < epsilon)) 
        {
            [neighbors addObject:[NSNumber numberWithInt:ptrIndex]];
        } 
    }
    
    return neighbors;
}

-(Cluster*)expandCluster:(CPoint*) current: (NSMutableArray*) n
{
    Cluster* cluster = [Cluster new];
    
    [cluster addPointToCluster:current];
    [pointsMappedTocluster addObject:current];
    
    for(int index = 0; index < n.count; index++)
    {
        int neighborPointID = [[n objectAtIndex:index]intValue];
        
        CPoint *cp = [pointSet objectAtIndex:neighborPointID];
        
        if(![visitedPoints containsObject:cp])
        {
            [visitedPoints addObject:cp];
            
            NSArray *neighbors = [self findNeighbors:neighborPointID];
            
            if(neighbors.count >= minNumberOfPoint)
            {
                [self merge:n :neighbors];
            }
        }
        
        if(![pointsMappedTocluster containsObject:cp])
        {
            [cluster addPointToCluster:cp];
            [pointsMappedTocluster addObject:cp];
        }
    }
    
    return cluster;
}

-(void)merge:(NSMutableArray*) currentNeighbors:(NSArray*)newNeighbors
{
    for(NSNumber *p in newNeighbors)
    {
        if(![currentNeighbors containsObject:p])
        {
            [currentNeighbors addObject:p];
        }
    }
}

-(void)computeDistanceMatrix:(NSArray*)points
{
    int numberOfPoints = points.count;
    
    distanceM = [NSMutableArray arrayWithCapacity:numberOfPoints];
    
    for (int index = 0; index<numberOfPoints; index++) {
        [distanceM insertObject:[NSMutableArray arrayWithCapacity:numberOfPoints] atIndex:index];
    }
    
    for(int row = 0; row < numberOfPoints; row++) 
    {    
        for(int col = row; col < numberOfPoints; col++) 
        {
            if(col == row) 
            {                
                [[distanceM objectAtIndex:row]insertObject:[[NSNumber alloc]initWithFloat:.0f] atIndex:col];
            } 
            else 
            {
                float distance = [distfunction calculate:[points objectAtIndex:row] :[points objectAtIndex:col]];
                
                NSNumber *number = [[NSNumber alloc]initWithFloat:distance];
                
                [[distanceM objectAtIndex:row]insertObject:number atIndex:col];
                [[distanceM objectAtIndex:col]insertObject:number atIndex:row];
            }
        }
    }
}

@end
