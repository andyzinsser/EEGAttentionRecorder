//
//  DetailViewController.h
//  EEGEngagmentRecorder
//
//  Created by Andy Zinsser on 9/17/14.
//  Copyright (c) 2014 Arbiter. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController <UISplitViewControllerDelegate>

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
