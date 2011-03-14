//
//  UNRStructProperty.m
//  UnrealPackageExporter
//
//  Created by Adalynn Dudney on 9/14/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "UNRStructProperty.h"


@implementation UNRStructProperty

- (id)initWithObject:(UNRExport *)export file:(UNRFile *)file manager:(DataManager *)manager{
	if(self = [super initWithObject:export file:file manager:manager]){
		int structRef = [UNRFile readCompactIndex:manager];
		structObj = [file resolveObjectRefrence:structRef];
	}
	return self;
}

@end
