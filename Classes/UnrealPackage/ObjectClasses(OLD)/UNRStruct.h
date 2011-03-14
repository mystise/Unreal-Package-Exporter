//
//  UNRStruct.h
//  UnrealPackageExporter
//
//  Created by Adalynn Dudney on 9/14/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "UNRField.h"

@interface UNRStruct : UNRField {
	UNRBase *textObj;
	UNRBase *childrenObj;
	UNRName *name;
	int line;
	int textPos;
	int scriptSize;
	NSMutableData *code;
}

- (void)parseScript:(DataManager *)manager;

@end
