//
//  Movie.m
//  RottenMangoes
//
//  Created by Steele on 2015-11-09.
//  Copyright © 2015 Steele. All rights reserved.
//

#import "Movie.h"

@implementation Movie

- (instancetype)initWithTitle:(NSString*)title imageURLString:(NSString*)imageURLString year:(NSNumber*)year synopsis:(NSString*)synopsis
{
    self = [super init];
    if (self) {
        _title = title;
        _imageURLString = imageURLString;
        _year = year;
        _synopsis = synopsis;
    }
    return self;
}


-(NSURL *)convertToLargeImageURLFromString:(NSString*)string {
    
    NSRange searchRange = NSMakeRange(0, string.length);
    NSRange foundRange = [string rangeOfString:@"dkpu1ddg7pbsk" options:0 range:searchRange];
    
    if (foundRange.location == NSNotFound) {
        NSLog(@"no words found");
        return nil;
    } else {
        NSString *largeImageStringURL = [string substringFromIndex:foundRange.location];
        largeImageStringURL = [@"http://" stringByAppendingString:largeImageStringURL];
        
        NSURL *imageURL = [NSURL URLWithString:largeImageStringURL];
        return imageURL;
    }
}


@end
