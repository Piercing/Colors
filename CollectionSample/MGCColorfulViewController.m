//
//  MGCColorfulViewController.m
//  CollectionSample
//
//  Created by MacBook Pro on 4/2/16.
//  Copyright © 2016 weblogmerlos.com. All rights reserved.
//

#import "MGCColorfulViewController.h"
#import "MGCColors.h"

@interface MGCColorfulViewController ()
@property(strong, nonatomic)MGCColors *model;
// Otra de forma de definir una constante
//+(NSInteger) maxRandomColorToDisplay;
@end

@implementation MGCColorfulViewController

// Otras formaa de definir una constante
static NSString * const reuseIdentifier = @"Cell";
// Cantidad de colores aleatorios
static NSInteger  const maxRandomColorToDisplay = 104;// => + (NSInteger) maxRandomColorToDisplay{return 104;};
// Cuantas celdas para colores de gradiente voy a tener
static NSInteger const maxGradientColorsToDisplay = 104;
// Necesito un ID para las celdas de gradiente para más
// adelante añadirles algún extra y así puedo distinguirlas.
static NSString * const gradientColorCellId = @"gradientColorCell";
// Necesito las dos secciones
static NSInteger const randomColorSection = 1;
static NSInteger const gradientColorSection = 0;

#pragma mark -  Class methods
//+ (NSInteger) maxRandomColorToDisplay{return 104;};


#pragma mark - Init
-(id) initWithModel: (MGCColors *) model
             layout:(UICollectionViewLayout *)layout{
    
    if(self = [super initWithCollectionViewLayout:layout]){
        
        _model = model;
        self.title = @"United Color of MGC";
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    // Register cell classes, ya que utilizamos celdas por defecto,
    // si utilizamos celdas personalizadas registramos el nib o XIB.
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    // Registro el otro tipo de celda
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:gradientColorCellId];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
    
    if (section == randomColorSection) {
        return maxRandomColorToDisplay;
    }else{
        return maxGradientColorsToDisplay;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell;
    
    if (indexPath.section == randomColorSection) {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier
                                                         forIndexPath:indexPath];
        // Le doy un color aleatorio a la ceda
        cell.backgroundColor = [self.model randomColor];
    }else{
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:gradientColorCellId
                                                         forIndexPath:indexPath];
        
        // 'colorInGradientAt:indexPath.item' => celda actual
        cell.backgroundColor = [self.model colorInGradientAt:indexPath.item
                                                          to:maxGradientColorsToDisplay];
    }
    return cell;
}

#pragma mark <UICollectionViewDelegate>

/*
 // Uncomment this method to specify if the specified item should be highlighted during tracking
 - (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
 }
 */

/*
 // Uncomment this method to specify if the specified item should be selected
 - (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
 return YES;
 }
 */

/*
 // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
 - (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
 }
 
 - (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
 }
 
 - (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
 }
 */

@end
