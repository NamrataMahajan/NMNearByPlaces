//
//  ViewController.m
//  NMNearByPlaces
//
//  Created by Namrata on 03/11/16.
//  Copyright © 2016 Namrata Mahajan. All rights reserved.
//

#import "ViewController.h"
#import "PlaceListViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    placeTypes =@[@"airport",@"beauty_salon",@"cafe",@"furniture_store",@"gas_station",@"hospital",@"hair_care",@"jewelery_store",@"library",@"movie_theater",@"night_club",@"park",@"restaurant",@"shopping_mall",@"travel_agency",@"university",@"zoo"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)startLocating {
    locationManager = [[CLLocationManager alloc]init];
    locationManager.delegate = self;
    [locationManager requestWhenInUseAuthorization];
    [locationManager startUpdatingLocation];
    
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return placeTypes.count;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    
    
    cell.textLabel.text = [placeTypes objectAtIndex:indexPath.row];
    return cell;
    
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *placeType =[placeTypes objectAtIndex:indexPath.row];
    PlaceListViewController *placeListViewController =[self.storyboard instantiateViewControllerWithIdentifier:@"PlaceListViewController"];
 placeListViewController.selectedPlaceType = placeType;
  //  placeListViewController.sele
    [self.navigationController pushViewController:placeListViewController animated:YES];
    
    
}



- (IBAction)ChangeDistance:(id)sender {
}
@end
