//
//  UNRFixedArrayProperty.m
//  UnrealPackageExporter
//
//  Created by Adalynn Dudney on 9/14/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "UNRFixedArrayProperty.h"


@implementation UNRFixedArrayProperty

- (id)initWithObject:(UNRExport *)export file:(UNRFile *)file manager:(DataManager *)manager{
	if(self = [super initWithObject:export file:file manager:manager]){
		int elementRef = [UNRFile readCompactIndex:manager];
		element = [file resolveObjectRefrence:elementRef];
		count = [UNRFile readCompactIndex:manager];
	}
	return self;
}

@end
