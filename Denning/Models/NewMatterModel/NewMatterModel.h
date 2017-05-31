//
//  NewMatterModel.h
//  Denning
//
//  Created by Ho Thong Mee on 26/05/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import <Foundation/Foundation.h>

@class StaffModel;
@interface NewMatterModel : NSObject
@property (strong, nonatomic) NSString * _Nullable MRTA;
@property (strong, nonatomic) NSString *_Nullable ODLoan;
@property (strong, nonatomic) NSString *_Nullable attest1;
@property (strong, nonatomic) NSString *_Nullable attest2;
@property (strong, nonatomic) NSString *_Nullable attest3;
@property (strong, nonatomic) NSString *_Nullable balanceDeposit;
@property (strong, nonatomic) NSString *_Nullable balancePurchasePrice;
@property (strong, nonatomic) NSString *_Nullable bank1;
@property (strong, nonatomic) NSString *_Nullable bank1PAName;
@property (strong, nonatomic) NSString *_Nullable bank1PresentationNo;
@property (strong, nonatomic) NSString *_Nullable bank1Reference;
@property (strong, nonatomic) NSString *_Nullable bank2;
@property (strong, nonatomic) NSString *_Nullable bank2InstructionDate;
@property (strong, nonatomic) NSString *_Nullable bank2LetterOfferDate;
@property (strong, nonatomic) NSString *_Nullable bank2PAName;
@property (strong, nonatomic) NSString *_Nullable bank2Reference;
@property (strong, nonatomic) NSString *_Nullable billingCode;
@property (strong, nonatomic) NSString *_Nullable borrower;
@property (strong, nonatomic) NSString *_Nullable branch;
@property (strong, nonatomic) NSString *_Nullable checklistCode;

@property (strong, nonatomic) StaffModel*_Nullable  clerk;
@property (strong, nonatomic) NSString *_Nullable dateOpen;
@property (strong, nonatomic) NSString *_Nullable earnestDeposit;
@property (strong, nonatomic) NSString *_Nullable entereddBy;
@property (strong, nonnull) CodeDescription * fileStatus;

@property (strong, nonatomic) NSString *_Nullable financingType;
@property (strong, nonatomic) NSString *_Nullable guarantor;
@property (strong, nonatomic) NSString *_Nullable interestRateOD;
@property (strong, nonatomic) NSString *_Nullable interestRateTL;
@property (strong, nonatomic) NSString *_Nullable isLoanIncludeLegalFee;
@property (strong, nonatomic) NSString *_Nullable isLoanIncludeMRTA;
@property (strong, nonatomic) NSString *_Nullable isLoanIncludeOther;
@property (strong, nonatomic) NSString *_Nullable isRepresentBank2;
@property (strong, nonatomic) NSString *_Nullable legalAssistant;
@property (strong, nonatomic) NSString *_Nullable legalFee;
@property (strong, nonatomic) NSString *_Nullable loanType;
@property (strong, nonatomic) NSString *_Nullable locationBox;
@property (strong, nonatomic) NSString *_Nullable locationPhysical;
@property (strong, nonatomic) NSString *_Nullable locationPocket;
@property (strong, nonatomic) NSString *_Nullable manualNo;
@property (strong, nonatomic) MatterCodeModel *_Nullable matter;
@property (strong, nonatomic) NSString *_Nullable monthlyInstallment;
@property (strong, nonatomic) NSString *_Nullable other;
@property (strong, nonatomic) ClientModel* _Nullable partner;
@property (strong, nonatomic) ClientModel* _Nullable primaryClient;

@property (strong, nonatomic) NSString * _Nullable property;
@property (strong, nonatomic) NSString * _Nullable purchasePrice;
@property (strong, nonatomic) NSString * _Nullable purchaser;
@property (strong, nonatomic) NSString * _Nullable referenceNo;
@property (strong, nonatomic) NSString * _Nullable remarks;
@property (strong, nonatomic) NSString * _Nullable repaymentPeriod;
@property (strong, nonatomic) NSString * _Nullable systemNo;
@property (strong, nonatomic) NSString * _Nullable termLoan;
@property (strong, nonatomic) NSString * _Nullable totalDeposit;
@property (strong, nonatomic) NSString * _Nullable totalLoan;
@property (strong, nonatomic) NSString * _Nullable turnAround;
@property (strong, nonatomic) NSString * _Nullable updatedBy;
@property (strong, nonatomic) NSString * _Nullable vendor;

+ (NewMatterModel*_Nullable) getNewMatter: (NSDictionary*_Nullable) response;

+ (NSArray*_Nullable) getNewMatterArray: (NSDictionary*_Nullable) response;
@end
