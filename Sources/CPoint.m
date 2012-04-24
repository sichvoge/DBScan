//
//  Point.m
//  DBScan
//
//  Created by Christian Vogel on 02.03.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CPoint.h"

@implementation CPoint

@synthesize coordinates = _coordinates;

-(id)init 
{
    self = [super init];
    
    if(self) 
    {
        _coordinates = [NSMutableArray array];
    }
    
    return self;
}

-(void)addCoordinate:(float)coordinate
{
    [_coordinates addObject:[NSNumber numberWithFloat:coordinate]];
}

-(float)getCoordinateAtPosition:(int)position
{
    if(position < 0 || position > [_coordinates count]) 
    {
        [NSException raise:@"Invalid input." format:@"position %i is invalid",position];
    }
    
    return [[_coordinates objectAtIndex:position] floatValue];
}

-(int)numberOfDimensions
{
    return _coordinates.count;
}

-(NSString *)description 
{
    NSString *result = @"";
    
    for(int i=0;i<_coordinates.count;i++) 
    {
        result = [result stringByAppendingString:[[_coordinates objectAtIndex:i]description]];
        
        if(i < (_coordinates.count - 1))
        {
            result = [result stringByAppendingString:@","];
        }
    }
    
    return result;
}

+(id)pointWithCoordinates:(NSArray *)coordinates
{
    CPoint *copy = [CPoint new];
    
    for(int i=0;i<coordinates.count;i++) 
    {
        float coordinate = [[coordinates objectAtIndex:i] floatValue];
        [copy addCoordinate:coordinate];
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
    
    if(_coordinates.count != other.coordinates.count)
    {
        return NO;
    }
    
    for(int i=0;i<_coordinates.count;i++) 
    {
        float selfAttr = [[_coordinates objectAtIndex:i]floatValue];
        float otherAttr = [[[other coordinates]objectAtIndex:i]floatValue];
        
        if(selfAttr != otherAttr)
        {
            return NO;
        }
    }
    
    return YES;
}

@end
