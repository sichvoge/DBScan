//
//  SourceLoader.h
//  DBScan
//
//  Created by Christian Vogel on 02.03.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SourceLoader <NSObject>

-(NSArray *)load:(NSString *)url;

@end
