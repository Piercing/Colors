//
//  MGCRandomColorCellCollectionViewCell.m
//  CollectionSample
//
//  Created by MacBook Pro on 4/2/16.
//  Copyright © 2016 weblogmerlos.com. All rights reserved.
//

#import "MGCRandomColorCell.h"
#import "UIColor+Colorful.h"

@interface MGCRandomColorCell ()
@property (nonatomic)BOOL shouldAnimatedChangeOfColor;
@end

@implementation MGCRandomColorCell


#pragma mark - Init & Dealloc
// Montamos el chiringo de KVO.
// La vista va a observar la propiedad color por KVO.
// No se recominedo aquí mandar a super 'awekeFromNib'.
-(void)awakeFromNib{
    
    self.shouldAnimatedChangeOfColor = NO;
    [self setUpKVO];
    
}

// Desmontamos KVO cuando el objeto vaya a ser destruido
// No mandar aquí nunca 'dealloc' a super, no podemos.
-(void)dealloc{
    
    [self tearDownKVO];
}

#pragma mark - View Lifecycle
// Se utiliza para devolver a la celda a un estado nulo o
// inicial cuando en ésta no va a habe ninguna animación.
-(void)prepareForReuse{
    [super prepareForReuse];
    
    self.shouldAnimatedChangeOfColor = NO;
    self.color = [UIColor x11FloralWhiteColor];
}

#pragma mark - KVO
-(void)setUpKVO{
    
    // Observamos aquí la propiedad color
    [self addObserver:self
           forKeyPath:@"color"
              options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld
              context:NULL];
}

-(void)tearDownKVO{
    
    // Me doy de baja
    [self removeObserver:self
              forKeyPath:@"color"];
}

// Implemento el mensaje que me van a enviar
-(void)observeValueForKeyPath:(NSString *)keyPath
                     ofObject:(id)object
                       change:(NSDictionary<NSString *,id> *)change
                      context:(void *)context{
    
    self.hexView.text = [self.color hexString];
    
    float duration = 0.0f;
    // Si debe de cambiar la animación
    // del color le pongo una duración real
    if(self.shouldAnimatedChangeOfColor){
        duration = 0.6f;
    }
    // Animación
    [UIView animateWithDuration:0.6
                     animations:^{
                         self.backgroundColor = self.color;
                         self.hexView.textColor = [self.color contrastingTextColor];
                     }];
    
    // Al terminar, cuando devuelve, lo devuelvo a YES.
    self.shouldAnimatedChangeOfColor = YES;
    
}





@end
