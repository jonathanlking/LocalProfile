//
//  ProfileGenerator.m
//  LocalProfile
//
//  Created by Jonathan King on 29/03/2014.
//  Copyright (c) 2014 Jonathan King. All rights reserved.
//

#import "ProfileGenerator.h"

@implementation ProfileGenerator

+ (BOOL)generateProfileWithName:(NSString *)name andPhoneNumber:(NSString *)phoneNumber {
    
    NSString *templatePath = [[NSBundle mainBundle] pathForResource:@"phone_template" ofType:@"mobileconfig"];
    
    NSString *data = [NSString stringWithContentsOfFile:templatePath encoding:NSUTF8StringEncoding error:NULL];
    
    data = [data stringByReplacingOccurrencesOfString:@"!!NAME!!" withString:name];
    data = [data stringByReplacingOccurrencesOfString:@"!!PHONENUMBER!!" withString:phoneNumber];
    
    NSLog(@"%@", data);
    
    BOOL success = [data writeToFile:[ProfileGenerator profilePath] atomically:YES encoding:NSUTF8StringEncoding error:nil];
    
    return success;
}

+(NSString *)profilePath {
    
    NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"profile.mobileconfig"];
    
    return path;
}

@end
