//
//  UNRMapProperty.m
//  UnrealPackageExporter
//
//  Created by Adalynn Dudney on 9/14/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "UNRMapProperty.h"


@implementation UNRMapProperty

- (id)initWithObject:(UNRExport *)export file:(UNRFile *)file manager:(DataManager *)manager{
	if(self = [super initWithObject:export file:file manager:manager]){
		key = [UNRFile readCompactIndex:manager];
		value = [UNRFile readCompactIndex:manager];
	}
	return self;
}

@end
