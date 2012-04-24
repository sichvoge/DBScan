//
//  main.m
//  DBScan
//
//  Created by Christian Vogel on 02.03.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#include "FileSourceLoader.h"
#include "SourceLoader.h"
#include "CPoint.h"
#include "DBScan.h"
#include "EuclidianDistanceFunction.h"
#include "DistanceFunction.h"

int main(int argc, const char *argv[])
{
    @autoreleasepool {
        
        id <SourceLoader> loader = [FileSourceLoader new];
        
        NSArray *stringPoints = [loader load:[[[NSProcessInfo processInfo] arguments] objectAtIndex:1]];
        
        NSMutableArray *points = [NSMutableArray arrayWithCapacity:stringPoints.count]; 
        
        for(NSString *point in stringPoints)
        {
            if([point length] > 0) 
            {
                CPoint *newPoint = [CPoint new];
                NSArray *attributes = [point componentsSeparatedByString:@","];
                
                for(NSString *attr in attributes)
                {
                    [newPoint setCoordinate:[attr floatValue]]; 
                }
                
                [points addObject:newPoint];
            }
        }
        
        NSLog(@"number of loaded points: %i", (int)points.count);
        
        NSDate *startTime = [NSDate date];
        NSLog(@"start clustering process (%@)",startTime);
        
        NSArray * cluster = [[DBScan new]cluster:points :1.0f :5];
        
        NSDate *endTime = [NSDate date];
        NSLog(@"finished clustering process (%@)",endTime);
        
        NSTimeInterval totalProcessingTimeInSeconds = [endTime timeIntervalSinceDate:startTime];
        
        NSLog(@"total processing time: %fs",totalProcessingTimeInSeconds);
        
        if(cluster.count == 0)
        {
            NSLog(@"no cluster");
            return 0;
        }
        
        int index = 1;
        int sumPoints = 0;
        
        for(Cluster * c in cluster)
        {
            NSLog(@"\nCluster %i: \n%@", index++,[c stringValue]);
            sumPoints += [c size];
        }
    }
    
    return 0;
}

