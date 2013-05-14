//
//  BIDViewController.m
//  Dream_Accele
//
//  Created by Tzehan Su on 17/04/2013.
//  Copyright (c) 2013 Apress. All rights reserved.
//

#import "BIDViewController.h"
#import <CoreMotion/CoreMotion.h>
#define kUpdateInterval    (1.0f / 60.0f)

@interface BIDViewController ()
@property (strong, nonatomic) CMMotionManager *motionManager;
//@property (strong, nonatomic) NSOperationQueue *queue;
@property (strong, nonatomic) NSTimer *updateTimer;
@end

@implementation BIDViewController
double PanValue = 0;
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    dispatcher = [[PdDispatcher alloc]init];
    [PdBase setDelegate:dispatcher];
    patch = [PdBase openFile:@"delay_patch_Accele.pd" path:[[NSBundle mainBundle]resourcePath]];
    if(!patch){
      NSLog(@"Failed to open patch");
    }
    self.motionManager = [[CMMotionManager alloc] init];
    if (self.motionManager.accelerometerAvailable) {
        self.motionManager.accelerometerUpdateInterval = kUpdateInterval;
        [self.motionManager startAccelerometerUpdates];
    } else {
        self.accelero_label.text = @"This device has no accelerometer.";
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidUnload    {
    [super viewDidUnload];
    [PdBase closeFile:patch];
    [PdBase setDelegate:nil];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.updateTimer = [NSTimer scheduledTimerWithTimeInterval:kUpdateInterval
                                                        target:self
                                                      selector:@selector(update)
                                                      userInfo:nil
                                                       repeats:YES];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self.updateTimer invalidate];
    self.updateTimer = nil;
}

- (IBAction)start:(id)sender {
    [PdBase sendBangToReceiver:@"start"];
}

- (IBAction)stop:(id)sender {
    [PdBase sendBangToReceiver:@"stop"];
}


-(void)update{
    if (self.motionManager.accelerometerAvailable) {
        CMAccelerometerData *accelerometerData = self.motionManager.accelerometerData;
        self.accelero_label.text  = [NSString stringWithFormat:
                                         @"Accelerometer\n---\nx: %+.2f\ny: %+.2f\nz: %+.2f",
                                         accelerometerData.acceleration.x,
                                         accelerometerData.acceleration.y,
                                         accelerometerData.acceleration.z];
        //offset of range from -1 to 1 --> 0 to 1
        PanValue = (accelerometerData.acceleration.x + 1)/2;
        
        [PdBase sendFloat:PanValue toReceiver:@"pan"];
    }
}

@end
