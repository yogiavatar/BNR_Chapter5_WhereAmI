//
//  BNRMapPoint.h
//  RBWhereAmI
//



#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface BNRMapPoint : NSObject <MKAnnotation>
{
    
}
-(id)initWithCoordinate:(CLLocationCoordinate2D)c title:(NSString*)t subtitle:(NSString*)sT;
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;
//note the lower case "subtitle". In MKAnnotation, the subtitle has all lowercase and it is not "subTitle". If the correct format is not used, the subtitle does not get displayed
@property (nonatomic, copy) NSString *subtitle;





@end
