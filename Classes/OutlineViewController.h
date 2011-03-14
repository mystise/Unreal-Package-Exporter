//
//  TableViewData.h
//  UnrealPackageExporter
//
//  Created by Adalynn Dudney on 7/29/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import "Unreal.h"
@class DocModel, TabViewController;

@interface OutlineViewController : NSObject<NSOutlineViewDataSource, NSOutlineViewDelegate> {
	
}

- (void)exportToFile;

@property(assign) IBOutlet TabViewController *control;
@property(retain) UNRExport *selected;
@property(assign) IBOutlet NSWindow *window;
@property(assign) IBOutlet DocModel *doc;

@end
