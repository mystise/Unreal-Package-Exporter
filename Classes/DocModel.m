//
//  DocModel.m
//  UnrealPackageExporter
//
//  Created by Adalynn Dudney on 3/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "DocModel.h"


@implementation DocModel

@synthesize file = file_, sObj = sObj_, sRef = sRef_, objView = objView_, objViewController = objViewController_;

- (id)init{
	if(self = [super init]){
		[self createStuff];
		self.file = [[[UNRFile alloc] init] autorelease];
	}
	return self;
}

- (void)awakeFromNib{
	//[self createStuff];
}

- (void)createStuff{
	self.sObj = [NSMutableArray array];
	self.sRef = [NSMutableArray array];
}

- (void)loadData:(NSData *)data{
	NSString *path = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"Default Plugins"];
	id gak = [[UNRFile alloc] initWithFileData:data pluginsDirectory:path];
	self.file = gak;
	[gak release];
	
	for(UNRExport *obj in self.file.objects){
		UNRBase *obj2 = obj.package;
		if([obj.data length] > 0){
			if(obj2 == nil){
				[self.sObj addObject:obj];
			}else{
				[obj2.subObjects addObject:obj];
			}
		}
	}
	
	for(UNRImport *ref in self.file.references){
		UNRBase *ref2 = ref.package;
		if(ref2 == nil){
			[self.sRef addObject:ref];
		}else{
			[ref2.subObjects addObject:ref];
		}
	}
	
	//self.objViewController.doc = self;
	[self.objView reloadData];
}

- (void)exportObject:(id)sender{
	[self.objViewController exportToFile];
}

- (void)dealloc{
	[sObj_ release];
	sObj_ = nil;
	[sRef_ release];
	sRef_ = nil;
	[file_ release];
	file_ = nil;
	//[objView_ release];
	//objView_ = nil;
	//[objViewController_ release];
	//objViewController_ = nil;
	[super dealloc];
}

@end
