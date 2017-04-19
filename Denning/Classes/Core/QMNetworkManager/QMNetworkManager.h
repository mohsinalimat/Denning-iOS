//
//  QMNetworkManager.h
//  reach-ios
//
//  Created by Admin on 2016-11-30.
//  Copyright © 2016 Quickblox. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^CompletionHandler)(BOOL success, id response, NSError *error);

@class UserModel;
@class NewsModel;
@class EventModel;
@class PropertyModel;
@class ContactModel;
@class RelatedMatterModel;
@class BankModel;
@class LegalFirmModel;
@class GovOfficeModel;
@class LedgerModel;
@class LedgerDetailModel;
@class DocumentModel;

@interface QMNetworkManager : NSObject

@property(nonatomic, strong) AFHTTPSessionManager  *manager;


@property (strong, atomic) NSString       *installDate;
@property (strong, atomic) NSString       *installDateTemp;
@property (assign) CLLocationCoordinate2D     oldLocation;
@property(strong, atomic) NSString       *countryName;
@property(strong, nonatomic) NSString       *cityName;
@property(strong, atomic) NSString       *stateName;
@property (strong, atomic) NSNumber      *invalidTry;
@property (strong, atomic) NSDate       *startTrackTimeForLogin;

@property (strong, nonatomic) NSString* ipWAN;
@property (strong, nonatomic) NSString* ipLan;
@property (strong, nonatomic) NSString* os;
@property (strong, nonatomic) NSString* device;
@property (strong, nonatomic) NSString* deviceName;
@property (strong, nonatomic) NSString* MAC;

@property(nonatomic, strong) UserModel*     myProfile;

@property (nonatomic, strong) NSString* selectedBaseURLForGeneral;

+ (QMNetworkManager *)sharedManager;

/*
 ******** Auth *********
 */

/*
 *  Sign In
 *   
 *  @param: username
 *  @param: email
 */

-(void) userSignInWithEmail: (NSString*)email password:(NSString*) password withCompletion:(void(^)(BOOL success, NSString* error , NSInteger statusCode, NSDictionary* responseObject)) completion;

/*
 *  Request SMS for New Device
 *  @param: email
 *  @param: activation code
 */
//
//- (void) sendSMSNewDeviceWithEmail: (NSString*) email activationCode: (NSNumber*) activationCode withCompletion:(void(^)(BOOL success, NSString* error , NSInteger statusCode)) completion;

/*
 *  Forget Password
 *    1.  Request SMS
 *  @param: email
 *  @param: phone number
 *  @param: reason
 */

- (void) sendSMSForgetPasswordWithEmail: (NSString*) email phoneNumber: (NSString*) phoneNumber reason:(NSString*) reason withCompletion:(void(^)(BOOL success, NSInteger statusCode, NSString* error, NSDictionary* response)) completion;

- (void) sendSMSRequestWithEmail: (NSString*) email phoneNumber: (NSString*) phoneNumber reason:(NSString*) reason withCompletion:(void(^)(BOOL success, NSInteger statusCode, NSString* error, NSDictionary* response)) completion;

- (void) sendSMSForNewDeviceWithEmail: (NSString*) email activationCode: (NSString*) activationCode withCompletion: (void(^)(BOOL success, NSInteger statusCode, NSString* error, NSDictionary* response)) completion;

/*
 *  Forget Password
 *  @param: email
 *  @param: phone number
 *  @param: activationCode
 */

- (void) requestForgetPasswordWithEmail: (NSString*) email phoneNumber:(NSString*) phoneNumber activationCode: (NSString*) activationCode withCompletion:(void(^)(BOOL success, NSString* error)) completion;

/*
 *  Change Pasword
 *
 *  @param: email
 *  @param: password
 */

- (void) changePasswordAfterLoginWithEmail: (NSString*) email password: (NSString*) password withCompletion: (void(^)(BOOL success, NSString* error, NSDictionary* response)) completion;

/*
 *  Get Firm List
 */

- (void) getFirmListWithPage: (NSNumber*) page completion: (void(^)(NSArray* resultArray, NSError* error)) completion;

/*
 *  Secondary Log in
 */

// Denning Login

-(void) denningSignIn:(NSString*) password withCompletion:(void(^)(BOOL success, NSString* error, NSDictionary* responseObject)) completion;

// client login
- (void) clientSignIn: (NSString*) url password: (NSString*) password withCompletion: (void(^)(BOOL success, NSString* error,  DocumentModel* doumentModel)) completion;


/*
 *      Sign up
 *
 *  @param: username
 *  @param: phone
 *  @param: email
 *  @param: password
 *  @param: isLayer
 *  @param: firmCode
 *  @param: ipWan
 *  @param: ipLan
 *  @param: os
 *  @param: device
 *  @param: deviceName
 */

- (void) userSignupWithUsername:(NSString*) username phone:(NSString*) phone email:(NSString*) email isLayer:(NSNumber*) isLayer firmCode: (NSNumber*) firmCode withCompletion:(void(^)(BOOL success, NSString* error)) completion;

// Home Search

- (void) getGlobalSearchFromKeyword: (NSString*) keyword searchURL:(NSString*)searchURL forCategory:(NSInteger)category searchType:(NSString*)searchType withCompletion:(void(^)(NSArray* resultArray, NSError* error)) completion;

// Updates
- (void) getLatestUpdatesWithCompletion: (void(^)(NSArray* updatesArray, NSError* error)) completion;
// News

- (void) getLatestNewsWithCompletion: (void(^)(NSArray* newsArray, NSError* error)) completion;

// Event

- (void) getLatestEventWithCompletion: (void(^)(NSArray* eventsArray, NSError* error)) completion;

// Property

- (void) loadPropertyfromSearchWithCode: (NSString*) code completion: (void(^)(PropertyModel* propertyModel, NSError* error)) completion;

// Contact
- (void) loadContactFromSearchWithCode: (NSString*) code completion: (void(^)(ContactModel* contactModel, NSError* error)) completion;

// Bank
- (void) loadBankFromSearchWithCode: (NSString*) code completion: (void(^)(BankModel* bankModel, NSError* error)) completion;

// Government Offices
- (void) loadGovOfficesFromSearchWithCode: (NSString*) code type:(NSString*) type completion: (void(^)(GovOfficeModel* govOfficeModel, NSError* error)) completion;

// Related Matter
- (void) loadRelatedMatterWithCode: (NSString*) code completion: (void(^)(RelatedMatterModel* contactModel, NSError* error)) completion;

// Legal firm (Solicitor)
- (void) loadLegalFirmWithCode: (NSString*) code completion: (void(^)(LegalFirmModel* legalFirmModel, NSError* error)) completion;

// Ledger
- (void) loadLedgerWithCode: (NSString*) code completion: (void(^)(NSArray* ledgerModelArray, NSError* error)) completion;

// Ledger detail
- (void) loadLedgerDetailWithCode: (NSString*) code accountType:(NSString*)accountType completion: (void(^)(NSArray* ledgerDetailModelArray, NSError* error)) completion;

// Document
- (void) loadDocumentWithCode: (NSString*) code completion: (void(^)(DocumentModel* doumentModel, NSError* error)) completion;


/*
 * Chat
 */

// Get the contacts
- (void) getChatContactsWithCompletion:(void(^)(void)) completion;

- (void) addFavoriteContact: (QBUUser*) user withCompletion:(void(^)(NSError* error)) completion;

- (void) removeFavoriteContact: (QBUUser*) user withCompletion:(void(^)(NSError* error)) completion;


@end

NS_ASSUME_NONNULL_END
