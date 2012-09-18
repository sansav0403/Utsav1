//
//  RSSpaService.m
//  ResortSuite
//
//  Created by Cybage on 9/5/11.
//  Copyright 2011 Resort Suite. All rights reserved.
//

#import "RSSpaService.h"

@implementation RSSpaServices

@synthesize spaServices;
@synthesize spaServiceResult;

-(id)init
{
    self = [super init];
    if (self)
    {
        spaServices = [[NSMutableArray alloc]init];
        spaServiceResult = [[Result alloc]init];
    }
    return self;
}
-(void)dealloc
{    
    [spaServices removeAllObjects];
    [spaServices release];
    [spaServiceResult release];
     [super dealloc];
}
@end

@implementation RSSpaService
@synthesize spaItemID;
@synthesize location;
@synthesize itemName;
@synthesize itemDesc;
@synthesize clientInstruction;
@synthesize price;
@synthesize serviceTime;
@synthesize sameGender;

@synthesize itemCategory;
@synthesize itemSubCategory;

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
    [itemName release];
    [itemDesc release];
    [clientInstruction release];
    
    [itemCategory release];
    [itemSubCategory release];
    
    [super dealloc];
}

-(BOOL)doesTheStringExitsInTheObject:(NSString *)string
{
   
    if ([itemName rangeOfString:string options:NSCaseInsensitiveSearch].location != NSNotFound)
    {
        return YES;
    } 
    else if ([itemDesc rangeOfString:string options:NSCaseInsensitiveSearch].location != NSNotFound)
    {
       return YES;
    }
    else if ([itemCategory rangeOfString:string options:NSCaseInsensitiveSearch].location != NSNotFound)
    {
        return YES;
    }
    else if ([itemSubCategory rangeOfString:string options:NSCaseInsensitiveSearch].location != NSNotFound)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}
@end
