//
//  BIDViewController.h
//  Dream_Accele
//
//  Created by Tzehan Su on 17/04/2013.
//  Copyright (c) 2013 Apress. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PdDispatcher.h"
#import <CoreMotion/CoreMotion.h>
@interface BIDViewController : UIViewController{
    PdDispatcher *dispatcher;
    void *patch;
}
- (IBAction)start:(id)sender;
- (IBAction)stop:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *accelero_label;

//@property (assign, nonatomic) CMAcceleration acceleration;
@end
