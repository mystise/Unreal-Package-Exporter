//
//  UNRNative.m
//  UnrealPackageExporter
//
//  Created by Adalynn Dudney on 9/18/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "UNRNative.h"


@implementation UNRNative

- (id)initWithObject:(UNRExport *)export file:(UNRFile *)file manager:(DataManager *)manager{
	if(self = [super init]){
		properties = [[NSMutableDictionary alloc]init];
		UNRInternalProperty *prop = [[UNRInternalProperty alloc] initWithManager:manager file:file];
		while(prop != nil){
			[properties setObject:prop forKey:prop.name.name];
			[prop release];
			prop = [[UNRInternalProperty alloc] initWithManager:manager file:file];
		}
	}
	return self;
}

- (void)dealloc{
	[properties release];
	[super dealloc];
}

@end
