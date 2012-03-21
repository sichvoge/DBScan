//
//  EuclidianDistanceFunction.m
//  DBScan
//
//  Created by Christian Vogel on 02.03.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "EuclidianDistanceFunction.h"

@implementation EuclidianDistanceFunction

-(float)calculate:(CPoint *)point1 :(CPoint *)point2
{
    if (point1.numberOfDimensions != point2.numberOfDimensions) {
        [NSException raise:@"Invalid input" format:@"dimension of both points are not equal"];
    }
    
    float sum = .0f;
    
    for (int i = 0; i < point1.numberOfDimensions; i++) 
    {
        sum += powf([point1 getCoordinateAtPosition:i]-[point2 getCoordinateAtPosition:i], 2.0);
    }
    
    float distance = sqrtf(sum);
    
    //NSLog(@"distance between (%@) and (%@): %f",[point1 stringValue],[point2 stringValue],distance);
    
    return distance;
}

@end
