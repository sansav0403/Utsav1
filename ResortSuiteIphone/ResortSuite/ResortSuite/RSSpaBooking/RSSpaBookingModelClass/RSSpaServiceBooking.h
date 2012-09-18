//
//  RSSpaServiceBooking.h
//  ResortSuite
//
//  Created by Cybage on 17/10/11.
//  Copyright 2011 ResortSuite. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RSFolio.h"

@interface RSSpaServiceBooking : NSObject {

	Result *serviceBookingResult;
	NSString *spaFolioId;
	NSString *spaFolioItemId;
}

@property(nonatomic, retain) Result *serviceBookingResult;
@property(nonatomic, retain) NSString *spaFolioId;
@property(nonatomic, retain) NSString *spaFolioItemId;

@end
