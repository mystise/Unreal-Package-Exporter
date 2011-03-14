//
//  UNRNumberControl.h
//  UnrealPackageExporter
//
//  Created by Adalynn Dudney on 12/30/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "UNRControl.h"

@interface UNRNumberControl : UNRControl <NSTextFieldDelegate> {
	
}

- (id)initWithView:(NSView *)view label:(NSString *)label top:(float)top object:(id)object keyPath:(NSString *)keyPath edit:(BOOL)editable;

@end
