//
//  RSSpaService.h
//  ResortSuite
//
//  Created by Cybage on 9/5/11.
//  Copyright 2011 Resort Suite. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RSFolio.h"

@interface RSSpaServices : NSObject {
    
    NSMutableArray *spaServices;
    Result *spaServiceResult;
}
@property(nonatomic,retain) NSMutableArray *spaServices;
@property(nonatomic,retain) Result *spaServiceResult;

@end


@interface RSSpaService : NSObject

{
    int spaItemID;
    int location;
    NSString *itemName;
    NSString *itemDesc;
    NSString *clientInstruction;    //new addition
    float price;
    int serviceTime;
    BOOL sameGender;
    
    NSString *itemCategory;
    NSString *itemSubCategory;
}

@property(nonatomic) int spaItemID;
@property(nonatomic) int location;
@property(nonatomic,copy) NSString *itemName;
@property(nonatomic,copy) NSString *itemDesc;
@property(nonatomic,copy) NSString *clientInstruction;    //new addition
@property(nonatomic) float price;
@property(nonatomic) int serviceTime;
@property(nonatomic) BOOL sameGender;

@property(nonatomic,copy) NSString *itemCategory;
@property(nonatomic,copy) NSString *itemSubCategory;
/*
 @method        doesTheStringExitsInTheObject
 @brief			check if the search string string exists in the object.
 @details		
 @param			(NSString *) string
 @return        (BOOL)
 */
-(BOOL)doesTheStringExitsInTheObject:(NSString *)string;

@end
