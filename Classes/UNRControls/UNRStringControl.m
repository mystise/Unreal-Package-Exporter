//
//  UNRStringControl.m
//  UnrealPackageExporter
//
//  Created by Adalynn Dudney on 12/30/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "UNRStringControl.h"


@implementation UNRStringControl

- (id)initWithView:(NSView *)view label:(NSString *)label top:(float)top object:(id)object keyPath:(NSString *)keyPath editable:(BOOL)editable{
	if([object valueForKeyPath:keyPath] != nil){
		if(self = [super initWithView:view label:label top:top]){
			NSRect frame = view.frame;
			NSTextField *textField = [[[NSTextField alloc] initWithFrame:NSMakeRect(frame.size.width/2.0f, top, frame.size.width/2.0f-20.0f, 22.0f)] autorelease];
			[view addSubview:textField];
			
			if(!editable){
				[textField setEditable:NO];
				[textField setBordered:NO];
				textField.drawsBackground = NO;
			}
			textField.alignment = NSRightTextAlignment;
			[textField setAutoresizingMask:NSViewMinXMargin|NSViewWidthSizable|NSViewMaxYMargin];
			
			NSFont *font = [NSFont fontWithName:[[textField.cell font] fontName] size:[NSFont systemFontSizeForControlSize:NSRegularControlSize]];
			[textField.cell setControlSize:NSRegularControlSize];
			[textField.cell setFont:font];
			
			[textField bind:@"value" toObject:object withKeyPath:keyPath options:nil];
		}
	}else{
		[self release];
		self = nil;
	}
	return self;
}

@end
