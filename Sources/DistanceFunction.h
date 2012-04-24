//
//  DistanceFunction.h
//  DBScan
//
//  Created by Christian Vogel on 02.03.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CPoint.h"

@protocol DistanceFunction <NSObject>

-(float)calculate:(CPoint*) point1: (CPoint*) point2;

@end
