//
//  RSGroupEventDescViewController.h
//  ResortSuite
//
//  Created by Cybage on 10/06/11.
//  Copyright 2011 ResortSuite . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSGroupEvents.h"



@interface RSGroupEventDescViewController : UIViewController {
	GroupEvent *event;
	
	UILabel *fieldLabel1;
	UILabel *fieldLabel2;
	UILabel *fieldLabel3;
	UILabel *fieldLabel4;
	
	UILabel *headerLable1;
	UILabel *headerLable2;
	UILabel *headerLable3;
	UILabel *headerLable4;
	UILabel *dotLine;
	UILabel *descLabel;

}

@property (nonatomic, retain) GroupEvent *event;

/*!
 @method		initWithGroupEvent
 @brief			Initialization of the RSGroupEvent object with the class member
 @details		--
 @param			RSGroupEvents eventObject
 @return		id
 */
-(id)initWithGroupEvent:(GroupEvent *)eventObject;

@end
