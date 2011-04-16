//
//  PKNameDelegate.m
//  Psydekick
//
//  Created by kelly on 3/31/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PKNameDelegate.h"
#import "PKNameDataSource.h"

@implementation PKNameDelegate

@synthesize viewController;

-(PKNameDelegate*) initWithViewController:(MainViewController*) someViewController
{
    self = [super init];
    if(self){
        viewController = [someViewController retain];
        
    }
    return self;
}

-(void) dealloc
{
    [viewController release];
    [super dealloc];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if( [pickerView.dataSource conformsToProtocol:@protocol(PKNameDataSource)]){
        id<PKNameDataSource> dataSource = (id<PKNameDataSource>)pickerView.dataSource;
        switch(component){
            case 0:
                return [dataSource.firstNames  objectAtIndex: row%dataSource.firstNames.count];
            case 1:
                return [dataSource.middleNames  objectAtIndex: row%dataSource.middleNames.count];
            case 2:
                return [dataSource.lastNames  objectAtIndex: row%dataSource.lastNames.count];
        }
    }
    return @"None";
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    switch(component){
        case 0:
            viewController.firstNameField.text =  [((id<PKNameDataSource>)pickerView.dataSource).firstNames objectAtIndex:(row)%((id<PKNameDataSource>)pickerView.dataSource).firstNames.count];
            break;
            
        case 1:
            viewController.middleNameField.text = [((id<PKNameDataSource>)pickerView.dataSource).middleNames objectAtIndex:(row)%((id<PKNameDataSource>)pickerView.dataSource).middleNames.count];
            break;
            
        case 2:
            viewController.lastNameField.text = [((id<PKNameDataSource>)pickerView.dataSource).lastNames objectAtIndex:(row)%((id<PKNameDataSource>)pickerView.dataSource).lastNames.count ];
            break;
    }
}

@end
