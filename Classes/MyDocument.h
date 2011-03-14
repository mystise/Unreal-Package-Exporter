//
//  MyDocument.h
//  UnrealPackageExporter
//
//  Created by Adalynn Dudney on 7/27/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//


#import <Cocoa/Cocoa.h>

#import "DocModel.h"

@interface MyDocument : NSDocument{
	
}

- (IBAction)exportObject:(id)sender;

@property(retain) IBOutlet DocModel *model;
@property(retain) NSData *data;

@end
