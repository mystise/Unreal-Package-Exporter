//
//  DocModel.h
//  UnrealPackageExporter
//
//  Created by Adalynn Dudney on 3/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import <UnrealToolsFramework/Unreal.h>
#import <UnrealToolsFramework/DataManager.h>
#import "OutlineViewController.h"

@interface DocModel : NSObject {

}

- (void)loadData:(NSData *)data;

- (void)createStuff;

- (void)exportRaw:(id)sender;
- (void)exportData:(id)sender;

- (void)cleanUp;

@property(retain) UNRFile *file;
@property(retain) NSMutableArray *sObj, *sRef;
@property(assign) IBOutlet NSOutlineView *objView;
@property(assign) IBOutlet OutlineViewController *objViewController;

@end
