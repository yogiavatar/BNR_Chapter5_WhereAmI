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
    
    // Solution to Gold Challenge Chapter 5
    //Extract the current date and time when the annotation is set for a map point
    NSDate *currentDate = [newLocation timestamp];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd 'at' HH:mm"];
    NSString *stringFromDate = [formatter stringFromDate:currentDate];
    
    if (t < -180)
    {
        return;
    }
    [self foundLocation:newLocation :stringFromDate];
    
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
    [locationManager startUpdatingLocation];
    [activityIndicator startAnimating];
    [locationTitleField setHidden:YES];
}

-(void)foundLocation:(CLLocation *)loc :(NSString*)date
{
    CLLocationCoordinate2D coord = [loc coordinate];
    // display the location date in the subtitle of the map point annotation ( solution to gold challenge)
    BNRMapPoint *mp = [[BNRMapPoint alloc] initWithCoordinate:coord title:[locationTitleField text] subtitle:date];
    [worldView addAnnotation:mp];
    
    MKCoordinateRegion region =MKCoordinateRegionMakeWithDistance(coord, 250, 250);
    [worldView setRegion:region animated:YES];
    
    [locationTitleField setText:@""];
    [activityIndicator stopAnimating];
    [locationTitleField setHidden:NO];
    [locationManager stopUpdatingLocation];
}



@end
