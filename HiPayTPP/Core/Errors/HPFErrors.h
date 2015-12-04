//
//  HPFErrors.h
//  Pods
//
//  Created by Jonathan TIRET on 29/09/2015.
//
//

#ifndef HPFErrors_h
#define HPFErrors_h

NSString * const HPFHiPayTPPErrorDomain;
NSString * const HPFErrorCodeHTTPOtherDescription;
NSString * const HPFErrorCodeHTTPNetworkUnavailableDescription;
NSString * const HPFErrorCodeHTTPConfigDescription;
NSString * const HPFErrorCodeHTTPConnectionFailedDescription;
NSString * const HPFErrorCodeHTTPClientDescription;
NSString * const HPFErrorCodeHTTPServerDescription;

NSString * const HPFErrorCodeHTTPPlainResponseKey;
NSString * const HPFErrorCodeHTTPParsedResponseKey;
NSString * const HPFErrorCodeHTTPStatusCodeKey;

NSString * const HPFErrorCodeAPIDescriptionKey;
NSString * const HPFErrorCodeAPIMessageKey;
NSString * const HPFErrorCodeAPICodeKey;

typedef NS_ENUM(NSInteger, HPFHTTPStatus) {
    
    HPFHTTPStatusNotFound = 404
    
};

typedef NS_ENUM(NSInteger, HPFErrorCode) {
    
    // Unknown network/HTTP error
    HPFErrorCodeHTTPOther,
    
    // Network is unavailable
    HPFErrorCodeHTTPNetworkUnavailable,
    
    // Config error (such as SSL, bad URL, etc.)
    HPFErrorCodeHTTPConfig,
    
    // The connection has been interupted
    HPFErrorCodeHTTPConnectionFailed,
    
    // HTTP client error (400)
    HPFErrorCodeHTTPClient,
    
    // HTTP client error (typically a 500 error)
    HPFErrorCodeHTTPServer,
    
    // Configuration errors (refer to the TPP API documentation appendix)
    HPFErrorCodeAPIConfiguration,
    
    // Validation errors (refer to the TPP API documentation appendix)
    HPFErrorCodeAPIValidation,
    
    // Error codes relating to the Checkout Process (refer to the TPP API documentation appendix)
    HPFErrorCodeAPICheckout,
    
    // Error codes relating to Maintenance Operations (refer to the TPP API documentation appendix)
    HPFErrorCodeAPIMaintenance,
    
    // Acquirer Reason Codes (refer to the TPP API documentation appendix)
    HPFErrorCodeAPIAcquirer,
    
    // Unknown error
    HPFErrorCodeAPIOther,
    
};

