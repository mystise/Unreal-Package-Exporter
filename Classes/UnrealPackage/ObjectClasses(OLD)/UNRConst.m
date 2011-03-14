//
//  UNRConst.m
//  UnrealPackageExporter
//
//  Created by Adalynn Dudney on 9/14/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "UNRConst.h"


@implementation UNRConst

- (id)initWithObject:(UNRExport *)export file:(UNRFile *)file manager:(DataManager *)manager{
	if(self = [super initWithObject:export file:file manager:manager]){
		int size = [UNRFile readCompactIndex:manager];
		NSMutableString *constStr = [NSMutableString string];
		for(int i = 0; i < size; i++){
			[constStr appendFormat:@"%c", [manager loadByte]];
		}
		constant = [constStr copy];
		[constStr release];
	}
	return self;
}

- (NSString *)description{
	NSMutableString *description = [NSMutableString stringWithString:[super description]];
	[description appendString:constant];
	return [description copy];
}

- (void)dealloc{
	[constant release];
	[super dealloc];
}

@end
