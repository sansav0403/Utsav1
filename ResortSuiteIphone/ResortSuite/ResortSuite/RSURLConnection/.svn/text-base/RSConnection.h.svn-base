//
//  RSConnection.h
//  ResortSuite
//
//  Created by Cybage on 26/05/11.
//  Copyright 2011 ResortSuite . All rights reserved.
//

#import <Foundation/Foundation.h>
//This delegate has to be included where ever a web service call has to be done.
@protocol RSConnectionHandlerDelegate

/*!
 @method		Its a protocol method that is non optional.
 @brief			This delegate has to be included where ever a web service call has to be done.
 @details		Inclusion of this delgate will allow the caller to get the response of connectiondidfinishloading
				if the response is received.
 @param			dataFromWS: this will contain the response data received from successful hit of web service.
 @return		void
 */
-(void)responseReceived:(NSMutableData*)dataFromWS;

@end

@interface RSConnection : NSObject {

    NSMutableData *receivedData;
    id <RSConnectionHandlerDelegate> delegate;
	
	NSString *wsdlPath;
	
	BOOL isErrorAlertShown;
}
@property (nonatomic,assign) id <RSConnectionHandlerDelegate> delegate; //prev retain
@property (nonatomic,retain) NSMutableData *receivedData;
/*!
 @method		sharedInstance
 @brief			Singleton instance of connection class
 @details		....
 @param			nil
 @return		Connection class object
 */

+(RSConnection *)sharedInstance;

/*!
@method			postDataToServer
@brief		    Invoking the webservice
@details		Form the url string and make the connection to the Web Service and get the data
@param			nil
@return		void
*/
-(void)postDataToServer:(NSString *)soapMessage;

/*!
 @method		showErrorAlert
 @brief		    Show Error Alert after time interval of 10 sec that the server not reachable
 @details		nil
 @param			nil
 @return		void
 */
-(void) showErrorAlert;


@end
