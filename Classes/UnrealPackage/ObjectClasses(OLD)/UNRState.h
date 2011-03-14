//
//  UNRState.h
//  UnrealPackageExporter
//
//  Created by Adalynn Dudney on 9/14/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "UNRStruct.h"

@interface UNRState : UNRStruct {
	long probeMask;
	long ignoreMask;
	short labelTableOffset;
	int stateFlags;
}

@end

#define ST_Editable 0x01
#define ST_Auto 0x02
#define ST_Simulated 0x04
