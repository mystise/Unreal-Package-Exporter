//
//  UNRListControl.m
//  UnrealPackageExporter
//
//  Created by Adalynn Dudney on 1/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "UNRListControl.h"


@implementation UNRListControl

- (id)initWithView:(NSView *)view label:(NSString *)label top:(float)top object:(id)object keyPath:(NSString *)keyPath size:(UNRControlSize)size{
	if(self = [super initWithView:view label:label top:top]){
		NSRect frame = view.frame;
		float ydist = 22.0f*size;
		NSScrollView *scrollView = [[[NSScrollView alloc] initWithFrame:NSMakeRect(20.0f, top+32.0f, frame.size.width-40.0f, ydist)] autorelease];
		NSTableView *tableView = [[[NSTableView alloc] initWithFrame:NSZeroRect] autorelease];
		[scrollView setDocumentView:tableView];
		[view addSubview:scrollView];
		
		NSTableColumn *column = [[[NSTableColumn alloc] initWithIdentifier:nil] autorelease];
		[[column headerCell] setStringValue:@""];
		[column setWidth:[tableView frame].size.width];
		[column setEditable:NO];
		
		[tableView addTableColumn:column];
		
		[tableView setAutoresizingMask:NSViewWidthSizable|NSViewHeightSizable];
		[scrollView setAutoresizingMask:NSViewWidthSizable|NSViewMaxYMargin];
		[scrollView setBorderType:NSBezelBorder];
		[scrollView setHasVerticalScroller:YES];
		[scrollView setAutohidesScrollers:NO];
		
		self.height += 10.0f+ydist;
		
		NSMutableString *newKeyPath = [NSMutableString stringWithString:@"arrangedObjects"];
		NSArray *pathElements = [keyPath componentsSeparatedByString:@"."];
		for(int i = 1; i < [pathElements count]; i++){
			if([newKeyPath length] > 0){
				[newKeyPath appendString:@"."];
			}
			[newKeyPath appendString:[pathElements objectAtIndex:i]];
		}
		
		[column bind:@"value" toObject:object withKeyPath:newKeyPath options:nil];
	}
	return self;
}

@end
