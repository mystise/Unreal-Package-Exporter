//
//  UNRObject.h
//  UnrealPackageExporter
//
//  Created by Adalynn Dudney on 9/12/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Unreal.h"
#import "DataManager.h"
#import "UNRInternalProperty.h"

typedef struct{
	int node, stateNode;
	long probeMask;
	int latentAction;
}UNRStateFrame;

@interface UNRObject : NSObject {
	NSMutableDictionary *properties;
	UNRStateFrame frame;
	int offset;
}

- (id)initWithObject:(UNRExport *)export file:(UNRFile *)file manager:(DataManager *)manager;

@end
