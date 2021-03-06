//
//  SecureVaultClient.m
//  Pods
//
//  Created by HiPay on 01/10/2015.
//
//

#import "HPFSecureVaultClient.h"
#import "HPFAbstractClient+Private.h"
#import "HPFLogger.h"
#import "HPFFormatter.h"
#import "HPFStats.h"
#import "HPFMonitoring.h"

@interface HPFSecureVaultClient ()
{
    HPFHTTPClient *HTTPClient;
    HPFClientConfig *clientConfig;
}

@end

@implementation HPFSecureVaultClient

+ (instancetype)sharedClient
{
    static dispatch_once_t once;
    static id sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (instancetype)initWithHTTPClient:(HPFHTTPClient *)theHTTPClient clientConfig:(HPFClientConfig *)theClientConfig
{
    self = [super init];
    if (self) {
        HTTPClient = theHTTPClient;
        clientConfig = theClientConfig;
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        HTTPClient = [HPFSecureVaultClient createClient];
        clientConfig = [HPFClientConfig sharedClientConfig];
    }
    return self;
}

+ (HPFHTTPClient *)createClient
{
    NSString *baseURL;
    NSString *newBaseURL;
    
    switch ([HPFClientConfig sharedClientConfig].environment) {
        case HPFEnvironmentProduction:
            baseURL = HPFSecureVaultClientBaseURLProduction;
            newBaseURL = HPFSecureVaultClientNewBaseURLProduction;
            break;
            
        case HPFEnvironmentStage:
            baseURL = HPFSecureVaultClientBaseURLStage;
            newBaseURL = HPFSecureVaultClientNewBaseURLStage;
            break;
    }
    
    return [[HPFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:baseURL] newBaseURL:[NSURL URLWithString:newBaseURL] username:[HPFClientConfig sharedClientConfig].username password:[HPFClientConfig sharedClientConfig].password];

}

- (HPFPaymentCardToken *)paymentCardTokenWithData:(NSDictionary *)rawData
{
    return [[HPFPaymentCardTokenMapper alloc] initWithRawData:rawData].mappedObject;
}

- (id<HPFRequest>)generateTokenWithCardNumber:(NSString *)cardNumber cardExpiryMonth:(NSString *)cardExpiryMonth cardExpiryYear:(NSString *)cardExpiryYear cardHolder:(NSString *)cardHolder securityCode:(NSString *)securityCode multiUse:(BOOL)multiUse andCompletionHandler:(HPFSecureVaultClientCompletionBlock)completionBlock
{
    if (securityCode == nil) {
        securityCode = @"";
    }
    
    NSDictionary *parameters = @{
                                 @"card_number": cardNumber,
                                 @"card_expiry_month": cardExpiryMonth,
                                 @"card_expiry_year": cardExpiryYear,
                                 @"card_holder": cardHolder,
                                 @"cvc": securityCode,
                                 @"multi_use": @(multiUse).stringValue,
                                 };
    
    return [HTTPClient performRequestWithMethod:HPFHTTPMethodPost v2:YES path:@"token/create" parameters:parameters completionHandler:^(HPFHTTPResponse *response, NSError *error) {
        
        if (!error) {
            if (!HPFStats.current) {
                HPFStats.current = [HPFStats new];
            }
            HPFStats.current.event = HPFEventTokenize;
            
            HPFPaymentCardToken *cardToken = [self paymentCardTokenWithData:response.body];
            HPFStats.current.paymentMethod = cardToken.brand.lowercaseString;
            HPFStats.current.cardCountry = cardToken.country;
            HPFStats.current.status = nil;
            HPFStats.current.transactionID = nil;

            HPFMonitoring *monitoring = [HPFMonitoring new];
            monitoring.payDate = [NSDate new];
            HPFStats.current.monitoring = monitoring;
   
            [HPFStats.current send];
        }
        
        [self manageRequestWithHTTPResponse:response error:error andCompletionHandler:completionBlock];
        
    }];
}

- (id<HPFRequest>)generateTokenWithApplePayToken:(NSString *)applePayToken privateKeyPassword:(NSString *)privateKeyPassword andCompletionHandler:(HPFSecureVaultClientCompletionBlock)completionBlock
{
    NSDictionary *parameters = @{
            @"apple_pay_token": applePayToken,
            @"private_key_pass":privateKeyPassword
    };

    return [HTTPClient performRequestWithMethod:HPFHTTPMethodPost v2:YES path:@"apple-pay/token.json" parameters:parameters completionHandler:^(HPFHTTPResponse *response, NSError *error) {

        [self manageRequestWithHTTPResponse:response error:error andCompletionHandler:completionBlock];

    }];
}

- (id<HPFRequest>)updatePaymentCardWithToken:(NSString *)token requestID:(NSString *)requestID setCardExpiryMonth:(NSString *)cardExpiryMonth cardExpiryYear:(NSString *)cardExpiryYear cardHolder:(NSString *)cardHolder completionHandler:(HPFSecureVaultClientCompletionBlock)completionBlock
{
    NSDictionary *parameters = @{
                                 @"request_id": requestID,
                                 @"token": token,
                                 @"card_expiry_month": cardExpiryMonth,
                                 @"card_expiry_year": cardExpiryYear,
                                 @"card_holder": cardHolder,
                                 };
    
    return [HTTPClient performRequestWithMethod:HPFHTTPMethodPost v2:YES path:@"token/update" parameters:parameters completionHandler:^(HPFHTTPResponse *response, NSError *error) {
        
        [self manageRequestWithHTTPResponse:response error:error andCompletionHandler:completionBlock];
        
    }];
}

- (id<HPFRequest>)lookupPaymentCardWithToken:(NSString *)token requestID:(NSString *)requestID completionHandler:(HPFSecureVaultClientCompletionBlock)completionBlock
{
    NSDictionary *parameters = @{@"request_id": requestID};
    
    return [HTTPClient performRequestWithMethod:HPFHTTPMethodGet v2:YES path:[@"token/" stringByAppendingString:token] parameters:parameters completionHandler:^(HPFHTTPResponse *response, NSError *error) {
        
        [self manageRequestWithHTTPResponse:response error:error andCompletionHandler:completionBlock];
        
    }];
}

- (void)manageRequestWithHTTPResponse:(HPFHTTPResponse *)response error:(NSError *)error andCompletionHandler:(HPFSecureVaultClientCompletionBlock)completionBlock
{
    if (completionBlock != nil) {
        
        NSError *resultError = nil;
        HPFPaymentCardToken *resultObject = nil;
        
        if (error == nil) {
            HPFPaymentCardToken *newToken = [self paymentCardTokenWithData:response.body];

            if (newToken != nil) {
                resultObject = newToken;
            } else {
                resultError = [NSError errorWithDomain:HPFHiPayFullserviceErrorDomain code:HPFErrorCodeAPIOther userInfo:@{NSLocalizedFailureReasonErrorKey: @"Malformed server response"}];
            }
        } else {
            resultError = [self errorForResponseBody:response.body andError:error];
        }
        
        if (resultError != nil) {
            [HPFFormatter logFromError:resultError client:@"<SecureVault>"];
        }
        
        if ([NSThread isMainThread]) {
            completionBlock(resultObject, resultError);
        }
        else {
            dispatch_async(dispatch_get_main_queue(), ^{
                completionBlock(resultObject, resultError);
            });
        }
    }
}

@end
