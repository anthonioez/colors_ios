//
//  AppDelegate.h
//  Colors
//
//  Created by Anthonio Ez on 8/8/15.
//  Copyright (c) 2015 Colors. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

#define APP_EMAIL           @"mariannapucci2@gmail.com"
#define APP_PHONE           @"1-800-555-1212"
#define APP_LATITUDE        39.281516
#define APP_LONGITUDE       -76.580806


#define isIPAD     UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@property UITabBarController *tabBarController;


@end

