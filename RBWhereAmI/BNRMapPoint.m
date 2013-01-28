//
//  BNRMapPoint.m
//  RBWhereAmI
//



#import "BNRMapPoint.h"

@implementation BNRMapPoint
@synthesize coordinate;
@synthesize title;

// new designated initializer for instances of BNRMapPoint
-(id)initWithCoordinate:(CLLocationCoordinate2D)c title:(NSString*)t
{
    self = [super init];
    if (self) 
    {
        coordinate = c;
        [self setTitle:t];
    }
    return self;
}

-(id)init
{
    return [self initWithCoordinate:CLLocationCoordinate2DMake(43.07, -89.32) title:@"Hometown"];
}



@end
