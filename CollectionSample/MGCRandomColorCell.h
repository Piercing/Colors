//
//  MGCRandomColorCellCollectionViewCell.h
//  CollectionSample
//
//  Created by MacBook Pro on 4/2/16.
//  Copyright © 2016 weblogmerlos.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MGCRandomColorCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *hexView;
@property(nonatomic, strong) UIColor *color;

@end
