//
//  EuclidianDistanceFunction.m
//  DBScan
//
//  Created by Christian Vogel on 02.03.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "EuclidianDistanceFunction.h"
#import "CPoint.h"

@implementation EuclidianDistanceFunction

- (float)distanceBetween:(id)p1 and:(id)p2
{
	CPoint* point1 = p1;
	CPoint* point2 = p2;
	
    if (point1.dimension != point2.dimension)
        [NSException raise:@"Invalid input" format:@"dimension of both points are not equal"];

    float sum = .0f;

    for (int i = 0; i < point1.dimension; i++) {
        sum += powf([point1 coordinateAtPosition:i] - [point2 coordinateAtPosition:i], 2.0);
    }

    float distance = sqrtf(sum);

	// NSLog(@"distance between (%@) and (%@): %f",[point1 description],[point2 description],distance);

    return distance;
}

@end