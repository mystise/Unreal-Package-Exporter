//
//  PluginLoader.h
//  UnrealPackageExporter
//
//  Created by Adalynn Dudney on 1/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import "Unreal.h"
#import "DataManager.h"
@class UNRControlManager, UNRObject;

@interface PluginLoader : NSObject <NSXMLParserDelegate> {
	
}

- (void)loadPlugin:(UNRExport *)object controlManager:(UNRControlManager *)manager;

- (void)addTextControlWithAttributes:(NSDictionary *)attrib;
- (void)addListControlWithAttributes:(NSDictionary *)attrib;
- (void)addNumberControlWithAttributes:(NSDictionary *)attrib;
- (void)addStringControlWithAttributes:(NSDictionary *)attrib;
- (void)addIntPopUpControlWithAttributes:(NSDictionary *)attrib;
- (void)addSoundControlWithAttributes:(NSDictionary *)attrib;

@property(retain) UNRControlManager *controlManager;
@property(retain) NSMutableDictionary *plugins;
@property(assign) BOOL addControls;
@property(retain) UNRExport *obj;
@property(retain) NSDictionary *controlTypes;
@property(retain) NSURL *url;

@end
