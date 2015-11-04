//
//  NSDate+TimeStyle.m
//  winter2016iosapp
//
//  Created by Scott Brower on 11/3/15.
//  Copyright © 2015 BICSI. All rights reserved.
//

#import "NSDate+TimeStyle.h"

@implementation NSDate (TimeStyle)

+(BOOL)is24Hours
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setLocale:[NSLocale currentLocale]];
    [formatter setDateStyle:NSDateFormatterNoStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    NSString *dateString = [formatter stringFromDate:[NSDate date]];
    NSRange amRange = [dateString rangeOfString:[formatter AMSymbol]];
    NSRange pmRange = [dateString rangeOfString:[formatter PMSymbol]];
    return (amRange.location == NSNotFound && pmRange.location == NSNotFound);
}

+(NSDate *)convertTimeFromStr:(NSString *)timeStr
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    [dateFormatter setLocale:locale];
    [dateFormatter setDateFormat:@"hh:mm a"];

    return [dateFormatter dateFromString:timeStr];
}

+(NSString *)stringFromTime:(NSDate *)dateTime
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    NSLocale *locale2 = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    [dateFormatter setLocale:locale2];
    if ([self is24Hours])
        [dateFormatter setDateFormat:@"HH:mm"];
    else
        [dateFormatter setDateFormat:@"hh:mm a"];

    return [dateFormatter stringFromDate:dateTime];
}

@end
