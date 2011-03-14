//
//  UNRTextControl.m
//  UnrealPackageExporter
//
//  Created by Adalynn Dudney on 12/31/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "UNRTextControl.h"


@implementation UNRTextControl

- (id)initWithView:(NSView *)view label:(NSString *)label top:(float)top object:(id)object keyPath:(NSString *)keyPath size:(UNRControlSize)size{
	if([object valueForKeyPath:keyPath] != nil){			
		if(self = [super initWithView:view label:label top:top]){
			float ydist = 22.0f*size;
			NSScrollView *scrollView = [[[NSScrollView alloc] initWithFrame:NSMakeRect(20.0f, top+32.0f, view.frame.size.width-40.0f, ydist)] autorelease];
			NSTextView *textView = [[[NSTextView alloc] initWithFrame:NSMakeRect(0.0f, 0.0f, scrollView.frame.size.width, ydist)] autorelease];
			[scrollView setDocumentView:textView];
			[view addSubview:scrollView];
			
			textView.alignment = NSLeftTextAlignment;
			[textView setAutoresizingMask:NSViewWidthSizable|NSViewHeightSizable];
			[scrollView setAutoresizingMask:NSViewWidthSizable|NSViewMaxYMargin];
			[scrollView setBorderType:NSBezelBorder];
			[scrollView setHasVerticalScroller:YES];
			[scrollView setAutohidesScrollers:NO];
			
			self.height += 10.0f+ydist;
			
			[textView bind:@"string" toObject:object withKeyPath:keyPath options:nil];
		}
	}else{
		[self release];
		self = nil;
	}
	return self;
}

@end
