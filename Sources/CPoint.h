//
//  Point.h
//  DBScan
//
//  Created by Christian Vogel on 02.03.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CPoint : NSObject
{
    NSMutableArray *coordinates;
}

@property (readonly) NSArray* coordinates;

-(void)setCoordinate:(float)coordinate;

-(float)getCoordinateAtPosition:(int)position;

-(int)numberOfDimensions;

-(NSString*)stringValue;

+(id)initWithPointArray:(NSArray*)point;

@end
