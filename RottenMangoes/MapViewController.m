//
//  MapViewController.m
//  RottenMangoes
//
//  Created by Steele on 2015-11-10.
//  Copyright © 2015 Steele. All rights reserved.
//

#import "MapViewController.h"
#import "LocationManager.h"


@interface MapViewController () <MKMapViewDelegate>

@property (nonatomic) NSMutableArray *theatreListArray;
@property (strong,nonatomic) CLLocation *currentLocation;
@property (nonatomic) LocationManager *locationManager;

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mapView.delegate = self;
    
    self.locationManager = [LocationManager sharedManager];
    [self.locationManager startLocationManager];
    self.theatreListArray = [NSMutableArray array];
    self.theatre = [Theatre new];
    
    self.mapView.showsUserLocation = true;
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(locationUpdated) name:@"locationUpdated" object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)fetchJsonWithPostalCode:(NSString*)postalCode {
    
    NSLog(@"json %@",postalCode);
    
    NSString *urlString = [self.theatre findTheatreForMovieNamed:self.movie.title andPostalCode:postalCode ];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionTask *dataTask = [session dataTaskWithURL:[NSURL URLWithString:urlString] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        if (!error) {
            NSError *jsonError = nil;
            NSDictionary *theatreDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
            NSArray *theatreArray = [[NSArray alloc]init];
            theatreArray = [theatreDictionary objectForKey:@"theatres"];
            
            for (NSDictionary *eachTheatre in theatreArray){
                
                NSString *title = eachTheatre[@"name"];
                NSString *address = eachTheatre[@"address"];
                NSNumber *lat = eachTheatre[@"lat"];
                NSNumber *lng = eachTheatre[@"lng"];
                CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake([lat doubleValue], [lng doubleValue]);
                
                Theatre *theatre = [[Theatre alloc] initWithCoordinate:coordinate andTitle:title andSubtitle:address];
                
                [self.theatreListArray addObject:theatre];
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                for (Theatre *theatre in self.theatreListArray) {
                    [self.mapView addAnnotation:theatre];
                }
            });
        }
    }];
    [dataTask resume];
}


-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    MKCoordinateRegion mapRegion;
    mapRegion.center = mapView.userLocation.coordinate;
    mapRegion.span.latitudeDelta = 0.2;
    mapRegion.span.longitudeDelta = 0.2;
//    [self fetchUserLocationPostalCode];
    [mapView setRegion:mapRegion animated: YES];
    
}


-(void)fetchUserLocationPostalCode
{
    CLGeocoder *geocoder;
    if (!geocoder)
    {
        geocoder = [[CLGeocoder alloc] init];
    }
    [geocoder reverseGeocodeLocation:self.locationManager.currentLocation
                   completionHandler:^(NSArray* placemarks, NSError* error)
     {
         if (!error)
         {
             CLPlacemark *placemark = placemarks[placemarks.count-1];
             //self.postalCode = placemark.postalCode;
             [self fetchJsonWithPostalCode:placemark.postalCode];
             NSLog(@"fetchlocation%@",placemark.postalCode);
             NSLog(@"fetchlocation%@",self.locationManager.currentLocation);
             
         }
     }];
}


-(void)mapViewDidFinishLoadingMap:(nonnull MKMapView *)mapView{

}

-(void)locationUpdated {
    
    [self fetchUserLocationPostalCode];
    
}


@end
