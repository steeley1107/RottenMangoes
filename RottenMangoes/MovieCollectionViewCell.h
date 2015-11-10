//
//  MovieCollectionViewCell.h
//  RottenMangoes
//
//  Created by Steele on 2015-11-09.
//  Copyright © 2015 Steele. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Movie.h"

@interface MovieCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic) NSURLSessionTask *task;
@property (nonatomic) Movie *movie;


-(void)downloadMovieImage;

@end
