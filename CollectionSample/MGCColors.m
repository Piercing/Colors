//
//  MGCColors.m
//  CollectionSample
//
//  Created by MacBook Pro on 4/2/16.
//  Copyright © 2016 weblogmerlos.com. All rights reserved.
//

#import "MGCColors.h"

@implementation MGCColors


-(UIColor *)randomColor{

    // return UIColor => Method factory
    return [UIColor colorWithHue:[self randomFloat]
                      saturation:1.0
                      brightness:[self randomFloat]
                           alpha:[self randomFloat]];
    
    
}

-(float)randomFloat{
    
    // Alternativa algo mejor al random para crear números alternativos.
    return (arc4random() % 255) / 255.0f;
}



@end
