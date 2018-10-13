//
//  UIDKeychain.m
//  IOSAppUUID
//
//  Created by Karthik 
//  Copyright © 2018 Karthik. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "UIDKeychain.h"
#import "UIDKeychainQuery.h"

NSString *const kUIDKeychainErrorDomain = @"com.device.UIDkeychain";
NSString *const kUIDKeychainAccountKey = @"acct";
NSString *const kUIDKeychainCreatedAtKey = @"cdat";
NSString *const kUIDKeychainClassKey = @"labl";
NSString *const kUIDKeychainDescriptionKey = @"desc";
NSString *const kUIDKeychainLabelKey = @"labl";
NSString *const kUIDKeychainLastModifiedKey = @"mdat";
NSString *const kUIDKeychainWhereKey = @"svce";

#if __IPHONE_4_0 && TARGET_OS_IPHONE
static CFTypeRef UIDKeychainAccessibilityType = NULL;
#endif

@implementation UIDKeychain

+ (nullable NSString *)passwordForService:(NSString *)serviceName account:(NSString *)account {
    return [self passwordForService:serviceName account:account error:nil];
}


+ (nullable NSString *)passwordForService:(NSString *)serviceName account:(NSString *)account error:(NSError *__autoreleasing *)error {
    UIDKeychainQuery *query = [[UIDKeychainQuery alloc] init];
    query.service = serviceName;
    query.account = account;
    [query fetch:error];
    return query.password;
}

+ (nullable NSData *)passwordDataForService:(NSString *)serviceName account:(NSString *)account {
    return [self passwordDataForService:serviceName account:account error:nil];
}

+ (nullable NSData *)passwordDataForService:(NSString *)serviceName account:(NSString *)account error:(NSError **)error {
    UIDKeychainQuery *query = [[UIDKeychainQuery alloc] init];
    query.service = serviceName;
    query.account = account;
    [query fetch:error];
    
    return query.passwordData;
}


+ (BOOL)deletePasswordForService:(NSString *)serviceName account:(NSString *)account {
    return [self deletePasswordForService:serviceName account:account error:nil];
}


+ (BOOL)deletePasswordForService:(NSString *)serviceName account:(NSString *)account error:(NSError *__autoreleasing *)error {
    UIDKeychainQuery *query = [[UIDKeychainQuery alloc] init];
    query.service = serviceName;
    query.account = account;
    return [query deleteItem:error];
}


+ (BOOL)setPassword:(NSString *)password forService:(NSString *)serviceName account:(NSString *)account {
    return [self setPassword:password forService:serviceName account:account error:nil];
}


+ (BOOL)setPassword:(NSString *)password forService:(NSString *)serviceName account:(NSString *)account error:(NSError *__autoreleasing *)error {
    UIDKeychainQuery *query = [[UIDKeychainQuery alloc] init];
    query.service = serviceName;
    query.account = account;
    query.password = password;
    return [query save:error];
}

+ (BOOL)setPasswordData:(NSData *)password forService:(NSString *)serviceName account:(NSString *)account {
    return [self setPasswordData:password forService:serviceName account:account error:nil];
}


+ (BOOL)setPasswordData:(NSData *)password forService:(NSString *)serviceName account:(NSString *)account error:(NSError **)error {
    UIDKeychainQuery *query = [[UIDKeychainQuery alloc] init];
    query.service = serviceName;
    query.account = account;
    query.passwordData = password;
    return [query save:error];
}

+ (nullable NSArray *)allAccounts {
    return [self allAccounts:nil];
}


+ (nullable NSArray *)allAccounts:(NSError *__autoreleasing *)error {
    return [self accountsForService:nil error:error];
}


+ (nullable NSArray *)accountsForService:(nullable NSString *)serviceName {
    return [self accountsForService:serviceName error:nil];
}


+ (nullable NSArray *)accountsForService:(nullable NSString *)serviceName error:(NSError *__autoreleasing *)error {
    UIDKeychainQuery *query = [[UIDKeychainQuery alloc] init];
    query.service = serviceName;
    return [query fetchAll:error];
}


#if __IPHONE_4_0 && TARGET_OS_IPHONE
+ (CFTypeRef)accessibilityType {
    return UIDKeychainAccessibilityType;
}


+ (void)setAccessibilityType:(CFTypeRef)accessibilityType {
    CFRetain(accessibilityType);
    if (UIDKeychainAccessibilityType) {
        CFRelease(UIDKeychainAccessibilityType);
    }
    UIDKeychainAccessibilityType = accessibilityType;
}
#endif

@end
