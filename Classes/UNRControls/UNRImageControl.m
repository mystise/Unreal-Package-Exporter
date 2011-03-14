//
//  UNRImageControl.m
//  UnrealPackageExporter
//
//  Created by Adalynn Dudney on 3/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "UNRImageControl.h"

#import "UNRFile.h"
#import "UNRProperty.h"
#import "DataManager.h"

@implementation UNRImageControl

- (id)initWithView:(NSView *)view label:(NSString *)label top:(float)top dataObject:(id)dataObject
			  data:(NSString *)dataKeyPath widthObject:(id)widthObject width:(NSString *)widthKeyPath
		  propList:(NSArray *)propList file:(UNRFile *)theFile{
	if(self = [super initWithView:view label:label top:top]){
		NSRect frame = view.frame;
		
		NSScrollView *scrollView = [[NSScrollView alloc] initWithFrame:NSMakeRect(20.0f, top+32.0f, frame.size.width-40.0f, frame.size.width-40.0f)];
		NSImageView *imageView = [[NSImageView alloc] initWithFrame:NSMakeRect(0.0f, 0.0f, 256.0f, 256.0f)];
		[scrollView setDocumentView:imageView];
		[view addSubview:scrollView];
		
		[imageView setImageAlignment:NSImageAlignCenter];
		[imageView setImageFrameStyle:NSImageFrameGrayBezel];
		[imageView setImageScaling:NSImageScaleNone];
		[imageView setAutoresizingMask:NSViewWidthSizable|NSViewHeightSizable];
		
		[scrollView setAutoresizingMask:NSViewWidthSizable|NSViewMaxYMargin];
		
		height += frame.size.width-8.0f;
		
		palette = nil;
		format = 0;
		file = theFile;
		
		for(UNRProperty *prop in propList){
			DataManager *manager = [[DataManager alloc] initWithFileData:prop.data];
			if([[prop.name.string lowercaseString] isEqualToString:@"palette"]){
				palette = [[file resolveObjectReference:[UNRFile readCompactIndex:manager]] objectData];
			}else if([[prop.name.string lowercaseString] isEqualToString:@"format"]){
				format = [manager loadByte];
			}
			[manager release];
		}
		//bind width to self, data to self
	}
	return self;
}

- (void)setData:(NSData *)newData{
	if(format == 0){
		if(palette == nil){
			//Error
			return;
		}
		//scan through input, for loop, grabbing bytes and indexing them to the palette
		//for 0 to width
		//for 0 to data.size/width
		//	scan byte
		//	grab color from palette
		//	output color to the data object
		//end for
		//end for
		
		//create raw image from data object
		//output image to the imageView
	}
}

@end
