//
//  Cluster.h
//  DBScan
//
//  Created by Christian Vogel on 02.03.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CPoint.h"

@interface Cluster : NSObject
{
    NSMutableArray * points;
}

@property (readonly) NSArray * points;

-(BOOL)contains:(CPoint*) point;

-(void)addPointToCluster:(CPoint*)point;
-(CPoint*)getPointFromCluster:(int)index;
-(int)size;
-(NSString*)stringValue;

@end
