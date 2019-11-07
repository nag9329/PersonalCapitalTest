//
//  ViewController.m
//  PersonalCapitalFeed
//
//  Created by Nagarjuna Ramagiri on 10/29/19.
//  Copyright © 2019 Nagarjuna Ramagiri. All rights reserved.
//

#import "ViewController.h"
#import "UIView+Constraints.h"
#import "FeedCollectionViewCell.h"
#import "ProminentCollectionViewCell.h"
#import "NetworkRequest.h"
#import "ParseOperation.h"
#import "FeedImageDownloader.h"
#import "FeedDetailViewController.h"

static NSString *const feedCellIdentifier = @"FeedCollectionViewCellIdentifier";
static NSString *const prominentCellIdentifier = @"ProminentCollectionViewCellIdentifier";

@interface ViewController ()

@property (strong, nonatomic) NSArray<Feed *> *feeds;
@property (nonatomic) UIEdgeInsets sectionInsets;
@property (nonatomic) CGFloat itemsPerRow;
// the set of FeedImageDownloader objects for each feed
@property (nonatomic, strong) NSMutableDictionary *imageDownloadsInProgress;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;

@end

@implementation ViewController

#pragma mark - View Controller Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.navigationItem.title = @"Research & Insights";
    UIBarButtonItem *refreshButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refreshFeeds)];
    self.navigationItem.rightBarButtonItem = refreshButton;
    
    self.feeds = [NSArray array];
    self.imageDownloadsInProgress = [NSMutableDictionary dictionary];
    [self setupCollectionView];
    [self setupActivityIndicator];
    [self fetchFeeds];
}

// -------------------------------------------------------------------------------
//    dealloc
//  If this view controller is going away, we need to cancel all outstanding downloads.
// -------------------------------------------------------------------------------
- (void)dealloc
{
    // terminate all pending download connections
    [self terminateAllDownloads];
}

// -------------------------------------------------------------------------------
//    didReceiveMemoryWarning
// -------------------------------------------------------------------------------
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    // terminate all pending download connections
    [self terminateAllDownloads];
}

-(void) viewWillDisappear:(BOOL) animated
{
    [super viewWillDisappear:animated];
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    [self.collectionView.collectionViewLayout invalidateLayout];
    
    [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        
    } completion:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        //[self.collectionView reloadData];//this works but reloading the view collapses any expanded cells.
        [self.collectionView performBatchUpdates:nil completion:nil];
    }];
}

#pragma mark - View setup methods

- (void)setupActivityIndicator
{
    self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleLarge];
    self.activityIndicator.alpha = 1.0;
    [self.view addSubview:self.activityIndicator];
    [self.activityIndicator addConstraintsToView:self.view isCenterHorizontally:YES isCenterVertically:YES];
}

- (void)setupCollectionView
{
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc] init];
    self.collectionView=[[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:layout];
    [self.collectionView setDataSource:self];
    [self.collectionView setDelegate:self];
    
    self.sectionInsets = UIEdgeInsetsMake(20, 20, 20, 20);
    if([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
        self.itemsPerRow = 3;
    } else {
        self.itemsPerRow = 2;
    }
    
    [self.collectionView registerClass:[ProminentCollectionViewCell class] forCellWithReuseIdentifier:prominentCellIdentifier];
    [self.collectionView registerClass:[FeedCollectionViewCell class] forCellWithReuseIdentifier:feedCellIdentifier];
    [self.collectionView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:self.collectionView];
    
    [self.collectionView addConstraintsToView:self.view leadingOffset:0 isleadingConstraintActive:YES topOffset:0 isTopConstraintActive:YES bottomOffset:0 isBottomConstraintActive:YES trailingOffset:0 isTrailingConstraintActive:YES];
}

- (void)fetchFeeds
{
    [self.activityIndicator startAnimating];
    [[NetworkRequest sharedManager] requestFeedsWithSuccess:^(NSArray *feeds) {
        self.feeds = feeds;
        dispatch_async(dispatch_get_main_queue(), ^(void){
            [self.activityIndicator stopAnimating];
            [self.collectionView reloadData];
        });
    } failure:^(NSString * _Nonnull failureReason, NSInteger statusCode) {
        //for demo prurpose print to the log
        NSLog(@"Failure: %@", failureReason);
    }];
}

- (void)refreshFeeds
{
    [self fetchFeeds];
}

// -------------------------------------------------------------------------------
//    terminateAllDownloads
// -------------------------------------------------------------------------------
- (void)terminateAllDownloads
{
    // terminate all pending download connections
    NSArray *allDownloads = [self.imageDownloadsInProgress allValues];
    [allDownloads makeObjectsPerformSelector:@selector(cancelDownload)];
    
    [self.imageDownloadsInProgress removeAllObjects];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (self.feeds.count == 0) {
        return 0;
    }
    return self.feeds.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        ProminentCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:prominentCellIdentifier forIndexPath:indexPath];
        Feed *feed = self.feeds[indexPath.row];
        cell.titleView.text = feed.feedTitle;
        cell.summaryView.text = feed.feedSummary;
        if(!feed.feedImage) {
            if (self.collectionView.dragging == NO && self.collectionView.decelerating == NO)
            {
                [self startIconDownload:feed forIndexPath:indexPath];
            }
            // if a download is deferred or in progress, return a placeholder image
            cell.imageView.image = [UIImage imageNamed:@"Placeholder.png"];
        } else {
            cell.imageView.image = feed.feedImage;
        }
        return cell;
    } else {
        FeedCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:feedCellIdentifier forIndexPath:indexPath];
        Feed *feed = self.feeds[indexPath.row];
        cell.titleView.text = feed.feedTitle;
        if(!feed.feedImage) {
            if (self.collectionView.dragging == NO && self.collectionView.decelerating == NO)
            {
                [self startIconDownload:feed forIndexPath:indexPath];
            }
            // if a download is deferred or in progress, return a placeholder image
            cell.imageView.image = [UIImage imageNamed:@"Placeholder.png"];
        } else {
            cell.imageView.image = feed.feedImage;
        }
        cell.layer.borderWidth = 0.5f;
        cell.layer.borderColor = [UIColor grayColor].CGColor;
        return cell;
    }
}

