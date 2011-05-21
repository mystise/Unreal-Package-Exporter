/*
 *  UNRDataExportPlugin.h
 *  UnrealPackageExporter
 *
 *  Created by Adalynn Dudney on 3/28/11.
 *  Copyright 2011 __MyCompanyName__. All rights reserved.
 *
 */

#import <Foundation/Foundation.h>
#import <UnrealToolsFramework/Unreal.h>

@protocol UNRDataExportPlugin

- (BOOL)canExportDataWithClassTrace:(NSArray *)classTrace;
- (void)exportData:(UNRExport *)export withFile:(UNRFile *)file andPath:(NSString *)path;

@end