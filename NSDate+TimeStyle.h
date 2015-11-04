//
//  NSDate+TimeStyle.h
//  winter2016iosapp
//
//  Created by Scott Brower on 11/3/15.
//  Copyright © 2015 BICSI. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (TimeStyle)

+(BOOL)is24Hours;
+(NSDate *)convertTimeFromStr:(NSString *)timeStr;
+(NSString *)stringFromTime:(NSDate *)dateTime;

@end
