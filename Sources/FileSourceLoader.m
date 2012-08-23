//
//  FileSourceLoader.m
//  DBScan
//
//  Created by Christian Vogel on 02.03.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FileSourceLoader.h"

@implementation FileSourceLoader

- (NSArray *)load:(NSString *)url {
    NSString *content = [NSString stringWithContentsOfFile:url
                                                  encoding:NSUTF8StringEncoding
                                                     error:nil];
    return [content componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"\r\n"]];
}

@end