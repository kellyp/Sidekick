//
//  PKFirstNameDataSource.m
//  Psydekick
//
//  Created by kelly on 3/31/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PKNameDataSource.h"


@implementation PKNameDataSource

@synthesize firstNames;
@synthesize middleNames;
@synthesize lastNames;

-(PKNameDataSource*) init
{
    self = [super init];
    
    
    
    firstNames = [[NSMutableArray array] retain];
    middleNames = [[NSMutableArray array] retain];
    lastNames = [[NSMutableArray array] retain];
    
    
    NSString *stringData = [NSString stringWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"data" ofType:@"txt"]
                                                     encoding: NSASCIIStringEncoding error: nil];

    NSArray *rows = [stringData componentsSeparatedByString:@"\n"];
    
    for(NSString *row in rows){
        NSArray *fields = [row componentsSeparatedByString:@","];

        if([[fields objectAtIndex:0] length] > 0)
            [firstNames addObject: [fields objectAtIndex:0]];
        
        if([[[fields objectAtIndex:1] stringByTrimmingCharactersInSet:
            [NSCharacterSet whitespaceAndNewlineCharacterSet]]length] > 0) 
            [middleNames addObject: [fields objectAtIndex:1]];
        
        if([[[fields objectAtIndex:2] stringByTrimmingCharactersInSet:
             [NSCharacterSet whitespaceAndNewlineCharacterSet]]length] > 0) 
            [lastNames addObject: [fields objectAtIndex:2]];
    }
    return self;
}


-(void) dealloc
{
    [firstNames release];
    [middleNames release];
    [lastNames release];
    [super dealloc];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
   return 16384;
}


@end