typedef NS_ENUM(NSInteger, HPFErrorAPIReason) {
    
    // Configuration errors
    HPFErrorAPIIncorrectCredentials = 1000001,
    HPFErrorAPIIncorrectSignature = 1000002,
    HPFErrorAPIAccountNotActive = 1000003,
    HPFErrorAPIAccountLocked = 1000004,
    HPFErrorAPIInsufficientPermissions = 1000005,
    HPFErrorAPIForbiddenAccess = 1000006,
    HPFErrorAPIUnsupportedVersion = 1000007,
    HPFErrorAPITemporarilyUnavailable = 1000008,
    HPFErrorAPINotAllowed = 1000009,
    HPFErrorAPIMethodNotAllowedGateway = 1010001,
    HPFErrorAPIInvalidParameter = 1010002,
    HPFErrorAPIMethodNotAllowedSecureVault = 1010003,
    HPFErrorAPIInvalidCardToken = 1012003,
    HPFErrorAPIRequiredParameterMissing = 1010101,
    HPFErrorAPIInvalidParameterFormat = 1010201,
    HPFErrorAPIInvalidParameterLength = 1010202,
    HPFErrorAPIInvalidParameterNonAlpha = 1010203,
    HPFErrorAPIInvalidParameterNonNum = 1010204,
    HPFErrorAPIInvalidParameterNonDecimal = 1010205,
    HPFErrorAPIInvalidDate = 1010206,
    HPFErrorAPIInvalidTime = 1010207,
    HPFErrorAPIInvalidIPAddress = 1010208,
    HPFErrorAPIInvalidEmailAddress = 1010209,
    HPFErrorAPIInvalidSoftDescriptorCodeMessage = 1010301,
    HPFErrorAPINoRouteToAcquirer = 1020001,
    HPFErrorAPIUnsupportedECIDescription = 1020002,
    HPFErrorAPIUnsupported = 1020003,
    
    // Validation errors
    HPFErrorAPIUnknownOrder = 3000001,
    HPFErrorAPIUnknownTransaction = 3000002,
    HPFErrorAPIUnknownMerchant = 3000003,
    HPFErrorAPIUnsupportedOperation = 3000101,
    HPFErrorAPIUnknownIPAddress = 3000102,
    HPFErrorAPISuspicionOfFraud = 3000201,
    HPFErrorAPIFraudSuspicion = 3040001,
    HPFErrorAPIUnknownToken = 3030001,
    HPFErrorAPILuhnCheckFailed = 409,
    
    // Error codes relating to the Checkout Process
    HPFErrorAPIUnsupportedCurrency = 3010001,
    HPFErrorAPIAmountLimitExceeded = 3010002,
    HPFErrorAPIMaxAttemptsExceeded = 3010003,
    HPFErrorAPIDuplicateOrder = 3010004,
    HPFErrorAPICheckoutSessionExpired = 3010005,
    HPFErrorAPIOrderCompleted = 3010006,
    HPFErrorAPIOrderExpired = 3010007,
    HPFErrorAPIOrderVoided = 3010008,
    
    // Error codes relating to Maintenance Operations
    HPFErrorAPIAuthorizationExpired = 3020001,
    HPFErrorAPIAllowableAmountLimitExceeded = 3020002,
    HPFErrorAPINotEnabled = 3020101,
    HPFErrorAPINotAllowedCapture = 3020102,
    HPFErrorAPINotAllowedPartialCapture = 3020103,
    HPFErrorAPIPermissionDenied = 3020104,
    HPFErrorAPICurrencyMismatch = 3020105,
    HPFErrorAPIAuthorizationCompleted = 3020106,
    HPFErrorAPINoMore = 3020107,
    HPFErrorAPIInvalidAmount = 3020108,
    HPFErrorAPIAmountLimitExceededCapture = 3020109,
    HPFErrorAPIAmountLimitExceededPartialCapture = 3020110,
    HPFErrorAPIOperationNotPermittedClosed = 3020111,
    HPFErrorAPIOperationNotPermittedFraud = 3020112,
    HPFErrorAPIRefundNotEnabled = 3020201,
    HPFErrorAPIRefundNotAllowed = 3020202,
    HPFErrorAPIPartialRefundNotAllowed = 3020203,
    HPFErrorAPIRefundPermissionDenied = 3020204,
    HPFErrorAPIRefundCurrencyMismatch = 3020205,
    HPFErrorAPIAlreadyRefunded = 3020206,
    HPFErrorAPIRefundNoMore = 3020207,
    HPFErrorAPIRefundInvalidAmount = 3020208,
    HPFErrorAPIRefundAmountLimitExceeded = 3020209,
    HPFErrorAPIRefundAmountLimitExceededPartial = 3020210,
    HPFErrorAPIOperationNotPermitted = 3020211,
    HPFErrorAPITooLate = 3020212,
    HPFErrorAPIReauthorizationNotEnabled = 3020301,
    HPFErrorAPIReauthorizationNotAllowed = 3020302,
    HPFErrorAPICannotReauthorize = 3020303,
    HPFErrorAPIMaxLimitExceeded = 3020304,
    HPFErrorAPIVoidNotAllowed = 3020401,
    HPFErrorAPICannotVoid = 3020402,
    HPFErrorAPIAuthorizationVoided = 3020403,
    
    // Acquirer Reason Codes
    HPFErrorAPIDeclinedAcquirer = 4000001,
    HPFErrorAPIDeclinedFinancialInstituion = 4000002,
    HPFErrorAPIInsufficientFundsAccount = 4000003,
    HPFErrorAPITechnicalProblem = 4000004,
    HPFErrorAPICommunicationFailure = 4000005,
    HPFErrorAPIAcquirerUnavailable = 4000006,
    HPFErrorAPIDuplicateTransaction = 4000007,
    HPFErrorAPIPaymentCancelledByTheCustomer = 4000008,
    HPFErrorAPIInvalidTransaction = 4000009,
    HPFErrorAPIPleaseCallTheAcquirerSupportCallNumber = 4000010,
    HPFErrorAPIAuthenticationFailedPleaseRetryOrCancel = 4000011,
    HPFErrorAPINoUIDConfiguredForThisOperation = 4000012,
    HPFErrorAPIRefusalNoExplicitReason = 4010101,
    HPFErrorAPIIssuerNotAvailable = 4010102,
    HPFErrorAPIInsufficientFundsCredit = 4010103,
    HPFErrorAPITransactionNotPermitted = 4010201,
    HPFErrorAPIInvalidCardNumber = 4010202,
    HPFErrorAPIUnsupportedCard = 4010203,
    HPFErrorAPICardExpired = 4010204,
    HPFErrorAPIExpiryDateIncorrect = 4010205,
    HPFErrorAPICVCRequired = 4010206,
    HPFErrorAPICVCError = 4010207,
    HPFErrorAPIAVSFailed = 4010301,
    HPFErrorAPIRetainCard = 4010302,
    HPFErrorAPILostOrStolenCard = 4010303,
    HPFErrorAPIRestrictedCard = 4010304,
    HPFErrorAPICardLimitExceeded = 4010305,
    HPFErrorAPICardBlacklisted = 4010306,
    HPFErrorAPIUnauthorisedIPAddressCountry = 4010307,
    HPFErrorAPICardnotInAuthorisersDatabase = 4010309,
};


#endif /* HPFErrors_h */
