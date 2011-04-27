//
//  PluginLoader.m
//  UnrealPackageExporter
//
//  Created by Adalynn Dudney on 1/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PluginLoader.h"

#import "UNRControlManager.h"
#import "UNRObject.h"

@implementation PluginLoader

@synthesize controlManager = controlManager_, plugins = plugins_, addControls = addControls_, obj = obj_, controlTypes = controlTypes_, url = url_, classTrace = classTrace_;

- (id)init{
	if((self = [super init])){
		self.classTrace = [NSMutableArray array];
		self.plugins = [NSMutableDictionary dictionary];
		NSFileManager *manager = [[[NSFileManager alloc] init] autorelease];
		NSBundle *bundle = [NSBundle mainBundle];
		NSString *path = [[bundle resourcePath] stringByAppendingPathComponent:@"Default Plugins"];
		NSDirectoryEnumerator *enumerator = [manager enumeratorAtPath:path];
		NSString *filePath;
		while((filePath = [enumerator nextObject])){
			if([[filePath pathExtension] isEqualToString:@"xml"]){
				self.url = [NSURL fileURLWithPath:[path stringByAppendingPathComponent:filePath]];
				//NSURL *url = [NSURL fileURLWithPath:[path stringByAppendingPathComponent:filePath]];
				NSXMLParser *parser = [[NSXMLParser alloc] initWithContentsOfURL:self.url];
				parser.delegate = self;
				[parser parse];
				[parser release];
			}
		}
		self.addControls = NO;
		self.controlTypes = [NSDictionary dictionaryWithObjectsAndKeys:
							 @"addTextControlWithAttributes:", @"textcontrol",
							 @"addListControlWithAttributes:", @"listcontrol",
							 @"addNumberControlWithAttributes:", @"numbercontrol",
							 @"addStringControlWithAttributes:", @"stringcontrol",
							 @"addIntPopUpControlWithAttributes:", @"intpopupcontrol",
							 @"addSoundControlWithAttributes:", @"soundcontrol",
							 nil];
	}
	return self;
}

- (void)loadPlugin:(UNRExport *)object controlManager:(UNRControlManager *)manager{
	self.obj = object;
	self.addControls = NO;
	self.controlManager = manager;
	NSString *className = object.classObj.name.string;
	if(className == nil){
		className = @"Class";
	}
	[self.classTrace addObject:[className lowercaseString]];
	
	//NSXMLParser *parser = [self.plugins valueForKey:[className lowercaseString]];
	//if(parser == nil){
	//	parser = [self.plugins valueForKey:@"object"];
	//}
	NSURL *url = [self.plugins valueForKey:[className lowercaseString]];
	if(url == nil){
		url = [self.plugins valueForKey:@"object"];
	}
	NSXMLParser *parser = [[NSXMLParser alloc] initWithContentsOfURL:url];
	parser.delegate = self;
	[parser parse];
	[parser release];
	
	if([self.obj valueForKeyPath:@"objectData.leftoverData.description"] != nil){
		[manager addTextControl:self.obj keyPath:@"objectData.leftoverData.description" label:@"Leftover Data:" size:UNRNormal];
	}
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)eName namespaceURI:(NSString *)nURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)aDict{
	eName = [eName lowercaseString];
	if([eName isEqualToString:@"plugin"]){
		NSString *className = [aDict valueForKey:@"class"];
		if([self.plugins valueForKey:className] == nil){
			[self.plugins setValue:self.url forKey:className];
			//[self.plugins setValue:parser forKey:className];
			//[parser abortParsing];
		}else{
			NSString *superClassName = [aDict valueForKey:@"super"];
			if(superClassName != nil){
				//NSXMLParser *superParser = [self.plugins valueForKey:superClassName];
				[self.classTrace addObject:[superClassName lowercaseString]];
				NSXMLParser *superParser = [[NSXMLParser alloc] initWithContentsOfURL:[self.plugins valueForKey:superClassName]];
				superParser.delegate = self;
				[superParser parse];
				[superParser release];
			}
		}
	}else if([eName isEqualToString:@"controls"]){
		self.addControls = YES;
	}else if(self.addControls){
		NSString *methodName = [self.controlTypes valueForKey:eName];
		if(methodName){
			SEL method = NSSelectorFromString(methodName);
			[self performSelector:method withObject:aDict];
		}
	}
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)eName namespaceURI:(NSString *)nURI qualifiedName:(NSString *)qName{
	if([eName isEqualToString:@"controls"]){
		self.addControls = NO;
	}
}

- (void)addTextControlWithAttributes:(NSDictionary *)attrib{
	NSString *label = [attrib valueForKey:@"label"];
	UNRControlSize size = [UNRControl sizeFromString:[attrib valueForKey:@"size"]];
	id object = self.obj.objectData;
	NSString *keyPath = [attrib valueForKey:@"input"];
	[self.controlManager addTextControl:object keyPath:keyPath label:label size:size];
}

- (void)addListControlWithAttributes:(NSDictionary *)attrib{
	NSString *label = [attrib valueForKey:@"label"];
	UNRControlSize size = [UNRControl sizeFromString:[attrib valueForKey:@"size"]];
	id object = self.obj.objectData;
	NSString *keyPath = [attrib valueForKey:@"input"];
	[self.controlManager addListControl:object keyPath:keyPath label:label size:size];
}

- (void)addNumberControlWithAttributes:(NSDictionary *)attrib{
	NSString *label = [attrib valueForKey:@"label"];
	BOOL editable = [[attrib valueForKey:@"editable"] boolValue];
	id object = self.obj.objectData;
	NSString *keyPath = [attrib valueForKey:@"input"];
	[self.controlManager addNumberControl:object keyPath:keyPath label:label editable:editable];
}

- (void)addStringControlWithAttributes:(NSDictionary *)attrib{
	NSString *label = [attrib valueForKey:@"label"];
	BOOL editable = [[attrib valueForKey:@"editable"] boolValue];
	id object = self.obj.objectData;
	NSString *keyPath = [attrib valueForKey:@"input"];
	[self.controlManager addStringControl:object keyPath:keyPath label:label editable:editable];
}

- (void)addIntPopUpControlWithAttributes:(NSDictionary *)attrib{
	NSString *label = [attrib valueForKey:@"label"];
	NSString *fromString = [attrib valueForKey:@"from"];
	NSString *toString = [attrib valueForKey:@"to"];
	id object = self.obj.objectData;
	NSString *keyPath = [attrib valueForKey:@"bind"];
	[self.controlManager addIntPopUpControl:object keyPath:keyPath label:label from:fromString to:toString];
}

- (void)addSoundControlWithAttributes:(NSDictionary *)attrib{
	NSString *label = [attrib valueForKey:@"label"];
	id object = self.obj.objectData;
	NSString *keyPath = [attrib valueForKey:@"input"];
	[self.controlManager addSoundControl:object keyPath:keyPath label:label];
}

- (void)dealloc{
	[classTrace_ release];
	classTrace_ = nil;
	[controlManager_ release];
	controlManager_ = nil;
	[plugins_ release];
	plugins_ = nil;
	[obj_ release];
	obj_ = nil;
	[controlTypes_ release];
	controlTypes_ = nil;
	[url_ release];
	url_ = nil;
	[super dealloc];
}

@end
