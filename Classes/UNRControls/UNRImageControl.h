//
//  UNRImageControl.h
//  UnrealPackageExporter
//
//  Created by Adalynn Dudney on 3/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "UNRControl.h"

@class UNRFile, UNRProperty, DataManager;

@interface UNRImageControl : UNRControl {
	UNRFile *file;
	Byte format;
	NSDictionary *palette;
	int width;
	NSData *data;
}

- (id)initWithView:(NSView *)view label:(NSString *)label top:(float)top dataObject:(id)dataObject data:(NSString *)dataKeyPath widthObject:(id)widthObject width:(NSString *)widthKeyPath propList:(NSArray *)propList file:(UNRFile *)theFile;

@end
