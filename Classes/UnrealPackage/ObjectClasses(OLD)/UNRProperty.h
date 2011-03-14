//
//  UNRProperty.h
//  UnrealPackageExporter
//
//  Created by Adalynn Dudney on 9/14/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "UNRField.h"

@interface UNRProperty : UNRField {
	short arrayDimension;
	short elementSize;
	int propertyFlags;
	UNRName *catagory;
	short replicationOffset;
}

@end

#define PF_Edit 0x01
#define PF_Const 0x02
#define PF_Input 0x04
#define PF_ExportObject 0x08
#define PF_OptionalParm 0x10
#define PF_Net 0x20
#define PF_ConstRef 0x40
#define PF_Parm 0x80
#define PF_OutParm 0x0100
#define PF_SkipParm 0x0200
#define PF_ReturnParm 0x0400
#define PF_CoerceParm 0x0800
#define PF_Native 0x1000
#define PF_Transient 0x2000
#define PF_Config 0x4000
#define PF_Localized 0x8000
#define PF_Travel 0x010000
#define PF_EditConst 0x020000
#define PF_GlobalConfig 0x040000
#define PF_OnDemand 0x100000
#define PF_New 0x200000
#define PF_NeedCtorLink 0x400000
