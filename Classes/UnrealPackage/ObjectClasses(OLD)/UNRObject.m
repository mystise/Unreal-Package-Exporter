//
//  UNRObject.m
//  UnrealPackageExporter
//
//  Created by Adalynn Dudney on 9/12/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "UNRObject.h"

@implementation UNRObject

- (id)initWithObject:(UNRExport *)export file:(UNRFile *)file manager:(DataManager *)manager{
	if(self = [super init]){
		properties = [[NSMutableDictionary alloc]init];
		frame.node = -1;
		if((OF_HasStack & export.objectFlags) != 0){
			frame.node = [UNRFile readCompactIndex:manager];
			frame.stateNode = [UNRFile readCompactIndex:manager];
			frame.probeMask = [manager loadLong];
			frame.latentAction = [manager loadInt];
			offset = [UNRFile readCompactIndex:manager];
		}
		if(export.classObj != nil){
			UNRInternalProperty *prop = [[UNRInternalProperty alloc]initWithManager:manager file:file];
			while(prop != nil){
				[properties setObject:prop forKey:prop.name.name];
				[prop release];
				prop = [[UNRInternalProperty alloc]initWithManager:manager file:file];
			}
		}
	}
	return self;
}

- (NSString *)description{
	NSMutableString *description = [NSMutableString string];
	if([properties count] > 0){
		[description appendString:[properties description]];
	}
	if(frame.node != -1){
		[description appendString:@"State Frame:\n\t"];
		[description appendFormat:@"node: %i\n\t", frame.node];
		[description appendFormat:@"stateNode: %i\n\t", frame.stateNode];
		[description appendFormat:@"probeMask: %l\n\t", frame.probeMask];
		[description appendFormat:@"latentAction: %i\n\t", frame.latentAction];
		[description appendFormat:@"offset: %i\n", offset];
	}
	return [description copy];
}

- (void)dealloc{
	[properties release];
	[super dealloc];
}

@end
