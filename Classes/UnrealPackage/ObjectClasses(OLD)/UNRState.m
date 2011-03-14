//
//  UNRState.m
//  UnrealPackageExporter
//
//  Created by Adalynn Dudney on 9/14/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "UNRState.h"


@implementation UNRState

- (id)initWithObject:(UNRExport *)export file:(UNRFile *)file manager:(DataManager *)manager{
	if(self = [super initWithObject:export file:file manager:manager]){
		probeMask = [manager loadLong];
		ignoreMask = [manager loadLong];
		labelTableOffset = [manager loadShort];
		stateFlags = [manager loadInt];
	}
	return self;
}

@end
