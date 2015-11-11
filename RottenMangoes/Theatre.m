//
//  Theater.m
//  RottenMangoes
//
//  Created by Steele on 2015-11-10.
//  Copyright © 2015 Steele. All rights reserved.
//

#import "Theatre.h"

@implementation Theatre


- (instancetype)initWithCoordinate:(CLLocationCoordinate2D)aCoordinate andTitle:(NSString *)aTitle andSubtitle:(NSString *)aSubtitle;
{
    self = [super init];
    if (self) {
        _coordinate = aCoordinate;
        _title = aTitle;
        _subtitle = aSubtitle;
    }
    return self;
}


-(NSString *)findTheatreForMovieNamed:(NSString*)title andPostalCode:(NSString*)postalCode{
    
    title = [title stringByReplacingOccurrencesOfString:@" "withString:@"_"];
    
    if (!postalCode) {
        postalCode = @"V6B1E6";
    }
    
    NSString *urlString = @"http://lighthouse-movie-showtimes.herokuapp.com/theatres.json?address=V6B1E6&movie=[movieName]";
    urlString = [urlString stringByReplacingOccurrencesOfString:@"[movieName]"
                                         withString:title];
    urlString = [urlString stringByReplacingOccurrencesOfString:@"V6B1E6"
                                                     withString:postalCode];
    return urlString;
}



@end
