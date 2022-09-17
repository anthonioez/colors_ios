//
//  MainViewController.m
//  Colors
//
//  Created by Anthonio Ez on 8/8/15.
//  Copyright (c) 2015 Colors. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"

#import "Level1ViewCell.h"
#import "Level2ViewCell.h"
#import "Level3ViewCell.h"

#define LEVEL1_CELL   @"Level1ViewCell"
#define LEVEL2_CELL   @"Level2ViewCell"
#define LEVEL3_CELL   @"Level3ViewCell"

@interface MainViewController ()
{
    NSArray *level1List;
    NSArray *level2List;
    NSArray *level3List;

    NSArray * directoryContents;

    CGFloat cellSize;
}
@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self)
    {
        cellSize = 100;
        level1List = [NSArray new];
        level2List = [NSArray new];
        level3List = [NSArray new];
        
        self.title = @"Colors";
        self.tabBarItem.image = [UIImage imageNamed:@"bar_color.png"];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSError * error;
    directoryContents = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:[[NSBundle mainBundle] resourcePath] error:&error];
    
    [self.level1Table registerNib:[UINib nibWithNibName:LEVEL1_CELL bundle:nil] forCellReuseIdentifier:LEVEL1_CELL];
    [self.level1Table setDelegate:self];
    [self.level1Table setDataSource:self];
    
    [self.level2Grid registerNib:[UINib nibWithNibName:LEVEL2_CELL bundle:nil] forCellWithReuseIdentifier:LEVEL2_CELL];
    [self.level2Grid setDelegate:self];
    [self.level2Grid setDataSource:self];
    
    [self.level3Table registerNib:[UINib nibWithNibName:LEVEL3_CELL bundle:nil] forCellReuseIdentifier:LEVEL3_CELL];
    [self.level3Table setDelegate:self];
    [self.level3Table setDataSource:self];
    
    
    [self loadLevel1];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    UIScreen *screen = [UIScreen mainScreen];
    CGRect screenRect = [screen bounds];
    NSLog(@"screen: %d, %d", (int)screenRect.size.width, (int)screenRect.size.height);
    
    CGRect viewRect = [self.view bounds];
    NSLog(@"view: %d, %d", (int)viewRect.size.width, (int)viewRect.size.height);
    
    CGRect gridRect = [self.level2Grid frame];
    NSLog(@"grid: %d, %d", (int)gridRect.size.width, (int)gridRect.size.height);
    
    
    CGFloat designWidth = 375;
    CGFloat screenScale = viewRect.size.width / designWidth;
    CGFloat gridWidth = (gridRect.size.width - 20) * screenScale;
    cellSize = (gridWidth) / 3.0f;
    
    if(screenRect.size.width == 320)
    {
        cellSize = 74;
    }
    else if(screenRect.size.width == 375)
    {
        cellSize = 92;
    }
    else if(screenRect.size.width == 414)
    {
        cellSize = 105;
    }
    else if(screenRect.size.width == 768)
    {
        cellSize = 223;
    }
    
    
    self.level2Layout.itemSize = CGSizeMake(cellSize, cellSize);
    self.level2Layout.minimumLineSpacing = 1;
    self.level2Layout.minimumInteritemSpacing = 0;
    self.level2Layout.headerReferenceSize = CGSizeMake(0, 0);
    self.level2Layout.footerReferenceSize = CGSizeMake(0, 0);
    self.level2Layout.sectionInset = UIEdgeInsetsZero;
    
    NSLog(@"cellSize: %d", (int)cellSize);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView == self.level1Table)
        return [level1List count];
    else if(tableView == self.level3Table)
        return [level3List count];
    else
        return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.level1Table)
    {
        NSString *item = [level1List objectAtIndex:indexPath.row];
        item = [item stringByAppendingString:@".png"];
        
        Level1ViewCell *cell = (Level1ViewCell *)[self.level1Table dequeueReusableCellWithIdentifier: LEVEL1_CELL];
        [cell.iconImage setImage: [UIImage imageNamed: item]];
        return cell;
    }
    else if (tableView == self.level3Table)
    {
        NSString *item = [level3List objectAtIndex:indexPath.row];
        item = [item stringByAppendingString:@".jpg"];
        
        Level3ViewCell *cell = (Level3ViewCell *)[self.level3Table dequeueReusableCellWithIdentifier: LEVEL3_CELL];
        [cell.iconImage setImage: [UIImage imageNamed: item]];
        return cell;
    }
    return nil;
}

