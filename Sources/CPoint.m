//
//  Point.m
//  DBScan
//
//  Created by Christian Vogel on 02.03.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CPoint.h"

@implementation CPoint

@synthesize coordinates;

-(id)init 
{
    self = [super init];
    
    if(self) 
    {
        coordinates = [NSMutableArray array];
    }
    
    return self;
}

-(void)setCoordinate:(float)coordinate
{
    [coordinates addObject:[NSNumber numberWithFloat:coordinate]];
}

-(float)getCoordinateAtPosition:(int)position
{
    if(position < 0 || position > [coordinates count]) 
    {
        [NSException raise:@"Invalid input." format:@"position %i is invalid",position];
    }
    
    return [[coordinates objectAtIndex:position] floatValue];
}

-(int)numberOfDimensions
{
    return coordinates.count;
}

-(NSString *)stringValue 
{
    NSString *result = @"";
    
    for(int i=0;i<coordinates.count;i++) 
    {
        result = [result stringByAppendingString:[[coordinates objectAtIndex:i]stringValue]];
        
        if(i < (coordinates.count - 1))
        {
            result = [result stringByAppendingString:@","];
        }
    }
    
    return result;
}

+(id)initWithPointArray:(NSArray *)point
{
    CPoint *copy = [CPoint new];
    
    for(int i=0;i<point.count;i++) 
    {
        float coordinate = [[point objectAtIndex:i] floatValue];
        [copy setCoordinate:coordinate];
    }
    
    return copy;
}

-(BOOL)isEqual:(id)object
{
    if(object == self)
    {
        return YES;
    }
    
    if(!object ||  ![object isKindOfClass:[self class]])
    {
        return NO;
    }
    
    CPoint *other = object;
    
    if(coordinates.count != other.coordinates.count)
    {
        return NO;
    }
    
    for(int i=0;i<coordinates.count;i++) 
    {
        float selfAttr = [[coordinates objectAtIndex:i]floatValue];
        float otherAttr = [[[other coordinates]objectAtIndex:i]floatValue];
        
        if(selfAttr != otherAttr)
        {
            return NO;
        }
    }
    
    return YES;
}

@end
