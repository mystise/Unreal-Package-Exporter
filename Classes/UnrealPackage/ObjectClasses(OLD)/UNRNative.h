//
//  UNRNative.h
//  UnrealPackageExporter
//
//  Created by Adalynn Dudney on 9/18/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Unreal.h"
#import "DataManager.h"
#import "UNRInternalProperty.h"

@interface UNRNative : NSObject {
	NSMutableDictionary *properties;
}

- (id)initWithObject:(UNRExport *)export file:(UNRFile *)file manager:(DataManager *)manager;

@end
