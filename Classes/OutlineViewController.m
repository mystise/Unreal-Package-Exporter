//
//  TableViewData.m
//  UnrealPackageExporter
//
//  Created by Adalynn Dudney on 7/29/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "OutlineViewController.h"

#import "DocModel.h"
#import "TabViewController.h"

@implementation OutlineViewController

@synthesize control = control_, selected = selected_, window = window_, doc = doc_;

- (NSInteger)outlineView:(NSOutlineView *)outlineView numberOfChildrenOfItem:(id)item{
	if([item isKindOfClass:[NSMutableArray class]]){
		return [item count];
	}else if([item isKindOfClass:[UNRBase class]]){
		UNRBase *item2 = item;
		return [item2.subObjects count];
	}
	if(item == nil){
		return 3;
	} 
	return 0;
}

- (BOOL)outlineView:(NSOutlineView *)outlineView isItemExpandable:(id)item{
	if([item isKindOfClass:[NSMutableArray class]]){
		return YES;
	}else if([item isKindOfClass:[UNRBase class]]){
		UNRBase *item2 = item;
		if([item2.subObjects count] > 0){
			return YES;
		}
	}
	return NO;
}

- (id)outlineView:(NSOutlineView *)outlineView child:(NSInteger)index ofItem:(id)item{
	if(item != nil){
		if([item isKindOfClass:[NSMutableArray class]]){
			NSMutableArray *item2 = item;
			return [item2 objectAtIndex:index];
		}else if([item isKindOfClass:[UNRBase class]]){
			UNRBase *item2 = item;
			return [item2.subObjects objectAtIndex:index];
		}
	}else if(item == nil){
		if(index == 0){
			return self.doc.sObj;
		}else if(index == 1){
			return self.doc.sRef;
		}else{
			return self.doc.file.names;
		}
	}
	return nil;
}

- (id)outlineView:(NSOutlineView *)outlineView objectValueForTableColumn:(NSTableColumn *)tableColumn byItem:(id)item{
	if(item != nil){
		if([item isKindOfClass:[UNRBase class]]){
			UNRBase *obj = item;
			return obj.name.string;
		}else if([item isKindOfClass:[NSMutableArray class]]){
			NSMutableArray *item2 = item;
			if(item2 == self.doc.sObj){
				return @"Objects";
			}else if(item2 == self.doc.sRef){
				return @"Refrences";
			}else if(item2 == self.doc.file.names){
				return @"Names";
			}
		}else if([item isKindOfClass:[UNRName class]]){
			UNRName *name = item;
			return name.string;
		}
	}else{
		return @"Nil!!!";
	}
	return @"Nil!";
}

- (BOOL)outlineView:(NSOutlineView *)outlineView shouldSelectItem:(id)item{
	self.selected = nil;
	self.control.file = self.doc.file;
	if([item isKindOfClass:[UNRExport class]]){
		self.selected = item;
	}
	if([item isKindOfClass:[NSMutableArray class]]){
		[self.control updateTabView:self.doc.file];
	}else{
		[self.control updateTabView:item];
	}
	return YES;
}

- (void)rawExport{
	if(self.selected != nil){
		NSSavePanel *save = [[NSSavePanel alloc]init];
		[save setCanCreateDirectories:YES];
		UNRBase *obj = self.selected.classObj;
		NSString *fileExtension;
		if(obj != nil){
			fileExtension = obj.name.string;
		}else{
			fileExtension = @"unrData";
		}
		[save setAllowedFileTypes:[NSArray arrayWithObject:fileExtension]];
		[save setExtensionHidden:NO];
		[save beginSheetModalForWindow:self.window completionHandler:^ (NSInteger result){
			if(result == NSOKButton){
				[self.selected.data writeToURL:[save URL] atomically:YES];
			}
		}];
	}
}

- (void)dataExport{
	if(self.selected != nil){
		NSSavePanel *save = [[NSSavePanel alloc]init];
		[save setCanCreateDirectories:YES];
		UNRBase *obj = self.selected.classObj;
		NSString *fileExtension;
		if(obj != nil){
			fileExtension = obj.name.string;
		}else{
			fileExtension = @"unrData";
		}
		[save setAllowedFileTypes:[NSArray arrayWithObject:fileExtension]];
		[save setExtensionHidden:NO];
		[save beginSheetModalForWindow:self.window completionHandler:^ (NSInteger result){
			if(result == NSOKButton){
				//loop through each plugin and ask it if it works
				//self.control.loader.classTrace
				//when you find one, call the method
			}
		}];
	}
}

- (void)cleanUp{
	[control_ updateTabView:nil];
}

- (void)dealloc{
	//[control_ release];
	//control_ = nil;
	[selected_ release];
	selected_ = nil;
	//[window_ release];
	//window_ = nil;
	//[doc_ release];
	//doc_ = nil;
	[super dealloc];
}

@end
