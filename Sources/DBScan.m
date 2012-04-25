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

- (id)initWithPoints:(NSArray *)points epsilon:(float)epsilon minNumberOfPointsInCluster:(int)minNumberOfPoints
{
    return [self initWithPoints:points 
                        epsilon:epsilon 
     minNumberOfPointsInCluster:minNumberOfPoints 
               distanceFunction:[EuclidianDistanceFunction new]];
}

- (id)initWithPoints:(NSArray *)points epsilon:(float)epsilon minNumberOfPointsInCluster:(int)minNumberOfPoints distanceFunction:(id <DistanceFunction>)function
{
    self = [super init];
        
    if(self) 
    {
        _epsilon = epsilon;
        _points = points;
        _minNumberOfPoints = minNumberOfPoints;
        _distanceFunction = function;
        _distanceMatrix = [self computeDistanceMatrix:points];
    }
        
    return self;
}

-(NSArray *)clusters
{
    int numberOfPoints = _points.count;
    
    _pointsMappedTocluster = [NSMutableArray arrayWithCapacity:numberOfPoints];
    _visitedPoints = [NSMutableArray arrayWithCapacity:numberOfPoints];
    _noise = [NSMutableArray array];
    
    NSMutableArray *result = [NSMutableArray array];
    
    for(int index=0;index < numberOfPoints; index++) 
    {
        CPoint *current = [_points objectAtIndex:index];
        
        if(![_visitedPoints containsObject:current]) 
        {
            [_visitedPoints addObject:current];
            
            NSMutableArray *neighbors = [self findNeighbors:index];
            
            if(neighbors.count < _minNumberOfPoints) 
            {
                [_noise addObject:current];
            } 
            else 
            {
                Cluster *cluster = [self expandCluster:current :neighbors];
                
                [result addObject:cluster];
            }
        }
    }
    
    NSLog(@"%i points mapped to cluster",(int)_pointsMappedTocluster.count);
    NSLog(@"%i noise points",(int)_noise.count);
    
    return result;
}

-(NSMutableArray *)findNeighbors:(int)point_id
{
    NSMutableArray *neighbors = [NSMutableArray array];
    
    for(int ptrIndex = 0; ptrIndex < _distanceMatrix.count; ptrIndex++)
    {
        if((point_id != ptrIndex) && ([[[_distanceMatrix objectAtIndex:ptrIndex]objectAtIndex:point_id]floatValue] < _epsilon)) 
        {
            [neighbors addObject:[NSNumber numberWithInt:ptrIndex]];
        } 
    }
    
    return neighbors;
}

-(Cluster *)expandCluster:(CPoint *) current: (NSMutableArray *) n
{
    Cluster *cluster = [Cluster new];
    
    [cluster addPointToCluster:current];
    [_pointsMappedTocluster addObject:current];
    
    for(int index = 0; index < n.count; index++)
    {
        int neighborPointID = [[n objectAtIndex:index]intValue];
        
        CPoint *cp = [_points objectAtIndex:neighborPointID];
        
        if(![_visitedPoints containsObject:cp])
        {
            [_visitedPoints addObject:cp];
            
            NSArray *neighbors = [self findNeighbors:neighborPointID];
            
            if(neighbors.count >= _minNumberOfPoints)
            {
                [self merge:n :neighbors];
            }
        }
        
        if(![_pointsMappedTocluster containsObject:cp])
        {
            [cluster addPointToCluster:cp];
            [_pointsMappedTocluster addObject:cp];
        }
    }
    
    return cluster;
}

-(void)merge:(NSMutableArray *) currentNeighbors:(NSArray *)newNeighbors
{
    for(NSNumber *p in newNeighbors)
    {
        if(![currentNeighbors containsObject:p])
        {
            [currentNeighbors addObject:p];
        }
    }
}

-(NSArray *)computeDistanceMatrix:(NSArray *)points
{
    int numberOfPoints = points.count;
    
    NSMutableArray *distanceM = [NSMutableArray arrayWithCapacity:numberOfPoints];
    
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
                float distance = [_distanceFunction calculate:[points objectAtIndex:row] :[points objectAtIndex:col]];
                
                NSNumber *number = [[NSNumber alloc]initWithFloat:distance];
                
                [[distanceM objectAtIndex:row]insertObject:number atIndex:col];
                [[distanceM objectAtIndex:col]insertObject:number atIndex:row];
            }
        }
    }
    
    return [NSArray arrayWithArray:distanceM]; // return immutable array
}

@end
