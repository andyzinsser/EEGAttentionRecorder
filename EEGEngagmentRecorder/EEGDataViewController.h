//
//  EEGDataViewController.h
//  EEGEngagmentRecorder
//
//  Created by Andy Zinsser on 9/17/14.
//  Copyright (c) 2014 Arbiter. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ExternalAccessory/ExternalAccessory.h>
#import "TGAccessoryManager.h"
#import "TGAccessoryDelegate.h"

// the eSense values
typedef struct {
    int attention;
    int meditation;
} ESenseValues;

@protocol EEGDataDelegate

- (void)receiveAttentionData:(int)attentionData;
- (void)deviceConnected;
- (void)deviceDisconnected;

@end

@interface EEGDataViewController : UIViewController <TGAccessoryDelegate>
{
    ESenseValues eSenseValues;
    id <EEGDataDelegate> delegate;
}

@property (strong) id delegate;
@property BOOL accessoryConnected;

- (void)startRecordingData;
- (void)stopRecordingData;

// TGAccessoryDelegate protocol methods
- (void)accessoryDidConnect:(EAAccessory *)accessory;
- (void)accessoryDidDisconnect;
- (void)dataReceived:(NSDictionary *)data;

@end
