//
//  UNRClassProperty.m
//  UnrealPackageExporter
//
//  Created by Adalynn Dudney on 9/14/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "UNRClassProperty.h"


@implementation UNRClassProperty

- (id)initWithObject:(UNRExport *)export file:(UNRFile *)file manager:(DataManager *)manager{
	if(self = [super initWithObject:export file:file manager:manager]){
		int classRef = [UNRFile readCompactIndex:manager];
		classObj = [file resolveObjectRefrence:classRef];
	}
	return self;
}

@end
