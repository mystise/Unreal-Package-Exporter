//
//  UNRProperty.h
//  iOSDevCampUnrealModelView
//
//  Created by Adalynn Dudney on 8/20/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Unreal.h"
#import "DataManager.h"

@interface UNRInternalProperty : NSObject {
	int index;
	UNRName *name, *structName;
	Byte size, type;
	BOOL special;
	NSData *data;
}

- (id)initWithManager:(DataManager *)manager file:(UNRFile *)file;

+ (int)readIndex:(DataManager *)manager;
- (NSString *)stringValue;

@property(nonatomic, assign) int index;
@property(nonatomic, assign) Byte size, type;
@property(nonatomic, assign) BOOL special;
@property(nonatomic, retain) NSData *data;
@property(nonatomic, retain) UNRName *name, *structName;

@end
