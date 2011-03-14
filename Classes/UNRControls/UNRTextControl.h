//
//  UNRTextControl.h
//  UnrealPackageExporter
//
//  Created by Adalynn Dudney on 12/31/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "UNRControl.h"

@interface UNRTextControl : UNRControl {
	
}

- (id)initWithView:(NSView *)view label:(NSString *)label top:(float)top object:(id)object keyPath:(NSString *)keyPath size:(UNRControlSize)size;

@end
