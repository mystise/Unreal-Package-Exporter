//
//  UNRPopUpControl.m
//  UnrealPackageExporter
//
//  Created by Adalynn Dudney on 1/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "UNRIntPopUpControl.h"


@implementation UNRIntPopUpControl

- (id)initWithView:(NSView *)view label:(NSString *)label top:(float)top object:(id)object keyPath:(NSString *)keyPath from:(int)from to:(int)to{
	if(from != to){
		if(self = [super initWithView:view label:label top:top]){
			NSRect frame = view.frame;
			NSPopUpButton *popUp = [[[NSPopUpButton alloc] initWithFrame:NSMakeRect(frame.size.width/2.0f, top, frame.size.width/2.0f-20.0f, 22.0f) pullsDown:NO] autorelease];
			[view addSubview:popUp];
			
			popUp.alignment = NSRightTextAlignment;
			[popUp setAutoresizingMask:NSViewMinXMargin|NSViewWidthSizable|NSViewMaxYMargin];
			
			NSFont *font = [NSFont fontWithName:[[popUp.cell font] fontName] size:[NSFont systemFontSizeForControlSize:NSRegularControlSize]];
			[popUp.cell setControlSize:NSRegularControlSize];
			[popUp.cell setFont:font];
			
			for(int i = from; i < to; i++){
				[popUp addItemWithTitle:[NSString stringWithFormat:@"%i", i]];
			}
			
			[popUp bind:@"selectedIndex" toObject:object withKeyPath:@"selectionIndex" options:nil];
		}
	}else{
		[self release];
		self = nil;
	}
	return self;
}

@end
