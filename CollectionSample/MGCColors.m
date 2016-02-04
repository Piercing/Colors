//
//  MGCColors.m
//  CollectionSample
//
//  Created by MacBook Pro on 4/2/16.
//  Copyright © 2016 weblogmerlos.com. All rights reserved.
//

#import "MGCColors.h"

@implementation MGCColors

// Método que devuelve un color partiendo de un
// color con un máximo de gradiente que le indiquemos.
-(UIColor *) colorInGradientAt:(NSUInteger)current
                            to:(NSUInteger)maximum{
    
    // calculo el color actual
    float currentHue = (current *1.0f) / (maximum * 1.0f);
    
    return [UIColor colorWithHue:currentHue
                      saturation:1.0
                      brightness:0.8
                           alpha:1.0];
}

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
