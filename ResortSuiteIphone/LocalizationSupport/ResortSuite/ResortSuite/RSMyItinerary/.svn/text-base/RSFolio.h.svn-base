//
//  RSFolio.h
//  ResortSuite
//
//  Created by Cybage on 30/05/11.
//  Copyright 2011 ResortSuite . All rights reserved.
//

#import <Foundation/Foundation.h>

enum ResultValue {
	FAIL,
	SUCCESS
};

enum AppType {
	Hotel,
	Spa,
	Golf, 
	Dining, 
	Transportation 
};

enum Salutation {
	Mr,
	Ms,
	Mrs,
	Miss,
	Dr,
	MrMrs
};

@interface Result : NSObject
{
	enum ResultValue resultValue;
	NSString *resultText;
    int ErrorID;
}
@property (nonatomic) enum ResultValue resultValue;
@property (nonatomic, copy) NSString *resultText;
@property (nonatomic) int ErrorID;
@end


@interface Customer : NSObject
{
	int customerId;
	enum Salutation salutation;
	NSString *firstName;
	NSString *lastName;
}
@property (nonatomic) int customerId;
@property (nonatomic) enum Salutation salutation;
@property (nonatomic, copy) NSString *firstName;
@property (nonatomic, copy) NSString *lastName;

@end



@interface RSFolio : NSObject {

	enum AppType appType;
	
	int appFolioId;

	NSString *location;
	Customer *customer;	
	
	NSString *startDate;
	NSString *finishDate;
	NSDate *formatedStartDate;
	NSDate *formatedFinishDate;
	
	NSString *details;
	NSString *netAmount;
	NSString *grossAmount;
	
}

@property (nonatomic) enum AppType appType;

@property (nonatomic) int appFolioId;

@property (nonatomic, copy) NSString *location;
@property (nonatomic, retain) Customer *customer;

@property (nonatomic, copy) NSString *startDate;
@property (nonatomic, copy) NSString *finishDate;

@property (nonatomic, retain) NSDate *formatedStartDate;
@property (nonatomic, retain) NSDate *formatedFinishDate;

@property (nonatomic, copy) NSString *details;
@property (nonatomic, copy) NSString *netAmount;
@property (nonatomic, copy) NSString *grossAmount;

@end


@interface HotelFolio : RSFolio {
	int groupFolioId;
	int numAdults;
	int numYouth;
	int numChildren;
	int totalGuests;
		
	NSString *roomNumber;	
	NSString *roomType;
	NSString *rateType;
	NSString *rateDescription;	
	NSString *deposit;
	
	NSString *balanceDue;
}

@property (nonatomic) int groupFolioId;
@property (nonatomic) int numAdults;
@property (nonatomic) int numYouth;
@property (nonatomic) int numChildren;
@property (nonatomic) int totalGuests;

@property (nonatomic, copy) NSString *roomNumber;	
@property (nonatomic, copy) NSString *roomType;
@property (nonatomic, copy) NSString *rateType;
@property (nonatomic, copy) NSString *rateDescription;
@property (nonatomic, copy) NSString *deposit;
@property (nonatomic, copy) NSString *balanceDue;

@end



@interface SpaFolio	: RSFolio {	
	NSString *room;	
	NSString *staff;    //add client instruction and descrition
    NSString *spaDescription;
    NSString *clientInstruction;
}
@property (nonatomic, copy) NSString *room;
@property (nonatomic, copy) NSString *staff;
@property (nonatomic, copy) NSString *spaDescription;
@property (nonatomic, copy) NSString *clientInstruction;

@end
