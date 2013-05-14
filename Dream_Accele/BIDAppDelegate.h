//
//  BIDAppDelegate.h
//  Dream_Accele
//
//  Created by Tzehan Su on 17/04/2013.
//  Copyright (c) 2013 Apress. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PdAudioController.h"
@class BIDViewController;

@interface BIDAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) BIDViewController *viewController;

@property(strong, nonatomic,readonly) PdAudioController *audioController;

@end
