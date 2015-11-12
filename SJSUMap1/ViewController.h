//
//  ViewController.h
//  SJSUMap1
//
//  Created by Apoorv on 11/8/15.
//  Copyright © 2015 Apoorv. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface ViewController : UIViewController <UIScrollViewDelegate,UIViewControllerRestoration,CLLocationManagerDelegate>


@property (strong, nonatomic) IBOutlet UIImageView *imageView;



@property (strong, retain) IBOutlet UIButton *buttonEng;
@property (strong, retain) IBOutlet UIButton *buttonKing;
@property (strong, retain) IBOutlet UIButton *buttonYu;
@property (strong, retain) IBOutlet UIButton *buttonPark;
@property (strong, retain) IBOutlet UIButton *buttonBbc;
@property (strong, retain) IBOutlet UIButton *buttonSu;
@property (strong, nonatomic) IBOutlet UIImageView *mapView;




// Action Button

- (IBAction)buttonKing:(id)sender;





// End Action Button

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
- (IBAction)handlePinch:(UIGestureRecognizer *)sender;
@property (strong,nonatomic) UIViewController *viewController1;

@property(nonatomic,strong) CLLocationManager *locationManager;

@end

