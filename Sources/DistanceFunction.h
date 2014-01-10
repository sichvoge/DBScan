//
//  DistanceFunction.h
//  DBScan
//
//  Created by Christian Vogel on 02.03.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DistanceFunction <NSObject>

- (float)distanceBetween:(id)point1 and:(id)point2;

@end