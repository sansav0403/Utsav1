//
//  RSMIDescriptionVC.h
//  ResortSuite
//
//  Created by Cybage on 2/1/12.
//  Copyright (c) 2012 ResortSuite. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSConfirmationBaseClass.h"
#import "RSFolio.h"

@interface RSMIDescriptionVC : RSConfirmationBaseClass
{
    RSFolio *folio;
    
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
