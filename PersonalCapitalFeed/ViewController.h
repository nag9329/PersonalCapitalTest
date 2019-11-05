//
//  ViewController.h
//  PersonalCapitalFeed
//
//  Created by Nagarjuna Ramagiri on 10/29/19.
//  Copyright © 2019 Nagarjuna Ramagiri. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout, UICollectionViewDelegate>

@property (strong, nonatomic) UICollectionView *collectionView;

@end

