//
//  PlaceListViewController.h
//  NMNearByPlaces
//
//  Created by Namrata on 03/11/16.
//  Copyright © 2016 Namrata Mahajan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"

@interface PlaceListViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,NSXMLParserDelegate>
{
    NSMutableArray *placeList;
    NSXMLParser *parser;
    NSMutableString *dataString;
    
    NSMutableDictionary *placeDictionary;
    
}
@property NSString *selectedPlaceType;
@property (strong, nonatomic) IBOutlet UITableView *tableViewPlaceList;

@end
