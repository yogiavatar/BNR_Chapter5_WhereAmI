//
//  RBWhereAmIViewController.h
//  RBWhereAmI
//
//  Chapter 4 & 5
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface RBWhereAmIViewController : UIViewController <CLLocationManagerDelegate,MKMapViewDelegate,UITextFieldDelegate>
{
    CLLocationManager *locationManager;
    
    IBOutlet MKMapView *worldView;
    IBOutlet UIActivityIndicatorView *activityIndicator;
    IBOutlet UITextField *locationTitleField;
// solution to Silver Challenge
    IBOutlet UISegmentedControl *segmentedControl;
}

//solution to silver challenge
-(IBAction)viewType:(MKMapView*)view;

-(void)findLocation;
-(void)foundLocation:(CLLocation *)loc;

@end
