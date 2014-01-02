//
//  main.m
//  DBScan
//
//  Created by Christian Vogel on 02.03.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FileSourceLoader.h"
#import "SourceLoader.h"
#import "CPoint.h"
#import "DBScan.h"
#import "EuclidianDistanceFunction.h"
#import "DistanceFunction.h"

int main(int argc, const char *argv[]) {
    @autoreleasepool {
        NSArray *pointsEntries;

        if ([[[NSProcessInfo processInfo] arguments] count] > 1) {
            id <SourceLoader> loader = [FileSourceLoader new];
            pointsEntries = [loader load:[[[NSProcessInfo processInfo] arguments] objectAtIndex:1]];
        } else {
            NSLog(@"Pass the file path with point entries as an argument to this application.");
            exit(0);
        }

        NSMutableArray *points = [NSMutableArray arrayWithCapacity:pointsEntries.count];

        for (NSString *pointEntry in pointsEntries) {
            if ([pointEntry length] > 0) {
                CPoint  *point       = [CPoint new];
                NSArray *coordinates = [pointEntry componentsSeparatedByString:@","];

                for (NSString *coordinate in coordinates) {
                    [point addCoordinate:[coordinate floatValue]];
                }

                [points addObject:point];
            }
        }

        NSLog(@"number of loaded points: %i", (int)points.count);

        NSDate *startTime = [NSDate date];
        NSLog(@"start clustering process (%@)", startTime);

        NSArray *clusters = [[[DBScan alloc] initWithPoints:points epsilon:0.2f minNumberOfPointsInCluster:2 distanceFunction:[EuclidianDistanceFunction new]] clusters];

        NSDate *endTime = [NSDate date];
        NSLog(@"finished clustering process (%@)", endTime);

        NSTimeInterval totalProcessingTimeInSeconds = [endTime timeIntervalSinceDate:startTime];

        NSLog(@"total processing time: %fs", totalProcessingTimeInSeconds);

        if (clusters.count == 0) {
            NSLog(@"no cluster");
            return 0;
        }

        int index     = 1;
        int sumPoints = 0;

        for (Cluster *c in clusters) {
            NSLog(@"\nCluster %i: \n%@", index++, [c description]);
            sumPoints += c.count;
        }
    }

    return 0;
}