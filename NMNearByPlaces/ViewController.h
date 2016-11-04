//
//  ViewController.h
//  NMNearByPlaces
//
//  Created by Namrata on 03/11/16.
//  Copyright © 2016 Namrata Mahajan. All rights reserved.
//
#define kGooglePlaceAPIKey @"AIzaSyCjPltPWlOdOU6Txi1D3M138DWzGqVBEQU"
#define kLatitude 19.2330
#define kLongitude 72.8777
#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>



@interface ViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,MKMapViewDelegate,CLLocationManagerDelegate>
{
    CLLocationManager *locationManager;
    
    NSArray *placeTypes;
    
}
@property (strong, nonatomic) IBOutlet UITableView *tablePlaceType;

- (IBAction)ChangeDistance:(id)sender;

@end

