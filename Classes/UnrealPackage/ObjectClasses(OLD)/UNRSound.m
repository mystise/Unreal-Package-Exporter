//
//  UNRSound.m
//  UnrealPackageExporter
//
//  Created by Adalynn Dudney on 9/14/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "UNRSound.h"


@implementation UNRSound

- (id)initWithObject:(UNRExport *)export file:(UNRFile *)file manager:(DataManager *)manager{
	if(self = [super initWithObject:export file:file manager:manager]){
		int soundRef = [UNRFile readCompactIndex:manager];
		soundFormat = [file resolveObjectRefrence:soundRef];
		if(file.version >= 63){
			[manager loadInt];//offsetNext unused
		}
		int soundSize = [UNRFile readCompactIndex:manager];
		soundData = [manager.fileData subdataWithRange:NSMakeRange(manager.curPos, soundSize)];
	}
	return self;
}

- (NSString *)description{
	return [super description];
}

@end
