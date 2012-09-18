//
//  RSSpaServiceDescVC.h
//  ResortSuite
//
//  Created by Cybage on 9/28/11.
//  Copyright 2011 Resort Suite. All rights reserved.
//
/*
 ===========================================================================
 DESCRIPTION:
 Child class of RSConfirmationBaseClass to implement the comman function in the confirmation view.
 * Create the dynamic description taking only the space it rewuires on the screen.
 * All the label adjust them self according the label text length.
 * describes the selected service details
 ================================================================================
 */

#import <UIKit/UIKit.h>
#import "RSConfirmationBaseClass.h"
#import "RSSpaService.h"

@interface RSSpaServiceDescVC : RSConfirmationBaseClass
{
    RSSpaService *selectedService;
    
}
@property(nonatomic, retain) RSSpaService *selectedService;
/*!
 @method		initWithSelectedService
 @brief		    init With Selected Service
 @details		....
 @param			-
 @return		id
 */ 
-(id)initWithSelectedService:(RSSpaService *)selSerivce;
/*!
 @method		AddSelectButton
 @brief		    Add Select Button
 @details		....
 @param			-
 @return		void
 */ 
-(void)AddSelectButton;
@end
