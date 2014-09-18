//
//  EEGDataViewController.m
//  EEGEngagmentRecorder
//
//  Created by Andy Zinsser on 9/17/14.
//  Copyright (c) 2014 Arbiter. All rights reserved.
//

#import "EEGDataViewController.h"

@implementation EEGDataViewController

@synthesize delegate = _delegate;

- (id)init
{
    self = [super init];
    if ( self ) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    if ( [[TGAccessoryManager sharedTGAccessoryManager] accessory] == nil ) {
        self.accessoryConnected = NO;
        [self.delegate deviceDisconnected];
    }
    else {
        self.accessoryConnected = YES;
        [self.delegate deviceConnected];
    }
}

- (void)startRecordingData
{
    if ( self.accessoryConnected ) {
        [[TGAccessoryManager sharedTGAccessoryManager] startStream];
    } else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"No Device Connected"
                                                            message:@"Make sure the device is connected before continuing"
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
        [alertView show];

    }
}

- (void)stopRecordingData
{
    [[TGAccessoryManager sharedTGAccessoryManager] stopStream];
}


#pragma mark TGAccessoryDelegate protocol methods

- (void)accessoryDidConnect:(EAAccessory *)accessory
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Device Connected"
                                                        message:[NSString stringWithFormat:@"%@ is connected.", [accessory name]]
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
    [alertView show];
    [self setup];
}

- (void)accessoryDidDisconnect
{
    [self setup];
}

- (void)dataReceived:(NSDictionary *)data {
    NSLog(@"dataReceived");
    if ( [data valueForKey:@"eSenseAttention"] ) {
        eSenseValues.attention = [[data valueForKey:@"eSenseAttention"] intValue];
        eSenseValues.meditation = [[data valueForKey:@"eSenseMeditation"] intValue];
    }
    
    [self.delegate receiveAttentionData:eSenseValues.attention];
}

@end
