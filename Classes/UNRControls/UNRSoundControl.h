//
//  UNRSoundControl.h
//  UnrealPackageExporter
//
//  Created by Adalynn Dudney on 2/28/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "UNRControl.h"
#import <QTKit/QTKit.h>

@interface UNRSoundControl : UNRControl {
	
}

- (id)initWithView:(NSView *)view label:(NSString *)label top:(float)top object:(id)object keyPath:(NSString *)keyPath;

@property(retain) NSSound *sound;

@end
