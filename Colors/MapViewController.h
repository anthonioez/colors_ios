//
//  MapViewController.h
//  Colors
//
//  Created by Anthonio Ez on 8/8/15.
//  Copyright (c) 2015 Colors. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface MapViewController : UIViewController<MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@end
