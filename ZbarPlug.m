//
//  ZbarPlug.m
//  Phun
//
//  Created by Jeff Lee on 12/12/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "ZbarPlug.h"

@implementation ZbarPlug

@synthesize callback;

- (void)showZbar:(NSArray*)arguments withDict:(NSDictionary*)options
{
	
	NSUInteger argc = [arguments count];
	self.callback = nil;
	
	if (argc > 0) {
		self.callback = [arguments objectAtIndex:0];
		//[self.callback retain];
	}
	
    ZBarReaderViewController *reader = [ZBarReaderViewController new];
    reader.readerDelegate = self;
	
    ZBarImageScanner *scanner = reader.scanner;
    [scanner setSymbology: ZBAR_I25
				   config: ZBAR_CFG_ENABLE
					   to: 0];
	
    // present and release the controller
    [[super appViewController] presentModalViewController:reader animated:YES];
    [reader release];
}

- (void) imagePickerController: (UIImagePickerController*) reader
 didFinishPickingMediaWithInfo: (NSDictionary*) info
{
    // ADD: get the decode results
    id<NSFastEnumeration> results = [info objectForKey: ZBarReaderControllerResults];
	//UIImage *image = [info objectForKey: UIImagePickerControllerOriginalImage];
    ZBarSymbol *symbol = nil;

    for(symbol in results)
        // EXAMPLE: just grab the first barcode
        break;
	
	// this will execute the your javascript callback
	[ webView stringByEvaluatingJavaScriptFromString: [NSString stringWithFormat:@"%@({value:\"%@\", type:\"%@\"});", self.callback, symbol.data, symbol.typeName ]];
	
	//[self.callback release];

	[info objectForKey: UIImagePickerControllerOriginalImage];
	
    // ADD: dismiss the controller (NB dismiss from the *reader*!)
    [[super appViewController] dismissModalViewControllerAnimated:YES];
	
	// reset position
	// you don't have to do that if you hide the status bar
	webView.frame = CGRectMake(webView.frame.origin.x, 20, webView.frame.size.width, webView.frame.size.height);
}

@end


