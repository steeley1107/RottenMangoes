//
//  MovieCollectionViewCell.m
//  RottenMangoes
//
//  Created by Steele on 2015-11-09.
//  Copyright © 2015 Steele. All rights reserved.
//

#import "MovieCollectionViewCell.h"

@implementation MovieCollectionViewCell


-(void)setMovie:(Movie *)movie {
    
    _movie = movie;
    _movie.image = nil;
    _imageView.image = nil;
    
    
}


-(void)downloadMovieImage {
    
    if (self.task) {
        [self.task cancel];
    }
    
    if (!self.movie.image) {
        
        NSURL *thumbnailUrl = [self.movie convertToLargeImageURLFromString:self.movie.imageURLString];
        
        NSURLSession *session = [NSURLSession sharedSession];
        self.task = [session dataTaskWithURL:thumbnailUrl completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            
            if (error.code == NSURLErrorCancelled) {
                return;
            }
            
            if (!error) {
                UIImage *image = [UIImage imageWithData:data];
                self.movie.image = image;
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.imageView.image = image;
                });
            }
        }];
        
        
        [self.task resume];
    }
}


@end
