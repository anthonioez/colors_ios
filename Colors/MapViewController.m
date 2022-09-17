//
//  MapViewController.m
//  Colors
//
//  Created by Anthonio Ez on 8/8/15.
//  Copyright (c) 2015 Colors. All rights reserved.
//

#import "AppDelegate.h"
#import "MapViewController.h"

@interface MapViewController ()
{
    CLLocationCoordinate2D zoomLocation;
}
@end

@implementation MapViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self)
    {
        zoomLocation.latitude = APP_LATITUDE;
        zoomLocation.longitude= APP_LONGITUDE;

        self.title = @"Maps";
        //set the image icon for the tab
        self.tabBarItem.image = [UIImage imageNamed:@"bar_map.png"];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mapView.delegate = self;
    
    
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(zoomLocation, 800, 800);
    [self.mapView setRegion:[self.mapView regionThatFits:region] animated:YES];
    
//    [self.mapView setRegion:region animated:YES];
    
    
    // Add an annotation
    MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
    point.coordinate = zoomLocation;
    point.title = @"Colorificio Splendor";
    point.subtitle = @"Store location";
    
    [self.mapView addAnnotation:point];
    
}

- (void)viewWillAppear:(BOOL)animated {
    
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

@end
