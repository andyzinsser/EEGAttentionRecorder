//
//  DetailViewController.h
//  EEGEngagmentRecorder
//
//  Created by Andy Zinsser on 9/17/14.
//  Copyright (c) 2014 Arbiter. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EEGDataViewController.h"

@interface DetailViewController : UIViewController <UISplitViewControllerDelegate, EEGDataDelegate>

@property (strong, nonatomic) id detailItem;
@property BOOL isRecording;
@property (strong, nonatomic) EEGDataViewController *dataController;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@property (weak, nonatomic) UIButton *recordButton;

@end
