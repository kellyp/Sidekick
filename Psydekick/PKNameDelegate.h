//
//  PKNameDelegate.h
//  Psydekick
//
//  Created by kelly on 3/31/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MainViewController.h"

@interface PKNameDelegate : NSObject <UIPickerViewDelegate> {
    MainViewController *viewController;
}

@property (readonly) MainViewController *viewController;

-(PKNameDelegate*) initWithViewController:(MainViewController*) viewController;

@end
