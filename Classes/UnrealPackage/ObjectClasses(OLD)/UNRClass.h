//
//  UNRClass.h
//  UnrealPackageExporter
//
//  Created by Adalynn Dudney on 9/14/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "UNRState.h"

@interface UNRClass : UNRState {
	int classRecordSize;
	int classFlags;
	//GUID classGUID
	int dependenciesCount;
	//each dependency
	UNRBase *classObj;
	int deep;
	int scriptTextCRC;
	//end dependency
	int importsCount;
	//each import
	UNRBase *importObj;
	//end import
	UNRBase *classWithinObj;
	UNRName *classConfigName;
}

@end

#define CL_Abstract 0x01
#define CL_Compiled 0x02
#define CL_Config 0x04
#define CL_Transient 0x08
#define CL_Parsed 0x10
#define CL_Localized 0x20
#define CL_SafeReplace 0x40
#define CL_RuntimeStatic 0x80
#define CL_NoExport 0x0100
#define CL_NoUserCreate 0x0200
#define CL_PerObjectConfig 0x0400
#define CL_NativeReplication 0x0800
