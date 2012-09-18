//
//  RSGolfLocation.m
//  ResortSuite
//
//  Created by Cybage on 07/09/11.
//  Copyright 2011 ResortSuite . All rights reserved.
//

#import "RSGolfLocations.h"


@implementation RSGolfLocation

@synthesize locationId;
@synthesize locationName;
@synthesize mondayOpen; 
@synthesize mondayClose;
@synthesize tuesdayOpen; 
@synthesize tuesdayClose; 
@synthesize wednesdayOpen;
@synthesize wednesdayClose;
@synthesize thursdayOpen; 
@synthesize thursdayClose; 
@synthesize fridayOpen; 
@synthesize fridayClose; 
@synthesize saturdayOpen; 
@synthesize saturdayClose; 
@synthesize sundayOpen;
@synthesize sundayClose;



- (id) init
{
    if ((self = [super init])) {
        // instantiation code	
	}
	
    return self;
}


-(void) dealloc
{	
	[locationId release];
	[locationName release];
	[mondayOpen release];
	[mondayClose release];
	[tuesdayOpen release];
	[tuesdayClose release];
	[wednesdayOpen release];
	[wednesdayClose release];
	[thursdayOpen release];
	[thursdayClose release];
	[fridayOpen release];
	[fridayClose release];
	[saturdayOpen release];
	[saturdayClose release];
	[sundayOpen release];
	[sundayClose release];
	
	[super dealloc];
}

-(NSString *)description
{
    NSString *desc = [NSString stringWithFormat:@"LOCATION NAME = %@",self.locationName];
    return desc;
}
@end



@implementation RSGolfLocations

@synthesize golfLocationsfResult;
@synthesize golfLocations;

- (id) init
{
    if ((self = [super init])) {
        // instantiation code	
		golfLocations = [[NSMutableArray alloc] init];
	}
	
    return self;
}


-(void) dealloc
{
	[golfLocationsfResult release];
	
	[golfLocations removeAllObjects];
	[golfLocations release];
	
	[super dealloc];
}



@end

