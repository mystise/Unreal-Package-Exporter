//
//  UNRTree.h
//  UnrealPackageExporter
//
//  Created by Adalynn Dudney on 9/18/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Unreal.h"
#import "UnrealObjectClasses.h"

@interface UNRTree : NSObject {
	NSMutableArray *objects;
}

- (id)initWithFile:(UNRFile *)file;

@property(nonatomic, retain) NSMutableArray *objects;

@end
