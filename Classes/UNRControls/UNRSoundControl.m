//
//  UNRSoundControl.m
//  UnrealPackageExporter
//
//  Created by Adalynn Dudney on 2/28/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "UNRSoundControl.h"


@implementation UNRSoundControl

@synthesize sound = sound_;

- (id)initWithView:(NSView *)view label:(NSString *)label top:(float)top object:(id)object keyPath:(NSString *)keyPath{
	if(self = [super initWithView:view label:label top:top]){
		NSRect frame = view.frame;
		self.sound = [[NSSound alloc] initWithData:[object valueForKeyPath:keyPath]];
		
		NSButton *playButton = [[[NSButton alloc] initWithFrame:NSMakeRect(frame.size.width/2.0f, top, frame.size.width/2.0f-20.0f, 22.0f)] autorelease];
		[view addSubview:playButton];
		[playButton setTitle:@"Play"];
		[playButton setAlternateTitle:@"Stop"];
		[playButton setButtonType:NSToggleButton];
		[playButton setBezelStyle:NSRoundRectBezelStyle];
		[playButton setTarget:self];
		[playButton setAction:@selector(toggleSound)];
		
		[playButton setAutoresizingMask:NSViewMinXMargin|NSViewWidthSizable|NSViewMaxYMargin];
		//TODO: do all this with bindings
	}
	return self;
}

- (void)toggleSound{
	if([self.sound isPlaying]){
		[self.sound stop];
	}else{
		[self.sound play];
	}
}

- (void)dealloc{
	[sound_ stop];
	[sound_ release];
	sound_ = nil;
	[super dealloc];
}

@end
