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
    NSArray              *_points;
    float                 _epsilon;
    float                 _minNumberOfPoints;
    NSArray              *_distanceMatrix;
    id <DistanceFunction> _distanceFunction;

    NSMutableArray *_pointsMappedTocluster;
    NSMutableArray *_visitedPoints;
    NSMutableArray *_noise;
}

@property (readonly) NSArray *clusters;

- (id)initWithPoints:(NSArray *)points epsilon:(float)epsilon minNumberOfPointsInCluster:(int)minNumberOfPoints distanceFunction:(id <DistanceFunction>)function;


@end