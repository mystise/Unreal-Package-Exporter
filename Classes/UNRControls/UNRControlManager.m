//
//  UNRControlManager.m
//  UnrealPackageExporter
//
//  Created by Adalynn Dudney on 12/30/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "UNRControlManager.h"


@implementation UNRControlManager

@synthesize controls = controls_, view = view_, y = y_, objectControllers = objectControllers_;

- (id)initWithSuperView:(NSScrollView *)superView{
	if(self = [super init]){
		NSRect frame = superView.frame;
		self.view = [[[UNRControlView alloc] initWithFrame:NSMakeRect(0.0f, 0.0f, frame.size.width, 1.0f)] autorelease];
		[self.view setAutoresizingMask:NSViewWidthSizable|NSViewMinYMargin];
		[superView setDocumentView:self.view];
		self.controls = [NSMutableArray array];
		self.y = 1.0f; //inital height
		self.objectControllers = [NSMutableDictionary dictionary];
	}
	return self;
}

- (void)addStringControl:(id)object keyPath:(NSString *)keyPath label:(NSString *)label editable:(BOOL)editable{
	NSDictionary *objDictionary = [self controllerFromObject:object withKeyPath:keyPath];
	[[objDictionary valueForKey:@"controller"] setEditable:editable];
	UNRStringControl *control = [[UNRStringControl alloc] initWithView:self.view label:label top:self.y object:[objDictionary valueForKey:@"controller"] keyPath:[objDictionary valueForKey:@"keyPath"] editable:editable];
	if(control != nil){
		[self.controls addObject:control];
		self.y += control.height + 10.0f; //10.0f is spacing
		[control release];
		[self updateView];
	}
}

- (void)addNumberControl:(id)object keyPath:(NSString *)keyPath label:(NSString *)label editable:(BOOL)editable{
	NSDictionary *objDictionary = [self controllerFromObject:object withKeyPath:keyPath];
	UNRNumberControl *control = [[UNRNumberControl alloc] initWithView:self.view label:label top:self.y object:[objDictionary valueForKey:@"controller"] keyPath:[objDictionary valueForKey:@"keyPath"] edit:editable];
	if(control != nil){
		[self.controls addObject:control];
		self.y += control.height + 10.0f; //10.0f is spacing
		[control release];
		[self updateView];
	}
}

- (void)addTextControl:(id)object keyPath:(NSString *)keyPath label:(NSString *)label size:(UNRControlSize)size{
	NSDictionary *objDictionary = [self controllerFromObject:object withKeyPath:keyPath];
	[[objDictionary valueForKey:@"controller"] setEditable:NO];
	UNRTextControl *control = [[UNRTextControl alloc] initWithView:self.view label:label top:self.y object:[objDictionary valueForKey:@"controller"] keyPath:[objDictionary valueForKey:@"keyPath"] size:size];
	if(control != nil){
		[self.controls addObject:control];
		self.y += control.height + 10.0f; //10.0f is spacing
		[control release];
		[self updateView];
	}
}

- (void)addIntPopUpControl:(id)object keyPath:(NSString *)keyPath label:(NSString *)label from:(NSString *)fromString to:(NSString *)toString{
	NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
	[formatter setNumberStyle:NSNumberFormatterNoStyle];
	[formatter setGeneratesDecimalNumbers:NO];
	[formatter setAllowsFloats:NO];
	
	NSNumber *fromNumber;
	BOOL fromSuccess = [formatter getObjectValue:&fromNumber forString:fromString range:nil error:nil];
	if(!fromSuccess){
		NSDictionary *fromDict = [self controllerFromObject:object withKeyPath:fromString];
		fromNumber = [[fromDict valueForKeyPath:@"controller"] valueForKeyPath:[fromDict valueForKeyPath:@"keyPath"]];
		if(![fromNumber isKindOfClass:[NSNumber class]]){
			fromNumber = [NSNumber numberWithInt:0];
		}
	}
	
	NSNumber *toNumber;
	BOOL toSuccess = [formatter getObjectValue:&toNumber forString:toString range:nil error:nil];
	if(!toSuccess){
		NSDictionary *toDict = [self controllerFromObject:object withKeyPath:toString];
		toNumber = [[toDict valueForKeyPath:@"controller"] valueForKeyPath:[toDict valueForKeyPath:@"keyPath"]];
		if(![toNumber isKindOfClass:[NSNumber class]]){
			toNumber = [[fromNumber copy] autorelease];
		}
	}
	[formatter release];
	
	/*id fromObj = [[obj.currentData objectAtIndex:0] valueForKeyPath:[attrib valueForKey:@"from"]];
	 id toObj = [[obj.currentData objectAtIndex:0] valueForKeyPath:[attrib valueForKey:@"to"]];
	 int from, to;
	 
	 if(fromObj == nil){
	 from = [[attrib valueForKey:@"from"] intValue];
	 }else{
	 from = [fromObj intValue];
	 }
	 
	 if(toObj == nil){
	 to = [[attrib valueForKey:@"to"] intValue];
	 }else{
	 to = [toObj intValue];
	 }*/
	NSDictionary *objDictionary = [self controllerFromObject:object withKeyPath:keyPath];
	UNRIntPopUpControl *control = [[UNRIntPopUpControl alloc] initWithView:self.view label:label top:self.y object:[self.objectControllers valueForKeyPath:[objDictionary valueForKey:@"arrayName"]] keyPath:@"" from:[fromNumber intValue] to:[toNumber intValue]];
	if(control != nil){
		[self.controls addObject:control];
		self.y += control.height + 10.0f; //10.0f is spacing
		[control release];
		[self updateView];
	}
}

