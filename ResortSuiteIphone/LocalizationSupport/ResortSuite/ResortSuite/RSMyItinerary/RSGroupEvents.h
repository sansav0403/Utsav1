//
//  GroupEvents.h
//  ResortSuite
//
//  Created by Cybage on 01/06/11.
//  Copyright 2011 ResortSuite . All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GroupEvent : NSObject
{
	int PMSFolioGroupEventId;
	NSString *location;
	NSString *startTime;
	NSString *endTime;
	
	NSDate *formatedStartTime;
	NSDate *formatedEndTime;
	
	NSString *eventCategory;
	NSString *eventName;
	NSString *eventDesc;	
}

@property (nonatomic) int PMSFolioGroupEventId;
@property (nonatomic, retain) NSString *location;
@property (nonatomic, retain) NSString *startTime;
@property (nonatomic, retain) NSString *endTime;
@property (nonatomic, retain) NSString *eventCategory;
@property (nonatomic, retain) NSString *eventName;
@property (nonatomic, retain) NSString *eventDesc;

@property (nonatomic, retain) NSDate *formatedStartTime;
@property (nonatomic, retain) NSDate *formatedEndTime;
 
@end


@interface RSGroupEvents : NSObject {

	NSMutableArray *groupEventsArr;		//Array of GroupEvent
}
@property (nonatomic, retain) NSMutableArray *groupEventsArr;

@end
