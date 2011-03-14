//
//  UNRTextBuffer.m
//  UnrealPackageExporter
//
//  Created by Adalynn Dudney on 9/14/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "UNRTextBuffer.h"


@implementation UNRTextBuffer

- (id)initWithObject:(UNRExport *)export file:(UNRFile *)file manager:(DataManager *)manager{
	if(self = [super initWithObject:export file:file manager:manager]){
		pos = [manager loadInt];
		top = [manager loadInt];
		int textSize = [UNRFile readCompactIndex:manager];
		NSData *textDat = [manager.fileData subdataWithRange:NSMakeRange(manager.curPos, textSize)];
		text = [[NSString alloc]initWithData:textDat encoding:NSUTF8StringEncoding];
		[manager loadByte]; //null should be 0
	}
	return self;
}

- (NSString *)description{
	return text;
}

- (void)dealloc{
	[text release];
	[super dealloc];
}

@end
