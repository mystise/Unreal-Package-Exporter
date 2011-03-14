//
//  UNRControl.h
//  UnrealPackageExporter
//
//  Created by Adalynn Dudney on 12/30/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

typedef enum{
	UNRSmall = 5,
	UNRNormal = 10,
	UNRLarge = 15
}UNRControlSize;

@interface UNRControl : NSObject {
	
}

- (id)initWithView:(NSView *)view label:(NSString *)label top:(float)top;

+ (UNRControlSize)sizeFromString:(NSString *)string;

@property(assign) float height;

@end
