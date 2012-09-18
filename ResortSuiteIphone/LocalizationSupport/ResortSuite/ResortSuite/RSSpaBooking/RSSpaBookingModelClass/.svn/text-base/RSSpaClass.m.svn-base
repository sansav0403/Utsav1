//
//  RSSpaClass.m
//  ResortSuite
//
//  Created by Cybage on 9/5/11.
//  Copyright 2011 Resort Suite. All rights reserved.
//

#import "RSSpaClass.h"


@implementation RSDailySpaClasses

@synthesize spaClasses;
@synthesize spaClassResult;

@synthesize date;
-(id)init
{
    self = [super init];
    if (self)
    {
        spaClasses = [[NSMutableArray alloc]init];
        spaClassResult = [[Result alloc]init];
    }
    return self;

}
-(void)dealloc
{
    [date release];
    [spaClasses removeAllObjects];
    [spaClasses release];
    [spaClassResult release];
    [super dealloc];
}
@end

@implementation RSSpaClass

@synthesize spaClassId;
@synthesize spaItemId;
@synthesize spaItemName;
@synthesize itemDescription;
@synthesize clientInstruction;   //new addition
@synthesize price;
@synthesize spaRoomId;        
@synthesize serviceTime;

@synthesize startTime;
@synthesize endTime;
@synthesize availSlots;
@synthesize spaStaffId;
@synthesize isProgramHeader;
@synthesize numClasses;
@synthesize totalPrice;

@synthesize itemSubCategory;
@synthesize itemCategory;

-(id)init
{

    self = [super init];
    if (self)
    {
        
    }
    return self;
}

-(void)dealloc
{
    [spaItemName release];
    [itemDescription release];
    [clientInstruction release];
    
    [spaRoomId release];        //should be int 
    
    [startTime release];
    [endTime release];
    
    [itemCategory release];
    [itemSubCategory release];
    
    [super dealloc];
}
@end
