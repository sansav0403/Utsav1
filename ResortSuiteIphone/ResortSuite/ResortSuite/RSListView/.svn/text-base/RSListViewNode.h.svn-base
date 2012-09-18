//
//  RSListViewNode.h
//  ResortSuite
//
//  Created by Cybage on 27/07/11.
//  Copyright 2011 ResortSuite. All rights reserved.
//
/*
 ===========================================================================
 DESCRIPTION:
this class reperent the node in the olist file for listview
 
 ================================================================================
 */
#import <Foundation/Foundation.h>


@interface RSListViewNode : NSObject {
	NSString *nodeTitle;
	NSString *nodeHeader_Image;
	NSString *nodeIcon_Image;
	NSArray *nodeDictionaryArray;
}
@property (nonatomic, retain) NSString *nodeTitle;
@property (nonatomic, retain) NSString *nodeHeader_Image;
@property (nonatomic, retain) NSArray *nodeDictionaryArray;
@property (nonatomic, retain) NSString *nodeIcon_Image;

/*!
 @method		initWithTitle
 @brief		    Create an instance of the list view with title, Thumbnail and header image name, with list of the array for next node.
 @details		
 @param			(NSString *)title, (NSString *)imgName, (NSString *)iconName, (NSArray *)nodeArray
 @return		id
 */

-(id)initWithTitle:(NSString *)title HeaderImage:(NSString *)imgName IConImage:(NSString *)iconName NodeArray:(NSArray *)nodeArray;
@end
