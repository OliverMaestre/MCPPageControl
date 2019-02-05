//
//  PMPaginableScroll.h
//  LexusLoyalty
//
//  Created by Mario Chinchilla PlanetMedia on 16/10/15.
//  Copyright © 2015 Mario. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString * const kCurrentPage = @"currentPage";
static NSString * const kNumberOfPages = @"numberOfPages";

@protocol MCPPaginableScrollProtocol <NSObject>

/**
 *  Variable que devolverá el número de páginas a mostrar en el paginador. Esta variable debería ser rellenada por un delegado definido por el ScrollView en cuestión para mayor seguridad. El seteo de esta propiedad
 *  debe cambiar el numero de páginas del scroll.
 *
 *  @note La razón de esta variable es para mantener el anonimáto del delegado que puede ser tanto un UICollectionView, como un UITableView o un UIScrollView y que por lo tanto
 *  tienen distintos métodos para obtener su numero de páginas. Una vez esta variable se establezca, el paginador se cargará automáticamente.
 */
@property (nonatomic, assign, readonly) NSInteger numberOfPages;

/**
 *  Variable que devolverá la página actual en la que se encuentra el paginador. Si esta variable es seteada, se debe manejar el cambio de página.
 */
@property (nonatomic, assign, readonly) NSInteger currentPage;

/**
 *  Método que hace scroll a la página siguiente a la actual.
 */
-(void)scrollToNextPage;

/**
 *  Método que hace scroll a la página anterior de la actual.
 */
-(void)scrollToPreviousPage;

/**
 *  Métoo que hace scroll a la página pasáda por parámetro.
 *
 *  @param page Número de la página a la que se desea navegar
 */
-(void)scrollToPage:(NSUInteger)page;

@end
