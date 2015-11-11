//
//  DetailViewController.m
//  RottenMangoes
//
//  Created by Steele on 2015-11-09.
//  Copyright © 2015 Steele. All rights reserved.
//

#import "DetailViewController.h"
#import "MapViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.detailLabel.text = self.movie.title;
    self.detailImageView.image = self.movie.image;
    self.detailSynopsis.text = self.movie.synopsis;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue identifier] isEqualToString:@"mapSegue"]) {
        
        
        
        MapViewController *controller = (MapViewController *)[segue destinationViewController];
        
        
        controller.movie= self.movie;
    }
}


@end
