//
//  MainViewController.h
//  Colors
//
//  Created by Anthonio Ez on 8/8/15.
//  Copyright (c) 2015 Colors. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController <UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource, UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *level1Table;
@property (weak, nonatomic) IBOutlet UITableView *level3Table;
@property (weak, nonatomic) IBOutlet UICollectionView *level2Grid;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *level2Layout;

@end