#pragma mark - Collection View Flow Layout Delegate

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat paddingSpace = self.sectionInsets.left * (self.itemsPerRow + 1);
    CGFloat availableWidth = self.view.frame.size.width - paddingSpace;
    CGFloat widthPerItem = availableWidth/self.itemsPerRow;
    if(indexPath.row == 0) {
        return CGSizeMake(availableWidth + 20, availableWidth * 0.75);
    }
    return CGSizeMake(widthPerItem, widthPerItem);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return self.sectionInsets;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return self.sectionInsets.left;
}

#pragma mark - Collection View Delegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    FeedDetailViewController *fdvc = [[FeedDetailViewController alloc] init];
    fdvc.articleLink = [NSString stringWithFormat:@"%@?displayMobileNavigation=0", self.feeds[indexPath.row].feedLink];
    fdvc.articleTitle = self.feeds[indexPath.row].feedTitle;
    [self.navigationController pushViewController:fdvc animated:YES];
}

#pragma mark - UIScrollViewDelegate

// -------------------------------------------------------------------------------
//    scrollViewDidEndDragging:willDecelerate:
//  Load images for all onscreen rows when scrolling is finished.
// -------------------------------------------------------------------------------
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (!decelerate)
    {
        [self loadImagesForOnscreenRows];
    }
}

// -------------------------------------------------------------------------------
//    scrollViewDidEndDecelerating:scrollView
//  When scrolling stops, proceed to load the app icons that are on screen.
// -------------------------------------------------------------------------------
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self loadImagesForOnscreenRows];
}

#pragma mark - Helper Methods

// -------------------------------------------------------------------------------
//    startIconDownload:forIndexPath:
// -------------------------------------------------------------------------------
- (void)startIconDownload:(Feed *)feed forIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [self.collectionView cellForItemAtIndexPath:indexPath];
    if ([cell isKindOfClass:[ProminentCollectionViewCell class]]) {
        ProminentCollectionViewCell *theCell = (ProminentCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
        [theCell.activityIndicator startAnimating];
    } else {
        FeedCollectionViewCell *theCell = (FeedCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
        [theCell.activityIndicator startAnimating];
    }
    FeedImageDownloader *imageDownloader = (self.imageDownloadsInProgress)[indexPath];
    if (imageDownloader == nil)
    {
        imageDownloader = [[FeedImageDownloader alloc] init];
        imageDownloader.feed = feed;
        [imageDownloader setCompletionHandler:^{
            if ([cell isKindOfClass:[ProminentCollectionViewCell class]]) {
                ProminentCollectionViewCell *theCell = (ProminentCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
                theCell.imageView.image = feed.feedImage;
                [theCell.activityIndicator stopAnimating];
            } else {
                FeedCollectionViewCell *theCell = (FeedCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
                theCell.imageView.image = feed.feedImage;
                [theCell.activityIndicator stopAnimating];
            }
            // Remove the ImageDownloader from the in progress list.
            // This will result in it being deallocated.
            [self.imageDownloadsInProgress removeObjectForKey:indexPath];
            
        }];
        (self.imageDownloadsInProgress)[indexPath] = imageDownloader;
        [imageDownloader startDownload];
    }
}

// -------------------------------------------------------------------------------
//    loadImagesForOnscreenRows
//  This method is used in case the user scrolled into a set of cells that don't
//  have their feed icons yet.
// -------------------------------------------------------------------------------
- (void)loadImagesForOnscreenRows
{
    if (self.feeds.count > 0)
    {
        NSArray *visiblePaths = [self.collectionView indexPathsForVisibleItems];
        for (NSIndexPath *indexPath in visiblePaths)
        {
            Feed *feed = (self.feeds)[indexPath.row];
            
            // Avoid the image download if the app already has an image
            if (!feed.feedImage)
            {
                [self startIconDownload:feed forIndexPath:indexPath];
            }
        }
    }
}

@end
