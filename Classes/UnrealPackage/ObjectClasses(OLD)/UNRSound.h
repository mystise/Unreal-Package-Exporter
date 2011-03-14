//
//  UNRSound.h
//  UnrealPackageExporter
//
//  Created by Adalynn Dudney on 9/14/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "UNRNative.h"

@interface UNRSound : UNRNative {
	UNRName *soundFormat;
	NSData *soundData;
}

@end
