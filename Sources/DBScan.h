//
//  DBScan.h
//  DBScan
//
//  Created by Christian Vogel on 02.03.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DistanceFunction.h"
#import "Cluster.h"

@interface DBScan : NSObject
{
    @private
    NSMutableArray* pointsMappedTocluster;
    NSMutableArray* visitedPoints;
    NSMutableArray* noise;
    NSMutableArray* distanceM;
    float epsilon;
    float minNumberOfPoint;
    NSArray* pointSet;
    id <DistanceFunction> distfunction;
}

-(NSArray*)cluster:(NSArray*)points :(float)eps: (int)minPtr :(id <DistanceFunction>) function;
-(NSArray*)cluster:(NSArray*)points :(float)eps: (int)minPtr;

@end
