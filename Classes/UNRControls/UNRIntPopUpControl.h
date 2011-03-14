//
//  UNRPopUpControl.h
//  UnrealPackageExporter
//
//  Created by Adalynn Dudney on 1/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "UNRControl.h"

@interface UNRIntPopUpControl : UNRControl {
	
}

- (id)initWithView:(NSView *)view label:(NSString *)label top:(float)top object:(id)object keyPath:(NSString *)keyPath from:(int)from to:(int)to;

@end
