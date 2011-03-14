//
//  UNRControlManager.h
//  UnrealPackageExporter
//
//  Created by Adalynn Dudney on 12/30/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "UNRControl.h"
#import "UNRStringControl.h"
#import "UNRNumberControl.h"
#import "UNRTextControl.h"
#import "UNRIntPopUpControl.h"
#import "UNRListControl.h"
#import "UNRSoundControl.h"
#import "UNRControlView.h"

@interface UNRControlManager : NSObject {
	
}

- (id)initWithSuperView:(NSScrollView *)superView;

- (void)updateView;

- (void)addStringControl:(id)object keyPath:(NSString *)keyPath label:(NSString *)label editable:(BOOL)editable;
- (void)addNumberControl:(id)object keyPath:(NSString *)keyPath label:(NSString *)label editable:(BOOL)editable;
- (void)addTextControl:(id)object keyPath:(NSString *)keyPath label:(NSString *)label size:(UNRControlSize)size;
- (void)addIntPopUpControl:(id)object keyPath:(NSString *)keyPath label:(NSString *)label from:(NSString *)fromString to:(NSString *)toString;
- (void)addListControl:(id)object keyPath:(NSString *)keyPath label:(NSString *)label size:(UNRControlSize)size;
- (void)addSoundControl:(id)object keyPath:(NSString *)keyPath label:(NSString *)label;

- (NSDictionary *)controllerFromObject:(id)object withKeyPath:(NSString *)keyPath;

@property(retain) NSMutableArray *controls;
@property(retain) UNRControlView *view;
@property(assign) float y;
@property(retain) NSMutableDictionary *objectControllers;

@end
