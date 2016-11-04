//
//  PlaceDetailViewController.h
//  NMNearByPlaces
//
//  Created by Namrata on 03/11/16.
//  Copyright © 2016 Namrata Mahajan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlaceDetailViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *placeDetail;
}
@property NSString *selectedPlaceID;

@property (strong, nonatomic) IBOutlet UITableView *tableViewPlaceDetail;


@end
