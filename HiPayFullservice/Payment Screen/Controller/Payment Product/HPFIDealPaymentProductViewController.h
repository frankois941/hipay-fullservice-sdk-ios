//
//  HPFIDealPaymentProductViewController.h
//  Pods
//
//  Created by HiPay on 01/11/2015.
//
//

#import "HPFForwardPaymentProductViewController.h"

@interface HPFIDealPaymentProductViewController : HPFForwardPaymentProductViewController
{
    NSDictionary *issuerBanks;
    NSString *selectedIssuerBank;
    
    UIAlertController *issuerBanksActionSheet;
}

@end
