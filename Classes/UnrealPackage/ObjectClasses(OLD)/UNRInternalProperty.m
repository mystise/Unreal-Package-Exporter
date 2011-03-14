//
//  UNRProperty.m
//  iOSDevCampUnrealModelView
//
//  Created by Adalynn Dudney on 8/20/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "UNRInternalProperty.h"
#import "UNRFile.h"

@implementation UNRInternalProperty

@synthesize name, size, type, special, data, index, structName;

- (id)initWithManager:(DataManager *)manager file:(UNRFile *)file{
	if(self = [super init]){
		int nameRef = [UNRInternalProperty readIndex:manager];
		if(nameRef == 0){//if refrencing None, then quit. (needs string compare if you create the name first rather than using this two step process)
			[self release];
			return nil;
		}
		/*if(nameRef > [file.names count]){
			//fail!!!
			//should't happen
			[self release];
			return nil;
		}*/
		name = [file.names objectAtIndex:nameRef];
		Byte info = [manager loadByte];
		type = info & 0x0F;
		size = (info >> 4) & 0x07;
		special = (info >> 7) & 0x01;
		switch (type) {
			case 0x0A:
				structName = [file.names objectAtIndex:[UNRFile readCompactIndex:manager]];
				break;
			default:
				break;
		}		
		unsigned int realSize = 0;
		switch (size) {
			case 0x00:
				realSize = 1;
				break;
			case 0x01:
				realSize = 2;
				break;
			case 0x02:
				realSize = 4;
				break;
			case 0x03:
				realSize = 12;
				break;
			case 0x04:
				realSize = 16;
				break;
			case 0x05:
				realSize = [manager loadByte];
				break;
			case 0x06:
				realSize = [manager loadShort];
				break;
			case 0x07:
				realSize = [manager loadInt];
				break;
			default:
				break;
		}
		if(special == YES && type != 3){
			index = [UNRInternalProperty readIndex:manager];
		}
		if(type != 0x03){
			if([manager.fileData length] >= realSize + manager.curPos && realSize < [manager.fileData length]){
				data = [[manager.fileData subdataWithRange:NSMakeRange(manager.curPos, realSize)] retain];
				[manager jumpToOffset:manager.curPos + realSize];
			}else{
				printf("Outside file size.\n");
				[self release];
				return nil;
			}
		}
	}
	return self;
}

+ (int)readIndex:(DataManager *)manager{
	Byte indexByte1 = [manager loadByte];
	int ind = indexByte1 & 0x3F;
	Byte cont = indexByte1 & 0xC0;
	if(cont == 0x80){
		Byte secondByte = [manager loadByte];
		ind = (ind<<6)|secondByte;
	}else if(cont == 0xC0){
		Byte byte1 = [manager loadByte];
		Byte byte2 = [manager loadByte];
		Byte byte3 = [manager loadByte];
		ind = (ind<<6)|byte1;
		ind = (ind<<14)|byte2;
		ind = (ind<<22)|byte3;
	}
	return ind;
}

- (NSString *)stringValue{
	return name.name;
}

- (NSString *)description{
	NSMutableString *propString = [NSMutableString string];
	[propString appendFormat:@"Name: %@\n", name.name];
	if(structName != nil){
		[propString appendFormat:@"Struct Name: %@\n", structName.name];
	}
	//[propString appendFormat:@"Name: %X\n", nameRef];
	//[propString appendFormat:@"Struct Name: %X\n", structNameRef];
	[propString appendFormat:@"Type: %X\n", type];
	if(index != 0){
		[propString appendFormat:@"Index: %X\n", index];
	}
	if(data != nil){
		[propString appendFormat:@"Data: %@\n\n", data];
	}
	return [propString copy];
}

- (void)dealloc{
	[data release];
	[super dealloc];
}

@end
