//
//  UNRField.m
//  UnrealPackageExporter
//
//  Created by Adalynn Dudney on 9/14/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "UNRField.h"


@implementation UNRField

- (id)initWithObject:(UNRExport *)export file:(UNRFile *)file manager:(DataManager *)manager{
	if(self = [super initWithObject:export file:file manager:manager]){
		int superRef = [UNRFile readCompactIndex:manager];
		superObj = [file resolveObjectRefrence:superRef];
		int nextRef = [UNRFile readCompactIndex:manager];
		nextObj = [file resolveObjectRefrence:nextRef];
	}
	return self;
}

- (NSString *)description{
	NSMutableString *description = [NSMutableString stringWithString:[super description]];
	[description appendFormat:@"Super Object:\n%@\n", superObj];
	[description appendFormat:@"Next Object:\n%@\n", nextObj];
	return [description copy];
}

@end
