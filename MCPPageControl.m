//
//  MCPPageControl.m
//  LexusLoyalty
//
//  Created by Mario Chinchilla PlanetMedia on 16/10/15.
//  Copyright © 2015 Mario. All rights reserved.
//

#import "MCPPageControl.h"
#import "MCPSinglePageDot.h"

#import "UIView+MCPConstraints.h"
#import "NSMutableArray+MCP.h"

@interface MCPPageControl()
@property (nonatomic, strong) NSMutableArray *arrayControlViews;
@property (nonatomic, strong) UIView *viewSelectedPage;
@end

@implementation MCPPageControl

-(void)dealloc{
    [self.observedScroll removeObserver:self forKeyPath:kCurrentPage];
    [self.observedScroll removeObserver:self forKeyPath:kNumberOfPages];
}

-(void)awakeFromNib{
    [super awakeFromNib];
    
    /**** Inicialización de variables ****/
    if(!self.activeColor)
        self.activeColor = [UIColor redColor];
    if(!self.inactiveColor)
        self.inactiveColor = [UIColor whiteColor];
    if(!self.activeBorderColor)
        self.activeBorderColor = [UIColor blackColor];
    if(!self.inactiveColor)
        self.inactiveColor = [UIColor blackColor];
    
    self.arrayControlViews = [NSMutableArray array];
    
    /**** Preparación de la vista ****/
    [self loadPageControl];
    
    /**** Observers ****/
    [self.observedScroll addObserver:self forKeyPath:kCurrentPage options:0 context:nil];
    [self.observedScroll addObserver:self forKeyPath:kNumberOfPages options:0 context:nil];
}

#pragma mark - Load/Prepare methods

-(void)loadPageControl{
    
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)]; // Eliminamos todas las posibles subvistas
    [self.arrayControlViews removeAllObjects];
    
    NSInteger numScrollPages = 0;
    if(self.observedScroll && [self.observedScroll respondsToSelector:@selector(numberOfPages)])
        numScrollPages = [self.observedScroll numberOfPages];
    
    if(!numScrollPages) return;
    
    CGFloat totalSpaceBetweenDots = (numScrollPages+1)*self.gapBetweenDots;
    CGFloat totalWidthOfDots = numScrollPages*self.dotSize;
    CGFloat width = totalSpaceBetweenDots+totalWidthOfDots;
    
    /**** La vista se ajustará al tamaño y cantidad de los puntos que hayan en el control ****/
    if(self.translatesAutoresizingMaskIntoConstraints){
        CGPoint oldCenter = self.center;
        CGRect aFrame = self.frame;
        aFrame.size.width = width; aFrame.size.height = self.dotSize;
        self.frame = aFrame; self.center = oldCenter;
    }else{
        [self mcp_modifyConstraintWithAttribute:NSLayoutAttributeWidth withConstantValue:width makingLayoutChanges:YES];
        [self mcp_modifyConstraintWithAttribute:NSLayoutAttributeHeight withConstantValue:self.dotSize makingLayoutChanges:YES];
    }
    
    for(NSInteger i = 0; i<numScrollPages; i++){
        MCPSinglePageDot *singleDot = [[MCPSinglePageDot alloc] initWithSize:self.dotSize andBackgroundColor:self.inactiveColor andBorderColor:self.inactiveBorderColor andBorderWidth:self.borderWidth];
        
        CGFloat centerX = (width/(numScrollPages+1))*(i+1);
        singleDot.center = CGPointMake(centerX, self.bounds.size.height/2);
        
        [self addSubview:singleDot];
        [self.arrayControlViews mcp_safeAddObject:singleDot];
    }
    
    self.viewSelectedPage = [[MCPSinglePageDot alloc] initWithSize:self.activeDotSize andBackgroundColor:self.activeColor andBorderColor:self.activeBorderColor andBorderWidth:self.borderWidth];
    self.viewSelectedPage.center = [(UIView*)[self.arrayControlViews firstObject] center];
    [self addSubview:self.viewSelectedPage];
}

#pragma mark - Change currentPage

-(void)currentPageHasChanged{
    
    NSInteger currentPage = 0;
    if(self.observedScroll && [self.observedScroll respondsToSelector:@selector(currentPage)])
        currentPage = [self.observedScroll currentPage];
    
    UIView *destinationDot = [self.arrayControlViews objectAtIndex:currentPage];
    [UIView animateWithDuration:.2f animations:^{
        self.viewSelectedPage.center = destinationDot.center;
    }completion:^(BOOL finished) {}];
}

#pragma mark - Observe methods

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    if([keyPath isEqualToString:kCurrentPage])
        [self currentPageHasChanged];
    else if([keyPath isEqualToString:kNumberOfPages])
        [self loadPageControl];
}

@end
