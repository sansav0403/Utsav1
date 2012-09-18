//
//  RSSelectedSpaLocation.h
//  ResortSuite
//
//  Created by Cybage on 29/09/11.
//  Copyright 2011 ResortSuite. All rights reserved.
//
/*
 ===========================================================================
 DESCRIPTION:
Singleton class to store the selected spa location throughtout the booking process

 ================================================================================
 */

#import <Foundation/Foundation.h>
#import "RSSpaLocation.h"

@interface RSSelectedSpaLocation : NSObject {

	RSSpaLocation *spaLocation;		//Need to store the selected spa location
}

@property (nonatomic,retain) RSSpaLocation *spaLocation;

/*!
 @method		sharedInstance
 @brief			Singleton instance
 @details		....
 @param			nil
 @return		RSSelectedSpaLocation class object
 */

+(RSSelectedSpaLocation *)sharedInstance;


@end