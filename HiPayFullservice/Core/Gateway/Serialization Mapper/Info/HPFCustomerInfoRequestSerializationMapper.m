//
//  HPFCustomerInfoRequestSerializationMapper.m
//  Pods
//
//  Created by HiPay on 14/10/2015.
//
//

#import "HPFCustomerInfoRequestSerializationMapper.h"
#import "HPFCustomerInfoRequest.h"
#import "NSMutableDictionary+Serialization.h"
#import "HPFAbstractSerializationMapper+Encode.h"
#import "HPFCustomerInfoRequestSerializationMapper_Private.h"
#import "HPFPersonalInfoRequestSerializationMapper_Protected.h"

@implementation HPFCustomerInfoRequestSerializationMapper

- (NSDictionary *)serializedRequest
{
    NSMutableDictionary *result = [self personalInformationSerializedRequest];
    
    [result setNullableObject:[self getStringForKey:@"email"] forKey:@"email"];
    [result setNullableObject:[self getStringForKey:@"phone"] forKey:@"phone"];
    [result setNullableObject:[self getBirthDate] forKey:@"birthdate"];
    [result setNullableObject:[self getCharEnumValueForKey:@"gender"] forKey:@"gender"];
    
    return [NSDictionary dictionaryWithDictionary:result];
}

- (NSString *)getBirthDate
{
    NSNumber *birthDateDay = [self.request valueForKey:@"birthDateDay"];
    NSNumber *birthDateMonth = [self.request valueForKey:@"birthDateMonth"];
    NSNumber *birthDateYear = [self.request valueForKey:@"birthDateYear"];
    
    if (birthDateDay != nil && birthDateMonth != nil && birthDateYear != nil) {
        NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
        formatter.numberStyle = NSNumberFormatterNoStyle;
        formatter.minimumIntegerDigits = 2;
        
        return [NSString stringWithFormat:@"%@%@%@", [formatter stringFromNumber:birthDateYear], [formatter stringFromNumber:birthDateMonth], [formatter stringFromNumber:birthDateDay]];
    }
    
    return nil;
}

@end
