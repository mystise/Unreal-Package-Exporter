//
//  MyDocument.m
//  UnrealPackageExporter
//
//  Created by Adalynn Dudney on 7/27/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MyDocument.h"

@implementation MyDocument

@synthesize model = model_, data = data_;

- (id)init{
	if(self = [super init]){
		
	}
	return self;
}

- (NSString *)windowNibName{
	return @"MyDocument";
}

- (void)windowControllerDidLoadNib:(NSWindowController *) aController{
	[super windowControllerDidLoadNib:aController];
	if(self.data != nil){
		[self.model loadData:self.data];
		self.data = nil;
	}
	// Add any code here that needs to be executed once the windowController has loaded the document's window.
}

- (NSData *)dataOfType:(NSString *)typeName error:(NSError **)outError{
	// Insert code here to write your document to data of the specified type. If the given outError != NULL, ensure that you set *outError when returning nil.
	// You can also choose to override -fileWrapperOfType:error:, -writeToURL:ofType:error:, or -writeToURL:ofType:forSaveOperation:originalContentsURL:error: instead.
	// For applications targeted for Panther or earlier systems, you should use the deprecated API -dataRepresentationOfType:. In this case you can also choose to override -fileWrapperRepresentationOfType: or -writeToFile:ofType: instead.
	
	if(outError != NULL){
		*outError = [NSError errorWithDomain:NSOSStatusErrorDomain code:unimpErr userInfo:NULL];
	}
	return nil;
}

- (BOOL)readFromData:(NSData *)data ofType:(NSString *)typeName error:(NSError **)outError{
	self.data = data;
	
	if(outError != NULL){
		*outError = [NSError errorWithDomain:NSOSStatusErrorDomain code:unimpErr userInfo:NULL];
	}
	return YES;
}

- (IBAction)exportRaw:(id)sender{
	[self.model exportRaw:sender];
}

- (IBAction)exportData:(id)sender{
	[self.model exportData:sender];
}

- (void)windowWillClose:(NSWindow *)window{
	[self.model cleanUp];
}

- (void)dealloc{
	[model_ release];
	model_ = nil;
	[super dealloc];
}

@end
