//
//  ViewController.m
//  SJSUMap1
//
//  Created by Apoorv on 11/8/15.
//  Copyright © 2015 Apoorv. All rights reserved.
//

#define SHOW_DETAIL_VIEW_SEGUE @"showDetailView"

#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)


#import "ViewController.h"
#import "DetailsViewController.h"


@interface ViewController ()

@property UIButton *selectedButton;


@end

@implementation ViewController



+(UIViewController*) viewControllerWithRestorationIdentifierPath:(NSArray *)identifierComponents coder:(NSCoder *)coder {
    ViewController* vc;
    UIStoryboard* sb = [coder decodeObjectForKey:UIStateRestorationViewControllerStoryboardKey];
    
    if (sb) {
        vc=(ViewController *)[sb instantiateViewControllerWithIdentifier:@"viewController1"];
        vc.restorationIdentifier = [identifierComponents lastObject];
        vc.restorationClass = [ViewController class];
        }
    return vc;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    DetailsViewController *detailsViewController = (DetailsViewController *) segue.destinationViewController;
    
    if (self.selectedButton == self.buttonKing) {

        detailsViewController.buildingTitle = @"King Library";
        NSLog(@"kings button selected");
        detailsViewController.buildingAddress=@"Dr. Martin Luther King, Jr. Library, 150 East San Fernando Street, San Jose, CA 95112";
        detailsViewController.buildingImageName= @"engbld.jpg";
        
    }
}

- (void)encodeRestorableStateWithCoder:(NSCoder *)coder {
    [super encodeRestorableStateWithCoder:coder];
    [coder encodeObject:self.scrollView forKey:@"scrollViewRestore"];
}

- (void)decodeRestorableStateWithCoder:(NSCoder *)coder
{
   [super decodeRestorableStateWithCoder:coder];
    self.scrollView=[coder decodeObjectForKey:@"scrollViewRestore"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
    [self.scrollView setMaximumZoomScale:10.0f];
    [self.scrollView setClipsToBounds:YES];
    self.restorationIdentifier=@"scrollViewRestore";
    self.restorationClass=[self class];
    [self.locationManager requestWhenInUseAuthorization];
    [self.locationManager requestAlwaysAuthorization];
    self.locationManager = [[CLLocationManager alloc] init];
    
    self.locationManager.delegate = self;
    if(IS_OS_8_OR_LATER){
        NSUInteger code = [CLLocationManager authorizationStatus];
        if (code == kCLAuthorizationStatusNotDetermined && ([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)] || [self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)])) {
            // choose one request according to your business.
            if([[NSBundle mainBundle] objectForInfoDictionaryKey:@"NSLocationAlwaysUsageDescription"]){
                [self.locationManager requestAlwaysAuthorization];
            } else if([[NSBundle mainBundle] objectForInfoDictionaryKey:@"NSLocationWhenInUseUsageDescription"]) {
                [self.locationManager  requestWhenInUseAuthorization];
            } else {
                NSLog(@"Info.plist does not contain NSLocationAlwaysUsageDescription or NSLocationWhenInUseUsageDescription");
            }
        }
    }
    [self.locationManager startUpdatingLocation];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [self.scrollView bringSubviewToFront:self.buttonKing];
}

#pragma mark - CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
    
 
    
    UIAlertController *errorAlerts = [UIAlertController alertControllerWithTitle:@"Error" message:@"Failed to Get YOur Location" preferredStyle:UIAlertControllerStyleAlert];

}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"didUpdateToLocation: %@", newLocation);
    CLLocation *currentLocation = newLocation;
    
    if (currentLocation != nil) {
        NSString *longitude = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.longitude];
        NSString *latitude = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.latitude];
        NSLog(@"Latitude  = %@", latitude);
        NSLog(@"Longitude = %@", longitude);
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIView *) viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.view;
}

- (IBAction)handlePinch:(UIGestureRecognizer *) sender {
    
    CGFloat lastScaleFactor=1;
    CGFloat factor=[(UIPinchGestureRecognizer *) sender scale];
    if(factor>1)
    { // zoom in
        _imageView.transform=CGAffineTransformMakeScale(lastScaleFactor + (factor -1), lastScaleFactor + (factor-1));
    }else { // zoom out
        _imageView.transform=CGAffineTransformMakeScale(lastScaleFactor * factor, lastScaleFactor * factor);
    }
    if(sender.state==UIGestureRecognizerStateEnded)
    {
        if(factor>1)
            lastScaleFactor += (factor -1);
        else
            lastScaleFactor +=factor;
    }
}


- (IBAction)buttonKing:(id)sender {
    
    self.selectedButton = (UIButton *)sender;

    [self performSegueWithIdentifier:SHOW_DETAIL_VIEW_SEGUE sender:nil];
}
@end
