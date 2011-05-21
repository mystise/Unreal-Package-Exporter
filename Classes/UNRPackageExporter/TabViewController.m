//
//  TabViewController.m
//  UnrealPackageExporter
//
//  Created by Adalynn Dudney on 12/28/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "TabViewController.h"


@implementation TabViewController

@synthesize tabView = tabView_, managers = managers_, file = file_, loader = loader_;

- (void)awakeFromNib{
	self.managers = [NSMutableDictionary dictionary];
	self.loader = [[[PluginLoader alloc] init] autorelease];
}

- (void)updateTabView:(id)item{
	int index = [[self.tabView tabViewItems] indexOfObject:[self.tabView selectedTabViewItem]];
	for(NSTabViewItem *item in [self.tabView tabViewItems]){
		[self.tabView removeTabViewItem:item]; //remove all tabs
	}
	
	if([item isKindOfClass:[UNRExport class]]){
		[self addExportViews:(UNRExport *)item];
	}else if([item isKindOfClass:[UNRImport class]]){
		[self addImportViews:(UNRImport *)item];
	}else if([item isKindOfClass:[UNRFile class]]){
		[self addFileViews:(UNRFile *)item];
	}
	
	if(index > -1 && index < [[self.tabView tabViewItems] count]){
		[self.tabView selectTabViewItemAtIndex:index];
	}
}

- (void)addFileViews:(UNRFile *)file{
	NSScrollView *fileInfoScroll = [[[NSScrollView alloc] initWithFrame:[self.tabView contentRect]] autorelease];
	[fileInfoScroll setDrawsBackground:NO];
	[fileInfoScroll setHasVerticalScroller:YES];
	[fileInfoScroll setAutohidesScrollers:YES];
	NSTabViewItem *fileInfo = [[[NSTabViewItem alloc] initWithIdentifier:nil] autorelease];
	fileInfo.label = @"File Info";
	fileInfo.view = fileInfoScroll;
	
	UNRControlManager *manager = [[UNRControlManager alloc] initWithSuperView:fileInfoScroll];
	[self.managers setValue:manager forKey:@"File Info"];
	[manager release];
	
	[manager addNumberControl:file keyPath:@"version" label:@"File Version:" editable:YES];
	[manager addNumberControl:file keyPath:@"objectCount" label:@"Object Count:" editable:NO];
	[manager addNumberControl:file keyPath:@"referenceCount" label:@"Refrence Count:" editable:NO];
	[manager addNumberControl:file keyPath:@"nameCount" label:@"Name Count:" editable:NO];
	[manager addNumberControl:file keyPath:@"flags" label:@"File Flags:" editable:YES];
	[manager addNumberControl:file keyPath:@"licensee" label:@"Licensee:" editable:YES];
	
	[self.tabView addTabViewItem:fileInfo];
}

- (void)addExportViews:(UNRExport *)obj{
	//Info View
	NSScrollView *infoScroll = [[[NSScrollView alloc] initWithFrame:[self.tabView contentRect]] autorelease];
	[infoScroll setDrawsBackground:NO];
	[infoScroll setHasVerticalScroller:YES];
	[infoScroll setAutohidesScrollers:YES];
	NSTabViewItem *info = [[[NSTabViewItem alloc] initWithIdentifier:nil] autorelease];
	info.label = @"Info";
	info.view = infoScroll;
	
	UNRControlManager *manager = [[UNRControlManager alloc] initWithSuperView:infoScroll];
	[self.managers setValue:manager forKey:@"Info"];
	[manager release];
	
	[manager addStringControl:obj keyPath:@"name.string" label:@"Object Name:" editable:YES];
	[manager addStringControl:obj keyPath:@"package.name.string" label:@"Package Name:" editable:YES];
	[manager addStringControl:obj keyPath:@"classObj.name.string" label:@"Class Name:" editable:YES];
	[manager addStringControl:obj keyPath:@"superObj.name.string" label:@"Super Class Name:" editable:YES];
	[manager addNumberControl:obj keyPath:@"flags" label:@"Object Flags:" editable:YES];
	[manager addNumberControl:obj keyPath:@"subObjectsCount" label:@"Subobject Count:" editable:NO];
	[manager addNumberControl:obj keyPath:@"data.length" label:@"Data Size:" editable:NO];
	
	[self.tabView addTabViewItem:info];
	
	//Raw Data View
	NSScrollView *rawDataScroll = [[[NSScrollView alloc] initWithFrame:[self.tabView contentRect]] autorelease];
	[rawDataScroll setDrawsBackground:NO];
	[rawDataScroll setHasVerticalScroller:YES];
	[rawDataScroll setAutohidesScrollers:YES];
	NSTabViewItem *rawData = [[[NSTabViewItem alloc] initWithIdentifier:nil] autorelease];
	
	rawData.label = @"Raw Data";
	rawData.view = rawDataScroll;
	
	manager = [[UNRControlManager alloc] initWithSuperView:rawDataScroll];
	[self.managers setValue:manager forKey:@"Raw Data"];
	[manager release];
	
	[manager addTextControl:obj keyPath:@"data.description" label:@"Raw Data:" size:UNRLarge];
	
	[self.tabView addTabViewItem:rawData];
	
	//Data View
	NSScrollView *dataScroll = [[[NSScrollView alloc] initWithFrame:[self.tabView contentRect]] autorelease];
	[dataScroll setDrawsBackground:NO];
	[dataScroll setHasVerticalScroller:YES];
	[dataScroll setAutohidesScrollers:YES];
	NSTabViewItem *data = [[[NSTabViewItem alloc] initWithIdentifier:nil] autorelease];
	
	data.label = @"Data";
	data.view = dataScroll;
	
	manager = [[UNRControlManager alloc] initWithSuperView:dataScroll];
	[self.managers setValue:manager forKey:@"Data"];
	[manager release];
	
	[obj loadPlugin:self.file];
	[self.loader loadPlugin:obj controlManager:manager];
	
	[self.tabView addTabViewItem:data];
}

- (void)addImportViews:(UNRImport *)obj{
	//Info View
	NSScrollView *infoScroll = [[[NSScrollView alloc] initWithFrame:[self.tabView contentRect]] autorelease];
	[infoScroll setDrawsBackground:NO];
	[infoScroll setHasVerticalScroller:YES];
	[infoScroll setAutohidesScrollers:YES];
	NSTabViewItem *info = [[[NSTabViewItem alloc] initWithIdentifier:nil] autorelease];
	
	info.label = @"Info";
	info.view = infoScroll;
	
	UNRControlManager *manager = [[UNRControlManager alloc] initWithSuperView:infoScroll];
	[self.managers setValue:manager forKey:@"Info"];
	[manager release];
	
	[manager addStringControl:obj keyPath:@"name.string" label:@"Name:" editable:YES];
	[manager addStringControl:obj keyPath:@"package.name.string" label:@"Package Name:" editable:YES];
	[manager addStringControl:obj keyPath:@"className.string" label:@"Class Name:" editable:YES];
	[manager addStringControl:obj keyPath:@"classPackage.string" label:@"Class Package:" editable:YES];
	[manager addNumberControl:obj keyPath:@"subObjectsCount" label:@"Subobject Count:" editable:NO];
	
	[self.tabView addTabViewItem:info];
}

- (void)dealloc{
	//[tabView_ release];
	//tabView_ = nil;
	[managers_ release];
	managers_ = nil;
	[file_ release];
	file_ = nil;
	[loader_ release];
	loader_ = nil;
	[super dealloc];
}

@end
