//
//  PlaceListViewController.m
//  NMNearByPlaces
//
//  Created by Namrata on 03/11/16.
//  Copyright © 2016 Namrata Mahajan. All rights reserved.
//

#import "PlaceListViewController.h"
#import "PlaceDetailViewController.h"

@interface PlaceListViewController ()

@end

@implementation PlaceListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    placeList = [[NSMutableArray alloc]init];
    if ([self.selectedPlaceType isEqualToString:@"atm"]) {
        self.title = self.selectedPlaceType.uppercaseString;
    }
    else{
        self.title = self.selectedPlaceType.uppercaseString;
    }
    //[self getPlaceListWithAPIKey:kGooglePlaceAPIKey placeType:self.selectedPlaceType radius:1000 latitude:kLatitude longitude:kLongitude format:@"xml" ];
    [self getPlaceTypeWithAPIKey:kGooglePlaceAPIKey placeTypes:self.selectedPlaceType radius:1000 latitude:kLatitude longitude:kLongitude format:@"xml"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

 
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)getPlaceTypeWithAPIKey:(NSString *)key
                   placeTypes:(NSString *)type
                       radius:(int)radius
                     latitude:(double)latitude
                    longitude:(double)longitude
                       format:(NSString *)format
{
    NSString *urlString = [NSString stringWithFormat:@"    https://maps.googleapis.com/maps/api/place/nearbysearch/xml?&key=AIzaSyCjPltPWlOdOU6Txi1D3M138DWzGqVBEQU&location=19.72,72.89&radius=50000&types=atm=%@",format,key,latitude,longitude,radius,type];
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLSession *mySession = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURLSessionDataTask *task = [mySession dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            
        }
        else{
            if (response) {
                NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
                
                if (httpResponse.statusCode == 200) {
                    if (data) {
                        parser = [[NSXMLParser alloc]initWithData:data];
                        parser.delegate = self;
                        [parser parse];
                    }
                    else{
                        //alert
                    }
                }
                else{
                    //alert
                }
            }
            else{
                //alert
            }
        }
    }];
    [task resume];
    }
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return placeList.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    NSDictionary *temperatureDictionary =[placeList objectAtIndex:indexPath.row];
    
    NSString *address = [temperatureDictionary valueForKey:@"vicinity"];
    NSString *placeName = [temperatureDictionary valueForKey:@"name"];
    cell.detailTextLabel.text = address;
    [cell.detailTextLabel setLineBreakMode:NSLineBreakByWordWrapping];
    
    cell.textLabel.text = placeName;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    PlaceDetailViewController *placeDetailViewController =[self.storyboard instantiateViewControllerWithIdentifier:@"PlaceDetailViewController"];
    
    NSDictionary *placeDictionary = [placeList objectAtIndex:indexPath.row];
    
    NSString *place_id = [placeDictionary valueForKey:@"place_id"];
    placeDetailViewController.selectedPlaceID = place_id;
    
    [self.navigationController pushViewController:placeDetailViewController animated:YES];
    
}

-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary<NSString *,NSString *> *)attributeDict {
    if ([elementName isEqualToString:@"result"]) {
        placeDictionary = [[NSMutableDictionary alloc]init];
        
    }
    else if ([elementName isEqualToString:@"name"]){
        dataString = [[NSMutableString alloc]init];
        
    }
    else if ([elementName isEqualToString:@"vicinity"]){
        dataString = [[NSMutableString alloc]init];
        
    }
    else if ([elementName isEqualToString:@"place_id"]){
        dataString = [[NSMutableString alloc]init];
        
    }
}
-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    dataString = string;
}
-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if ([elementName isEqualToString:@"result"]) {
        [placeList addObject:placeDictionary];
    }
    else if ([elementName isEqualToString:@"name"]) {
        [placeDictionary setValue:dataString forKey:@"name"];
        
    }
    else if ([elementName isEqualToString:@"vicinity"]){
        [placeDictionary setValue:dataString forKey:@"vicinity"];
    }
    else if ([elementName isEqualToString:@"place_id"]){
        [placeDictionary setValue:dataString forKey:@"place_id"];
        
    }
    else if ([elementName isEqualToString:@"PlaceSearchResponse"]){
        [self performSelectorOnMainThread:@selector(updateTableview) withObject:nil waitUntilDone:NO];
        
    }
}
-(void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError{
    NSLog(@"PARSE ERROR : %@",parseError.localizedDescription);
}
-(void)updateTableview {
    [self.tableViewPlaceList reloadData];
}

    


@end
