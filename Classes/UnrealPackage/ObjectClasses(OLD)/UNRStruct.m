//
//  UNRStruct.m
//  UnrealPackageExporter
//
//  Created by Adalynn Dudney on 9/14/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "UNRStruct.h"


@implementation UNRStruct

- (id)initWithObject:(UNRExport *)export file:(UNRFile *)file manager:(DataManager *)manager{
	if(self = [super initWithObject:export file:file manager:manager]){
		int scriptRef = [UNRFile readCompactIndex:manager];
		textObj = [file resolveObjectRefrence:scriptRef];
		int childrenRef = [UNRFile readCompactIndex:manager];
		childrenObj = [file resolveObjectRefrence:childrenRef];
		int nameRef = [UNRFile readCompactIndex:manager];
		name = [file.names objectAtIndex:nameRef];
		line = [manager loadInt];
		textPos = [manager loadInt];
		scriptSize = [manager loadInt];
		code = [[NSMutableData alloc] init];
		[self parseScript:manager];
	}
	return self;
}

- (void)parseScript:(DataManager *)manager{
	//TODO: actually parse the script!!!
}

- (NSString *)description{
	NSMutableString *description = [NSMutableString stringWithString:[super description]];
	[description appendFormat:@"Name: %@\n", name.name];
	return [description copy];
}

- (void)dealloc{
	[code release];
	[super dealloc];
}

@end
