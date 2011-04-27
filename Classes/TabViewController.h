//
//  TabViewController.h
//  UnrealPackageExporter
//
//  Created by Adalynn Dudney on 12/28/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import <UnrealToolsFramework/Unreal.h>
#import "UNRControlManager.h"
#import "PluginLoader.h"

@interface TabViewController : NSObject {
	
}

- (void)updateTabView:(id)item;
- (void)addImportViews:(UNRImport *)obj;
- (void)addExportViews:(UNRExport *)obj;
- (void)addFileViews:(UNRFile *)file;

@property(assign) IBOutlet NSTabView *tabView;
@property(retain) NSMutableDictionary *managers;
@property(retain) UNRFile *file;
@property(retain) PluginLoader *loader;

@end
