//
//  UNRTree.m
//  UnrealPackageExporter
//
//  Created by Adalynn Dudney on 9/18/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "UNRTree.h"


@implementation UNRTree

@synthesize objects;

- (id)initWithFile:(UNRFile *)file{
	if(self = [super init]){
		NSDictionary *classes = [[NSDictionary alloc] initWithObjectsAndKeys:
								 [UNRObject class], @"object",
								 [UNRField class], @"field",
								 [UNREnum class], @"enum",
								 [UNRConst class], @"const",
								 [UNRStruct class], @"struct",
								 [UNRProperty class], @"property",
								 [UNRByteProperty class], @"byteproperty",
								 [UNRFixedArrayProperty class], @"fixedarrayproperty",
								 [UNRArrayProperty class], @"arrayproperty",
								 [UNRMapProperty class], @"mapproperty",
								 [UNRStructProperty class], @"structproperty",
								 [UNRObjectProperty class], @"objectproperty",
								 [UNRClassProperty class], @"classproperty",
								 [UNRProperty class], @"intproperty",
								 [UNRProperty class], @"boolproperty",
								 [UNRProperty class], @"floatproperty",
								 [UNRProperty class], @"nameproperty",
								 [UNRProperty class], @"strproperty",
								 [UNRProperty class], @"stringproperty",
								 [UNRStruct class], @"function", //change to function
								 [UNRStruct class], @"state", //change to state
								 [UNRNative class], @"texture", //change to texture
								 [UNRNative class], @"palette", //change to palette
								 [UNRNative class], @"font", //change to font
								 [UNRTextBuffer class], @"textbuffer",
								 [UNRSound class], @"sound",
								 [UNRNative class], @"mesh", //change to mesh
								 [UNRNative class], @"lodmesh", //change to lodmesh
								 [UNRNative class], @"skeletalmesh", //change to skeletalmesh
								 [UNRNative class], @"animation", //change to animation
								 nil];
		objects = [[NSMutableArray alloc]init];
		for(UNRExport *obj in file.objects){
			DataManager *manager = [[DataManager alloc] initWithFileData:obj.objectData];
			//take obj.classObj if it is ok then init object and add to array
			//if not then take obj.superObj.classObj until it is
			//if there is no class coresponding to it, then add an empty UNRObject into the list
			if(obj.classObj != nil){
				//load the class for the object
				Class class = [classes objectForKey:[obj.classObj.objectName.name lowercaseString]];
				//fallback measure, if the native class doesn't exist, but the class is defined in this file, then continue from there
				UNRBase *obj2 = obj.classObj;
				id obj3;
				BOOL cont = YES;
				while(cont == YES){
					if(class == nil){
						if([obj2 isKindOfClass:[UNRExport class]]){
							UNRExport *obj3 = (UNRExport *)obj2;
							obj2 = obj3.superObj;
						}else{
							class = [NSNull class];
							obj3 = [class null];
							cont = NO;
						}
					}else{
						obj3 = [[class alloc] initWithObject:obj file:file manager:manager];
						cont = NO;
					}
					if(cont == YES){
						class = [classes objectForKey:obj2.objectName.name];
					}
				}
				[objects addObject:obj3];
			}else{
				id obj3 = [[UNRStruct alloc] initWithObject:obj file:file manager:manager];
				[objects addObject:obj3];
			}
			[manager release];
		}
	}
	return self;
}

- (void)dealloc{
	[objects release];
	[super dealloc];
}

@end
