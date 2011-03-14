//
//  UNRProperty.m
//  UnrealPackageExporter
//
//  Created by Adalynn Dudney on 9/14/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "UNRProperty.h"


@implementation UNRProperty

- (id)initWithObject:(UNRExport *)export file:(UNRFile *)file manager:(DataManager *)manager{
	if(self = [super initWithObject:export file:file manager:manager]){
		arrayDimension = [manager loadShort];
		elementSize = [manager loadShort];
		propertyFlags = [manager loadInt];
		int catagoryRef = [UNRFile readCompactIndex:manager];
		catagory = [file resolveObjectRefrence:catagoryRef];
		if((propertyFlags & PF_Net) != 0){
			replicationOffset = [manager loadShort];
		}
	}
	return self;
}

- (NSString *)description{
	NSMutableString *description = [NSMutableString stringWithString:[super description]];
	[description appendFormat:@"Array Dimension: %i\n", arrayDimension];
	[description appendFormat:@"Element Size: %i\n", elementSize];
	[description appendFormat:@"Property Flags: %X\n", propertyFlags];
	[description appendFormat:@"Catagory: %@\n", catagory];
	if(replicationOffset != 0){
		[description appendFormat:@"Replication Offset: %i\n", replicationOffset];
	}
	return [description copy];
}

@end
