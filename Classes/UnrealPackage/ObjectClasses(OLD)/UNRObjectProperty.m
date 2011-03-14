//
//  UNRObjectProperty.m
//  UnrealPackageExporter
//
//  Created by Adalynn Dudney on 9/14/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "UNRObjectProperty.h"


@implementation UNRObjectProperty

- (id)initWithObject:(UNRExport *)export file:(UNRFile *)file manager:(DataManager *)manager{
	if(self = [super initWithObject:export file:file manager:manager]){
		int typeRef = [UNRFile readCompactIndex:manager];
		type = [file resolveObjectRefrence:typeRef];
	}
	return self;
}

@end
