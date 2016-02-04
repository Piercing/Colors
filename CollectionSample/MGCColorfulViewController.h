//
//  MGCColorfulViewController.h
//  CollectionSample
//
//  Created by MacBook Pro on 4/2/16.
//  Copyright © 2016 weblogmerlos.com. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MGCColors;

@interface MGCColorfulViewController : UICollectionViewController

-(id) initWithModel: (MGCColors *) model
             layout:(UICollectionViewLayout *)layout;
@end
