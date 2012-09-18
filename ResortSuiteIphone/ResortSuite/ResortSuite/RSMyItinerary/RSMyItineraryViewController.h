//
//  RSMyItineraryViewController.h
//  ResortSuite
//
//  Created by Amit Jain on 01/06/11.
//  Copyright 2011 Cybage. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSParseBase.h"
#import "RSConnection.h"

@interface RSMyItineraryViewController : UIViewController <RSParserHandlerDelegate,RSConnectionHandlerDelegate> {
    RSMyItineraryParser *parserItineraryObj ;
}

@property (nonatomic,retain)RSMyItineraryParser *parserItineraryObj ;
/*!
 @method		getItinerary
 @brief		    Fetch the Itinerary
 @details		Form the soap message string and make the connection to the Web Service and get the data
 @param			In paramaters: PMSFolioId, guestPin
 Out parameter: Nil
 @returns		void
 */
-(void) getItinerary:(NSString *) PMSFolioId GuestPin:(NSString *) guestPin;

@end
