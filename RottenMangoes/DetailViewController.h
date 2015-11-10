//
//  DetailViewController.h
//  RottenMangoes
//
//  Created by Steele on 2015-11-09.
//  Copyright © 2015 Steele. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Movie.h"

@interface DetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (nonatomic) Movie *movie;
@property (weak, nonatomic) IBOutlet UIImageView *detailImageView;
@property (weak, nonatomic) IBOutlet UILabel *detailSynopsis;

@end
