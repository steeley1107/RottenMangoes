//
//  ViewController.m
//  RottenMangoes
//
//  Created by Steele on 2015-11-09.
//  Copyright © 2015 Steele. All rights reserved.
//

#import "ViewController.h"
#import "MovieCollectionViewCell.h"
#import "DetailViewController.h"

@interface ViewController () <UICollectionViewDataSource, UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;


@property NSMutableArray *moviesArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.moviesArray = [NSMutableArray array];
    [self fetchJSON];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return  1;
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.moviesArray.count;
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    MovieCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"imageCell" forIndexPath:indexPath];
    Movie *movie = [self.moviesArray objectAtIndex:indexPath.item];
    
    cell.movie = movie;
    cell.movieTitle.text = movie.title;
    [cell downloadMovieImage];
    
    return cell;
}


- (void)fetchJSON {
    
    NSString *urlString = @"http://api.rottentomatoes.com/api/public/v1.0/lists/movies/in_theaters.json?apikey=2ckft9dtnazuw4ks5qq3uhzu";
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionTask *dataTask = [session dataTaskWithURL:[NSURL URLWithString:urlString] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        if (!error) {
            
            NSError *jsonError = nil;
            NSDictionary *moviesDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
            NSArray *rTmoviesArray = [[NSArray alloc]init];
            rTmoviesArray = [moviesDictionary objectForKey:@"movies"];
            
            for (NSDictionary *eachMovie in rTmoviesArray){
                
                NSString *title = eachMovie[@"title"];
                NSDictionary *postersDictionary = [[NSDictionary alloc]initWithDictionary:eachMovie[@"posters"]];
                NSString *urlString = [postersDictionary objectForKey:@"original"];
                NSNumber *year = eachMovie[@"year"];
                NSString *synopsis = eachMovie[@"synopsis"];
                
                Movie *movie = [[Movie alloc]initWithTitle:(NSString*)title imageURLString:(NSString*)urlString year:(NSNumber*)year synopsis:(NSString*)synopsis];
                
                [self.moviesArray addObject:movie];
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.collectionView reloadData];
            });
        }
    }];
    
    [dataTask resume];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue identifier] isEqualToString:@"detailSegue"]) {
        
        NSArray *indexPathArray = [self.collectionView indexPathsForSelectedItems];
        NSIndexPath *indexPath = indexPathArray[0];
        
        Movie *movie = self.moviesArray[indexPath.item];
        
        DetailViewController *controller = (DetailViewController *)[segue destinationViewController];
        controller.movie = movie;
    }
}


@end
