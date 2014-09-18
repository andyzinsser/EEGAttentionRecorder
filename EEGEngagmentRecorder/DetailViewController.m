//
//  DetailViewController.m
//  EEGEngagmentRecorder
//
//  Created by Andy Zinsser on 9/17/14.
//  Copyright (c) 2014 Arbiter. All rights reserved.
//

#import "DetailViewController.h"
#import "EEGDataViewController.h"


@interface DetailViewController ()

@property (strong, nonatomic) UIPopoverController *masterPopoverController;
- (void)configureView;
@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        [self configureView];
    }

    if (self.masterPopoverController != nil) {
        [self.masterPopoverController dismissPopoverAnimated:YES];
    }        
}

- (void)configureView
{
    if ( self.dataController == nil ) {
        self.dataController = [[EEGDataViewController alloc] init];
        self.dataController.delegate = self;
    }
    
    if (self.detailItem) {
        self.detailDescriptionLabel.text = @"Attention Data";
        self.recordButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [self.recordButton setTitle:@"Record" forState:UIControlStateNormal];
        [self.recordButton addTarget:self action:@selector(recordButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:self.recordButton];
        [self.recordButton sizeToFit];
        self.recordButton.center = self.view.center;
        CGRect frame = self.recordButton.frame;
        frame.origin.y = self.view.frame.size.height - self.recordButton.frame.size.height - 20.0;
        self.recordButton.frame = frame;
        self.isRecording = NO;
    }

    [[TGAccessoryManager sharedTGAccessoryManager] setDelegate:self.dataController];
    
    self.recordButton.enabled = self.dataController.accessoryConnected;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configureView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

# pragma mark Click Handlers

- (void)recordButtonClicked:(id)sender
{
    if ( self.isRecording ) {
        [self.dataController stopRecordingData];
        [self.recordButton setTitle:@"Record" forState:UIControlStateNormal];
        self.isRecording = NO;
    } else {
        [self.dataController startRecordingData];
        [self.recordButton setTitle:@"Stop" forState:UIControlStateNormal];
        self.isRecording = YES;
    }
}


#pragma  EEGDataDelegate methods

- (void)receiveAttentionData:(int)attentionData
{
    NSLog(@"attention data: %d", attentionData);
    self.detailDescriptionLabel.text = [NSString stringWithFormat:@"%d", attentionData];
}

- (void)deviceConnected
{
    self.recordButton.enabled = YES;
}

- (void)deviceDisconnected
{
    self.recordButton.enabled = NO;
}

#pragma mark - Split view

- (void)splitViewController:(UISplitViewController *)splitController willHideViewController:(UIViewController *)viewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)popoverController
{
    barButtonItem.title = NSLocalizedString(@"Master", @"Master");
    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
    self.masterPopoverController = popoverController;
}

- (void)splitViewController:(UISplitViewController *)splitController willShowViewController:(UIViewController *)viewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    // Called when the view is shown again in the split view, invalidating the button and popover controller.
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    self.masterPopoverController = nil;
}

@end
