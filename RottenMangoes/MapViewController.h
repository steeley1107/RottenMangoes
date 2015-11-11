//
//  MapViewController.h
//  RottenMangoes
//
//  Created by Steele on 2015-11-10.
//  Copyright © 2015 Steele. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "Theatre.h"
#import "Movie.h"

@interface MapViewController : UIViewController
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic) Movie *movie;
@property (nonatomic) Theatre *theatre;
@property (nonatomic) NSString *postalCode;


@end
