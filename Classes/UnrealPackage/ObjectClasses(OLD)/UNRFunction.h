//
//  UNRFunction.h
//  UnrealPackageExporter
//
//  Created by Adalynn Dudney on 9/14/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "UNRStruct.h"

@interface UNRFunction : UNRStruct {
	int argumentsSize;
	short native;
	int numArgs;
	Byte operatorPrecedence;
	int returnValueOffset;
	int functionFlags;
	short replicationOffset;
}

#define FUNC_Final 0x01
#define FUNC_Defined 0x02
#define FUNC_Iterator 0x04
#define FUNC_Latent 0x08
#define FUNC_PreOperator 0x10
#define FUNC_Singular 0x20
#define FUNC_Net 0x40

@end