#pragma mark - Table view delegate
// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.level1Table)
    {
        NSString *selected = [level1List objectAtIndex:indexPath.row];
        
        [self loadLevel2:selected];
    }
    else if(tableView == self.level3Table)
    {
        NSString *selected = [level3List objectAtIndex:indexPath.row];
        
        [self loadLevel4:selected];
    }
}

#pragma mark - Collection view data source
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [level2List count];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *item = [level2List objectAtIndex:indexPath.row];
    item = [item stringByAppendingString:@".png"];
    
    Level2ViewCell *cell = [self.level2Grid dequeueReusableCellWithReuseIdentifier:LEVEL2_CELL forIndexPath:indexPath];
//    [cell setFrame: CGRectMake(0, 0, cellSize, cellSize)];
    
    [cell.iconImage setImage: [UIImage imageNamed: item]];
//    [cell.iconImage setFrame: CGRectMake(0, 0, cellSize, cellSize)];
    
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self.level2Grid deselectItemAtIndexPath:indexPath animated:YES];
    
    NSString *selected = [level2List objectAtIndex:indexPath.row];
    
    [self loadLevel3:selected];
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(cellSize, cellSize);
}

- (void) loadLevel1
{
    level1List = [NSArray arrayWithObjects:
                  @"9", @"8", @"7",
                  @"6", @"5", @"4",
                  @"3", @"2", @"1", nil];

    [self.level1Table reloadData];
    
    [self loadLevel2: @"9"];
}

NSInteger alphabeticSort(id string1, id string2, void *reverse)
{
    if([string1 length] > [string2 length])
        return NSOrderedAscending;
    
    return [string2 localizedCaseInsensitiveCompare:string1];
}

- (void) loadLevel2: (NSString *) src
{
    NSMutableArray *list = [NSMutableArray new];
   
    NSString *key = [NSString stringWithFormat:@"2_%@", src];
    NSLog(@"level2 files for: %@", src);
    for (NSString *file in directoryContents)
    {
        NSLog(@"file: %@", file);
        if([file hasPrefix: key] && [file hasSuffix: @".png"])
        {
            NSString *filekey = [file substringToIndex: [file length] - 4];
            [list addObject: filekey];
        }
    }
    
    //NSSortDescriptor* sortOrder = [NSSortDescriptor sortDescriptorWithKey: @"self" ascending: NO];
    //level2List = [list sortedArrayUsingDescriptors: [NSArray arrayWithObject: sortOrder]];
    
    
    // sort using a function
    BOOL reverseSort = YES;
    level2List = [list sortedArrayUsingFunction:alphabeticSort context:&reverseSort];
 
    
    
    NSLog(@"level2 found: %d", (int)[level2List count]);
    
    [self.level3Table setHidden: YES];
    
    [self.level2Grid setHidden: NO];
    [self.level2Grid reloadData];
    if([level2List count] > 0)
    {
        [self.level2Grid scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UICollectionViewScrollPositionTop animated:YES];
    }
}

- (void) loadLevel3: (NSString *) src
{
    NSMutableArray *list = [NSMutableArray new];
    
    NSString *key = [src substringFromIndex: 2];
    key = [key stringByAppendingString:@"_"];
    
    NSLog(@"level3 files for: %@", src);
    for (NSString *file in directoryContents)
    {
        NSLog(@"file: %@", file);
        if([file hasPrefix: key] && [file hasSuffix: @".jpg"])
        {
            NSString *filekey = [file substringToIndex: [file length] - 4];
            [list addObject: filekey];
        }
    }
    NSSortDescriptor* sortOrder = [NSSortDescriptor sortDescriptorWithKey: @"self" ascending: NO];
    level3List = [list sortedArrayUsingDescriptors: [NSArray arrayWithObject: sortOrder]];

    NSLog(@"level3 found: %d", (int)[level3List count]);
    
    
    [self.level2Grid setHidden: YES];
    
    [self.level3Table setHidden: NO];
    [self.level3Table reloadData];
    if([level3List count] > 0)
    {
        [self.level3Table scrollToRowAtIndexPath: [NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }
}

- (void) loadLevel4: (NSString *) src
{}

@end