- (void)addListControl:(id)object keyPath:(NSString *)keyPath label:(NSString *)label size:(UNRControlSize)size{
	NSDictionary *objDictionary = [self controllerFromObject:object withKeyPath:keyPath];
	[[objDictionary valueForKey:@"controller"] setEditable:NO];
	if([[objDictionary valueForKey:@"arrayCount"] unsignedIntValue] != 0){
		UNRListControl *control = [[UNRListControl alloc] initWithView:self.view label:label top:self.y object:[objDictionary valueForKey:@"controller"] keyPath:[objDictionary valueForKey:@"keyPath"] size:size];
		if(control != nil){
			[self.controls addObject:control];
			self.y += control.height + 10.0f; //10.0f is spacing
			[control release];
			[self updateView];
		}
	}
}

- (void)addSoundControl:(id)object keyPath:(NSString *)keyPath label:(NSString *)label{
	NSDictionary *objDictionary = [self controllerFromObject:object withKeyPath:keyPath];
	UNRSoundControl *control = [[UNRSoundControl alloc] initWithView:self.view label:label top:self.y object:[objDictionary valueForKey:@"controller"] keyPath:[objDictionary valueForKey:@"keyPath"]];
	if(control != nil){
		[self.controls addObject:control];
		self.y += control.height + 10.0f; //10.0f is spacing
		[control release];
		[self updateView];
	}
}

- (NSDictionary *)controllerFromObject:(id)object withKeyPath:(NSString *)keyPath{
	NSMutableDictionary *objDictionary = [NSMutableDictionary dictionary];
	NSString *pathComponent;
	NSMutableString *outputKeyPath = [NSMutableString string];
	NSArray *path = [keyPath componentsSeparatedByString:@"."];
	NSString *arrayName = nil;
	NSNumber *arrayCount = nil;
	id currentObject = object;
	for(pathComponent in path){
		//if [currentObject valueForKeyPath:outputKeyPath] is type of class NSArray
		//	create an array controller
		//	currentObject = array controller
		//	[outputKeyPath setString:@"selection"];
		//	[objectControllers setValue:arrayController forKey:pathComponent];
		//end if
		if([outputKeyPath length] > 0){
			[outputKeyPath appendString:@"."];
		}
		[outputKeyPath appendFormat:@"%@", pathComponent];
		if([[currentObject valueForKeyPath:outputKeyPath] isKindOfClass:[NSArray class]]){
			NSArrayController *controller = [self.objectControllers valueForKey:pathComponent];
			if(controller == nil){
				controller = [[[NSArrayController alloc] init] autorelease];
				[controller bind:@"content" toObject:currentObject withKeyPath:outputKeyPath options:nil];
			}
			currentObject = controller;
			[outputKeyPath setString:@"selection"];
			[self.objectControllers setValue:controller forKey:pathComponent];
			arrayName = [[pathComponent copy] autorelease];
			arrayCount = [NSNumber numberWithUnsignedInt:[[controller content] count]];
		}
	}
	if(!arrayName){
		NSObjectController *objControl = [[[NSObjectController alloc] initWithContent:currentObject] autorelease];
		currentObject = objControl;
		[outputKeyPath setString:[NSString stringWithFormat:@"content.%@", outputKeyPath]];
	}
	//if there are no arrays
	//	NSObjectController *objControl = [[NSObjectController alloc] initWithContent:object];
	//	add it to the dictionary
	//	set keyPath to what it should be
	//end if
	[objDictionary setValue:currentObject forKey:@"controller"];
	[objDictionary setValue:outputKeyPath forKey:@"keyPath"];
	if(arrayName){
		[objDictionary setValue:arrayName forKey:@"arrayName"];
		[objDictionary setValue:arrayCount forKey:@"arrayCount"];
	}
	return [[objDictionary copy] autorelease];
}

- (void)updateView{
	NSRect frame = self.view.superview.frame;
	NSRect newFrame = NSMakeRect(0.0f, 0.0f, frame.size.width, self.y+10.0f);
	[self.view setFrame:newFrame];
}

- (void)dealloc{
	[controls_ release];
	controls_ = nil;
	[view_ release];
	view_ = nil;
	[objectControllers_ release];
	objectControllers_ = nil;
	[super dealloc];
}

@end
