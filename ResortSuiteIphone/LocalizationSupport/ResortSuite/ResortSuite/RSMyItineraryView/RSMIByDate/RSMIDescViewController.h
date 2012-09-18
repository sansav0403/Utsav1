//
//  RSMIDescViewController.h
//  ResortSuite
//
//  Created by Cybage on 15/06/11.
//  Copyright 2011 ResortSuite . All rights reserved.
//
/*
 ===========================================================================
 DESCRIPTION:
 *class to display the description of the selected event.
 
 ================================================================================
 */
#import <UIKit/UIKit.h>
#import "RSFolio.h"

@interface RSMIDescViewController : UIViewController {
	
	RSFolio *folio;
	UILabel *locationLabel;		//only for hotel location
	UILabel *fieldLabel1;
	UILabel *fieldLabel2;
	UILabel *fieldLabel3;
	UILabel *fieldLabel4;
	UILabel *fieldLabel5;
	
	UILabel *headerLable1;
	UILabel *headerLable2;
	UILabel *headerLable3;
	UILabel *headerLable4;
	UILabel *headerLable5;
	UILabel *dotLine;
}
@property (nonatomic, retain) RSFolio *folio;

/*!
 @method		initWithFolio
 @brief			initialize the folio property with the paramater
 @details		-
 @param			(RSFolio *)rsFolio;
 @return		id
 */
-(id)initWithFolio:(RSFolio *)rsFolio;
@end
