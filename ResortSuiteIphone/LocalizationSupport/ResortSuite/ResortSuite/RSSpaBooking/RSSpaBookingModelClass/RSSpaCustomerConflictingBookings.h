//
//  RSSpaBooking.h
//  ResortSuite
//
//  Created by Cybage on 12/10/11.
//  Copyright 2011 ResortSuite. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface RSSpaBooking : NSObject {

	NSString *itemName;
	NSString *startTime;
	NSString *endTime;
	NSString *location;
}

@property(nonatomic,retain) NSString * itemName;
@property(nonatomic,retain) NSString *startTime;
@property(nonatomic,retain) NSString *endTime;
@property(nonatomic,retain) NSString *location;

@end


@interface RSSpaCustomerConflictingBookings : NSObject {	
	Result *spaBookingResult;
	NSMutableArray *spaBookings;	
}

@property(nonatomic,retain) Result *spaBookingResult;
@property(nonatomic,retain) NSMutableArray *spaBookings;	

@end