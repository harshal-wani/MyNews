//
//  AbstractViewController.m
//  CricketNews
//
//  Created by Harshal Wani on 8/3/16.
//  Copyright © 2016 Harshal Wani. All rights reserved.
//

#import "AbstractViewController.h"
#import "CommonImports.h"


@implementation AbstractViewController

#pragma mark - View Life Cycle -

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationBar.userInteractionEnabled = YES;
    self.view.backgroundColor = [UIUtils colorFromHexColor:VIEW_BG_COLOR];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}
#pragma mark - Navigation Bar

- (void)addNavigationBar {
    
    if (self.navigationBar) {
        return;
    }
    self.navigationBar = [UIUtils createImageView:nil];
    self.navigationBar.backgroundColor = [UIUtils colorFromHexColor:GREEN_HEADER_HEX_1BB38B];
    [self.view addSubview:self.navigationBar];
    
    [self.navigationBar autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0.0f];
    [self.navigationBar autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0.0f];
    [self.navigationBar autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0.0f];

    [self.navigationBar autoSetDimension:ALDimensionHeight toSize:PTPX(60)];
        
    
}
- (void)addNavBarTitle:(NSString *)navTitle
{
    self.navigationBarTitle = [UIUtils createLabelWithText:navTitle
                                          withTextColorHex:WHITE_HEX_FFFFFF
                                         withTextAlignment:NSTextAlignmentCenter
                                                  withFont:HELVETICA_NEUE
                                               andFontSize:PTPX(20)];
    
    
    
    [self.navigationBar addSubview:self.navigationBarTitle];
    
    [self.navigationBarTitle autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [self.navigationBarTitle autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:PTPX(10)];
    [self.navigationBarTitle autoSetDimension:ALDimensionWidth toSize:PTPX(220)];
    
}
- (void)addNavBarLeftButtonWithImage:(NSString*)imageName {
    
    UIButton *leftButton = [UIUtils createButtonWithImage:imageName
                                           andEventTarget:self
                                                andAction:@selector(navigationBarLeftButtonClicked)
                                                   andTag:0];
    
    self.navigationBarLeftButton = leftButton;

    [self.navigationBar addSubview:leftButton];
    
        [leftButton autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0.0f];
        [leftButton autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:PTPX(10)];
        [leftButton autoSetDimension:ALDimensionWidth toSize:PTPX(60)];
        [leftButton autoSetDimension:ALDimensionHeight toSize:PTPX(28)];
            
}
- (void)addNavBarRightButtonWithImage:(NSString*)imageName {
    
    UIButton *rightButton = [UIUtils createButtonWithImage:imageName
                                            andEventTarget:self
                                                 andAction:@selector(navigationBarRightButtonClicked)
                                                    andTag:0];
    
    self.navigationBarRightButton = rightButton;
    
    [self.navigationBar addSubview:rightButton];
    
    [rightButton autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0.0f];
    [rightButton autoSetDimension:ALDimensionWidth toSize:PTPX(40)];
    [rightButton autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:PTPX(10)];
    [rightButton autoSetDimension:ALDimensionHeight toSize:PTPX(26)];
    
}
#pragma mark – Event Handling -

- (void)navigationBarRightButtonClicked {
    
}
- (void)navigationBarLeftButtonClicked {
        
}


@end
