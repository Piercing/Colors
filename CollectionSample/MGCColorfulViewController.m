//
//  MGCColorfulViewController.m
//  CollectionSample
//
//  Created by MacBook Pro on 4/2/16.
//  Copyright © 2016 weblogmerlos.com. All rights reserved.
//

#import "MGCColorfulViewController.h"
#import "MGCColors.h"
#import "MGCRandomColorCell.h"
#import "UIColor+Colorful.h"

@interface MGCColorfulViewController ()
// Modelo
@property(strong, nonatomic)MGCColors *model;
// Cantidad de colores aleatorios
@property (nonatomic)NSInteger maxRandomColorToDisplay;
@end

@implementation MGCColorfulViewController

// Otras formaa de definir una constante
static NSString * const reuseIdentifier = @"Cell";


// Cuantas celdas para colores de gradiente voy a tener
static NSInteger const maxGradientColorsToDisplay = 104;
// Necesito un ID para las celdas de gradiente para más
// adelante añadirles algún extra y así puedo distinguirlas.
static NSString * const gradientColorCellId = @"gradientColorCell";
// Necesito un ID para las celdas random para más
// adelante añadirles algún extra y así puedo distinguirlas.
static NSString * const randomColorCellId = @"randomColor";

// Necesito las dos secciones
static NSInteger const randomColorSection = 0;
static NSInteger const gradientColorSection = 1;



// Constante para el tipo de vista para las cabeceras
static NSString * const sectionHeaderId = @"sectionHeaderId";

#pragma mark - Properties


#pragma mark -  Class methods
//+ (NSInteger) maxRandomColorToDisplay{return 104;};


#pragma mark - Init
-(id) initWithModel: (MGCColors *) model
             layout:(UICollectionViewLayout *)layout{
    
    if(self = [super initWithCollectionViewLayout:layout]){
        
        _model = model;
        self.title = @"United Color of MGC";
        _maxRandomColorToDisplay = 104;
    }
    return self;
}

#pragma mark - View Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    // Register cell classes, ya que utilizamos celdas por defecto,
    // si utilizamos celdas personalizadas registramos el nib o XIB.
    //[self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    [self registerSectionHeaderCell];
    // Registro el otro tipo de celda
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:gradientColorCellId];
    // Registro el tipo de vista para las cabeceras, esta es la que se usa para pies y cabeceras.
    [self.collectionView registerClass:[UICollectionReusableView class]
            forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                   withReuseIdentifier:sectionHeaderId];
    
    // Creo un botón para añadir colores aleatorios
    UIBarButtonItem *addColor = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                             target:self
                                                                             action:@selector(addNewRandomColor:)];
    
    // Añado el botón a la barra
    self.navigationItem.rightBarButtonItem = addColor;
    
}

-(void)registerSectionHeaderCell{
    
    // Leo el nib
    UINib *nib = [UINib nibWithNibName:@"MGCRandomColorCell" bundle:nil];
    
    // Lo registro
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:randomColorCellId];
    
}

#pragma mark - Memory management
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
        return  self.maxRandomColorToDisplay;
    }else{
        return maxGradientColorsToDisplay;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == randomColorSection) {
        
        // Pido a ver si tiene alguna celda por ahí
        MGCRandomColorCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:randomColorCellId
                                                                             forIndexPath:indexPath];
        
        cell.color = [self.model randomColor];
        return cell;
        
    }else{
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:gradientColorCellId
                                                                               forIndexPath:indexPath];
        
        // 'colorInGradientAt:indexPath.item' => celda actual
        cell.backgroundColor = [self.model colorInGradientAt:indexPath.item
                                                          to:maxGradientColorsToDisplay];
        return cell;
    }
    
}

-(UICollectionReusableView *) collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionReusableView *supView;
    
    // si es una cabecera
    if (kind == UICollectionElementKindSectionHeader) {
        // Reciclamos un header si lo hay, lo configuramos y lo devolvemos.
        // Le pido a la collectionView si tiene alguno por ahí
        supView = [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                     withReuseIdentifier:sectionHeaderId
                                                            forIndexPath:indexPath];
        
        // Configuro la cabecera
        supView.backgroundColor = [UIColor colorWithWhite:0.65
                                                    alpha:1.0];
        
        // Compruebo si tiene subvistas para borrarlas antes de reusarlas
        // y no sobreescribir texto en el label de la vista de la cabecera.
        // La forma de hacerlo es con 'prepareForReuse', se verá más adelante.
        // Toda vista tiene una propiedad que es un array de subvistas llamada 'subviews'
        // Recorremos todas estas subvistas y vamos borrando su contenido antes de reutilizarla.
        // No podemos decirle una vista que elimine todas sus subvistas. Para eliminar una vista
        // de una jerarquía tenemos que decirle a la subvista: 'quítate de tu supervista', y para
        // añadirlo es al revés, le decimos a la supervista añade esto.
        for (UIView *each in supView.subviews) {
            [each removeFromSuperview];
        }
        
        
        // Le meto una etiqueta, dependiendo de la sección serán colores aleatorios o gradientes.
        // Le endoso el mismo tamaño que tenga la vista.
        UILabel *title = [[UILabel alloc]initWithFrame:supView.bounds];
        // Le asigno un color
        title.textColor = [UIColor whiteColor];
        // Le endoso a la subvista el título.
        [supView addSubview:title];
        // Si la sección es de colores grandientes => título: Gradient
        if(indexPath.section == gradientColorSection){
            title.text = @"Gradient";
            // Sino => título: Random
        }else{
            title.text = @"Random";
        }
    }
    // Devuelvo la subvista
    return supView;
}

#pragma mark - Actions
-(void) addNewRandomColor:(id)sender{
    
    // Primero actualizo el modelo indicándole que a los colores aleatorios
    // le sume uno para añadirlo y mostrarlo en su sección en la CollectionView.
    self.maxRandomColorToDisplay = self.maxRandomColorToDisplay + 1;
    
    // Le decimos ahora a la collectionView que añada una nueva celda para el nuevo color
    // o que añada al array del indexpaths que añada las celdas según colores se creen, es
    // decir, le decimos, por ejemplo, se han insertado tres colores nuevos en la seeción 0.
    // Lo que hace la collectionView a continuación es pedirle a su DataSource, oye dame éste,
    // éste y e´ste de la sección 0.
    // En 'indexPathForItem' le indicamos la posición dentro de la sección => 0 y en la sección => 'randomColorSection'
    [self.collectionView insertItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:0 inSection:randomColorSection]]];
}

#pragma mark <UICollectionViewDelegate>
-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == randomColorSection) {
        MGCRandomColorCell *cell = (MGCRandomColorCell*)[collectionView cellForItemAtIndexPath:indexPath];
        cell.color = [cell.color complementaryColor];
    }
}

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
