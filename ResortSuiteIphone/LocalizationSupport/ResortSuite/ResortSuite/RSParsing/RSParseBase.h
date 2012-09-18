//
//  RSParseBase.h
//  ResortSuite
//
//  Created by Cybage on 01/06/11.
//  Copyright 2011 ResortSuite . All rights reserved.
//

#import <Foundation/Foundation.h>

//This protocol will be implemented by each view controller of respective parsers.
@protocol RSParserHandlerDelegate

/*!
 @method		parsingComplete
 @brief			Delegate method to be implemented by each class using this protocol and will receive model
                data for respective parsed class.                
 @param 		id parserModelData
 @return		void
 */

-(void)parsingComplete:(id)parserModelData; 

@end

@interface RSParseBase : NSObject {
    
    id <RSParserHandlerDelegate> delegate; 
    
}

@property (nonatomic,assign)id<RSParserHandlerDelegate> delegate; //prev retain

/*
 @method		parse
 @brief			subclasses will override this method 
 @param			NSData
 @return		none
 */
- (void) parse:(NSData*)data;

@end
