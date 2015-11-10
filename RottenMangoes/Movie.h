//
//  Movie.h
//  RottenMangoes
//
//  Created by Steele on 2015-11-09.
//  Copyright © 2015 Steele. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Movie : NSObject

@property (nonatomic) NSString *title;
@property (nonatomic) UIImage *image;
@property (nonatomic) NSString *imageURLString;
@property (nonatomic) NSNumber *year;
@property (nonatomic) NSString *synopsis;


- (instancetype)initWithTitle:(NSString*)title imageURLString:(NSString*)imageURLString year:(NSNumber*)year synopsis:(NSString*)synopsis;

-(NSURL *)convertToLargeImageURLFromString:(NSString*)string;

@end
