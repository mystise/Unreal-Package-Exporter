//
//  UNREnum.m
//  UnrealPackageExporter
//
//  Created by Adalynn Dudney on 9/14/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "UNREnum.h"


@implementation UNREnum

- (id)initWithObject:(UNRExport *)export file:(UNRFile *)file manager:(DataManager *)manager{
	if(self = [super initWithObject:export file:file manager:manager]){
		elementNames = [[NSMutableArray alloc]init];
		int arraySize = [UNRFile readCompactIndex:manager];
		for(int i = 0; i < arraySize; i++){
			int elementNameRef = [UNRFile readCompactIndex:manager];
			[elementNames addObject:[file.names objectAtIndex:elementNameRef]];
		}
	}
	return self;
}

- (NSString *)description{
	NSMutableString *description = [NSMutableString stringWithString:[super description]];
	[description appendFormat:@"%@\n", elementNames];
	return [description copy];
}

- (void)dealloc{
	[elementNames release];
	[super dealloc];
}

@end
