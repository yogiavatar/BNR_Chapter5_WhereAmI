//
//  RBWhereAmIViewController.m
//  RBWhereAmI
//


#import "RBWhereAmIViewController.h"
#import "BNRMapPoint.h"
#define kDistanceFilter 50

@implementation RBWhereAmIViewController

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) 
    {
        locationManager = [[CLLocationManager alloc] init];
        [locationManager setDelegate:self];
        [locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    }
    return self;
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
        NSLog(@"Location: %@",newLocation);
    NSTimeInterval t = [[newLocation timestamp] timeIntervalSinceNow];
    if (t < -180)
    {
        return;
    }
    [self foundLocation:newLocation];
    
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"Could not find location: %@",error);
}

-(void)dealloc
{
    [locationManager setDelegate:nil];
}

-(void)viewDidLoad
{
    [worldView setShowsUserLocation:YES];

}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    CLLocationCoordinate2D loc = [userLocation coordinate];
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(loc, 250, 250);
    [worldView setRegion:region animated:YES];
    
 
}

//implemented as solution to silver challenge of chapter 5
-(IBAction)viewType:(MKMapView*)view
{
    if (segmentedControl.selectedSegmentIndex==0) 
        [worldView setMapType:MKMapTypeStandard];
    else if (segmentedControl.selectedSegmentIndex==1) 
        [worldView setMapType:MKMapTypeSatellite];
    else if (segmentedControl.selectedSegmentIndex==2) 
        [worldView setMapType:MKMapTypeHybrid];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self findLocation];
    [textField resignFirstResponder];
    return YES;
}

-(void)findLocation
{
    [locationManager stopUpdatingLocation];
    [activityIndicator startAnimating];
    [locationTitleField setHidden:YES];
}

-(void)foundLocation:(CLLocation *)loc
{
    CLLocationCoordinate2D coord = [loc coordinate];
    
    BNRMapPoint *mp = [[BNRMapPoint alloc] initWithCoordinate:coord title:[locationTitleField text]];
    [worldView addAnnotation:mp];
    
    MKCoordinateRegion region =MKCoordinateRegionMakeWithDistance(coord, 250, 250);
    [worldView setRegion:region animated:YES];
    
    [locationTitleField setText:@""];
    [activityIndicator stopAnimating];
    [locationTitleField setHidden:NO];
    [locationManager stopUpdatingLocation];
}



@end
