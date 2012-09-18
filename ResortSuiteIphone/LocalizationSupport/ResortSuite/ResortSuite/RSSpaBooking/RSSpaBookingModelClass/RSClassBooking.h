//
//  RSClassBooking.h
//  ResortSuite
//
//  Created by Cybage on 9/5/11.
//  Copyright 2011 Resort Suite. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RSFolio.h"

@interface RSSpaFolioItem : NSObject {
    
    int spaFolioItemId;
    NSDate *bookStartTime;
}

@property(nonatomic) int spaFolioItemId;
@property(nonatomic, retain) NSDate *bookStartTime;
@end


@interface RSClassBooking : NSObject {
    
    Result *classBookingResult;
    RSSpaFolioItem *spaFolioItem;
}

@property(nonatomic, retain) Result *classBookingResult;
@property(nonatomic, retain) RSSpaFolioItem *spaFolioItem;

@end

