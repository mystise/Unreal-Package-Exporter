//
//  UNRFunction.m
//  UnrealPackageExporter
//
//  Created by Adalynn Dudney on 9/14/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "UNRFunction.h"


@implementation UNRFunction

- (id)initWithObject:(UNRExport *)export file:(UNRFile *)file manager:(DataManager *)manager{
	if(self = [super initWithObject:export file:file manager:manager]){
		if(file.version <= 63){
			argumentsSize = [UNRFile readCompactIndex:manager];
		}
		native = [manager loadShort];
		if(file.version <= 63){
			numArgs = [UNRFile readCompactIndex:manager];
		}
		operatorPrecedence = [manager loadByte];
		if(file.version <= 63){
			returnValueOffset = [UNRFile readCompactIndex:manager];
		}
		functionFlags = [manager loadInt];
		if((functionFlags & FUNC_Net) != 0){
			replicationOffset = [manager loadShort];
		}
	}
	return self;
}

@end
