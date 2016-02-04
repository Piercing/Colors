//
//  MGCColors.h
//  CollectionSample
//
//  Created by MacBook Pro on 4/2/16.
//  Copyright © 2016 weblogmerlos.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MGCColors : NSObject

// Method = > return UIColor aleatory random
-(UIColor *)randomColor;


-(UIColor *) colorInGradientAt:(NSUInteger)current
                            to:(NSUInteger)maximum;
@end
