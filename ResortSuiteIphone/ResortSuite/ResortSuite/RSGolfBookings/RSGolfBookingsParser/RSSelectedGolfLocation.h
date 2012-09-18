//
//  RSSelectedGolfLocation.h
//  ResortSuite
//
//  Created by Cybage on 10/7/11.
//  Copyright 2011 ResortSuite. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSGolfLocations.h"

@interface RSSelectedGolfLocation : NSObject {
    
    RSGolfLocation *golfLocation;       //Need to store the selected spa location
}
@property (nonatomic,retain) RSGolfLocation *golfLocation;

/*!
 @method		sharedInstance
 @brief			Singleton instance
 @details		....
 @param			nil
 @return		RSSelectedGolfLocation class object
 */

+(RSSelectedGolfLocation *)sharedInstance;

@end
