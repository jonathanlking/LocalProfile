//
//  ProfileGenerator.h
//  LocalProfile
//
//  Created by Jonathan King on 29/03/2014.
//  Copyright (c) 2014 Jonathan King. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProfileGenerator : NSObject

+ (BOOL)generateProfileWithName:(NSString *)name andPhoneNumber:(NSString *)phoneNumber;
+ (NSString *)profilePath;

@end
