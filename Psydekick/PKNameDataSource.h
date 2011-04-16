//
//  PKFirstNameDataSource.h
//  Psydekick
//
//  Created by kelly on 3/31/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PKNameDataSource <NSObject>

-(NSMutableArray*) firstNames;
-(NSMutableArray*) middleNames;
-(NSMutableArray*) lastNames;

@end

@interface PKNameDataSource : NSObject <UIPickerViewDataSource, PKNameDataSource>{
    NSMutableArray *firstNames;
    NSMutableArray *middleNames;
    NSMutableArray *lastNames;
}

@property(readonly, retain) NSMutableArray *firstNames;
@property(readonly, retain) NSMutableArray *middleNames;
@property(readonly, retain) NSMutableArray *lastNames;

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView;
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component;


@end

