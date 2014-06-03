//
//  DNAPI.h
//  Nature News
//
//  Created by Ryan Warner on 6/3/14.
//  Copyright (c) 2014 Ryan Warner. All rights reserved.
//

#import <Foundation/Foundation.h>

// Referencing variables
extern NSString *const DNAPIBaseURL;
extern NSString *const DNAPIStories;
extern NSString *const DNAPIComments;
extern NSString *const DNAPILogin;

@interface NSURLRequest (DNAPI)

// functions we'll need
+ (instancetype)requestWithPattern:(NSString *)string object:(id)object;
+ (instancetype)postRequest:(NSString *)string parameters:(NSDictionary *)parameters;
+ (instancetype)deleteRequest:(NSString *)string parameters:(NSDictionary *)parameters;
+ (instancetype)requestWithMethod:(NSString *)method
                              url:(NSString *)url
                       parameters:(NSDictionary *)parameters;

@end
