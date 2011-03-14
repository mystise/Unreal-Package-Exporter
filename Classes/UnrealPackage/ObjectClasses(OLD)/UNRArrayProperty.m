//
//  UNRArrayProperty.m
//  UnrealPackageExporter
//
//  Created by Adalynn Dudney on 9/14/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "UNRArrayProperty.h"


@implementation UNRArrayProperty

- (id)initWithObject:(UNRExport *)export file:(UNRFile *)file manager:(DataManager *)manager{
	if(self = [super initWithObject:export file:file manager:manager]){
		int elementRef = [UNRFile readCompactIndex:manager];
		element = [file resolveObjectRefrence:elementRef];
	}
	return self;
}

@end
