//
//  MCPPageControl.h
//  LexusLoyalty
//
//  Created by Mario Chinchilla PlanetMedia on 16/10/15.
//  Copyright © 2015 Mario. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MCPPaginableScrollProtocol.h"

@interface MCPPageControl : UIView

/**** PageControl ****/
@property (nonatomic, weak) IBOutlet NSObject<MCPPaginableScrollProtocol> *observedScroll;

/**** Background ****/
@property (nonatomic, assign) IBInspectable NSUInteger gapBetweenDots;
@property (nonatomic, assign) IBInspectable NSUInteger dotSize;
@property (nonatomic, assign) IBInspectable NSUInteger activeDotSize;
@property (nonatomic, strong) IBInspectable UIColor *activeColor;
@property (nonatomic, strong) IBInspectable UIColor *inactiveColor;

/**** Border ****/
@property (nonatomic, strong) IBInspectable UIColor *activeBorderColor;
@property (nonatomic, strong) IBInspectable UIColor *inactiveBorderColor;
@property (nonatomic, assign) IBInspectable CGFloat borderWidth;

/**
 *  Este método indica cuando el scroll sabe cuantos items tiene para que el pageControl pueda empezar a dibujar los puntos necesarios. Este método debe llamarse cuando el scroll
 *  en cuestión ya tenga el número de páginas completo.
 */
-(void)loadPageControl;

@end
