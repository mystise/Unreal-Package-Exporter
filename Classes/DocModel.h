//
//  DocModel.h
//  UnrealPackageExporter
//
//  Created by Adalynn Dudney on 3/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import "Unreal.h"
#import "DataManager.h"
#import "OutlineViewController.h"

@interface DocModel : NSObject {

}

- (void)loadData:(NSData *)data;

- (void)createStuff;
- (void)exportObject:(id)sender;

@property(retain) UNRFile *file;
@property(retain) NSMutableArray *sObj, *sRef;
@property(assign) IBOutlet NSOutlineView *objView;
@property(assign) IBOutlet OutlineViewController *objViewController;

@end
