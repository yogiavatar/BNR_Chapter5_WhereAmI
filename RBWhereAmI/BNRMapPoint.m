//
//  BNRMapPoint.m
//  RBWhereAmI
//



#import "BNRMapPoint.h"

@implementation BNRMapPoint
@synthesize coordinate;
@synthesize title;
@synthesize subtitle;

// new designated initializer for instances of BNRMapPoint
-(id)initWithCoordinate:(CLLocationCoordinate2D)c title:(NSString*)t subtitle:(NSString*)sT
{
    self = [super init];
    if (self) 
    {
        coordinate = c;
        [self setTitle:t];
        // gold challenge - include the date in the subtitle of the map point annotation
        [self setSubtitle:sT];
    }
    return self;
}

-(id)init
{
// in MKAnnotation, the subtitle has all lowercase and it is not "subTitle". If the correct format is not used, the subtitle does not get displayed
    return [self initWithCoordinate:CLLocationCoordinate2DMake(43.07, -89.32) title:@"Hometown" subtitle:@"1234"];
}



@end
