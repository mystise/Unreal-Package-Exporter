//
//  UNRControl.m
//  UnrealPackageExporter
//
//  Created by Adalynn Dudney on 12/30/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "UNRControl.h"


@implementation UNRControl

@synthesize height = height_;

- (id)initWithView:(NSView *)view label:(NSString *)label top:(float)top{
	if(self = [super init]){
		NSRect frame = view.frame;
		NSTextField *labelField = [[[NSTextField alloc] initWithFrame:NSMakeRect(20.0f, top, frame.size.width/2.0f-20.0f, 22.0f)] autorelease];
		[view addSubview:labelField];
		[labelField setAutoresizingMask:NSViewMaxXMargin|NSViewWidthSizable|NSViewMaxYMargin];
		[labelField setBordered:NO];
		[labelField setEditable:NO];
		[labelField setDrawsBackground:NO];
		labelField.stringValue = label;
		
		NSFont *font = [NSFont fontWithName:[[labelField.cell font] fontName] size:[NSFont systemFontSizeForControlSize:NSRegularControlSize]];
		[labelField.cell setControlSize:NSRegularControlSize];
		[labelField setFont:font];
		
		self.height = 22.0f; //height of control, 22 because that is the height of the label
	}
	return self;
}

+ (UNRControlSize)sizeFromString:(NSString *)string{
	UNRControlSize size = UNRSmall;
	if([[string lowercaseString] isEqualToString:@"medium"]){
		size = UNRNormal;
	}
	if([[string lowercaseString] isEqualToString:@"large"]){
		size = UNRLarge;
	}
	return size;
}

@end
