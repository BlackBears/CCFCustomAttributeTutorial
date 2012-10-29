/**
  *   @file CCFAppDelegate.m
  *   @author Alan Duncan (www.cocoafactory.com)
  *
  *   @date 2012-10-29 05:56:19
  *   @version 1.0
  *
  *   @note Copyright 2011 Cocoa Factory, LLC.  All rights reserved
  */

#import "CCFAppDelegate.h"

static void insertColorIntoDictionary(NSColor *color,NSMutableDictionary *dict, NSString *key) {
    dict[key] = [NSKeyedArchiver archivedDataWithRootObject:color];
}


@implementation CCFAppDelegate

- (id)init {
    self = [super init];
    if( !self ) return nil;
    
    [self registerUserDefaults];
    
    return self;
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    
}


- (void)registerUserDefaults {
    NSString *path = [[NSBundle bundleForClass:[self class]] pathForResource:@"CCFInitialDefaults" ofType:@"plist"];
    NSMutableDictionary *defaults = [[NSDictionary dictionaryWithContentsOfFile:path] mutableCopy];
    
    //  because we can't (easily) provide data in the default plist, we can create the initial data
    NSColor *defaultHighlightColor = [NSColor colorWithCalibratedRed:0.992f green:0.858f blue:0.756f alpha:1.0f];
    insertColorIntoDictionary(defaultHighlightColor, defaults, kDefaultHighlightColorDataKey);
    
    NSColor *defaultLineColor = [NSColor colorWithCalibratedRed:0.393 green:0.043 blue:0.040 alpha:1.000];
    insertColorIntoDictionary(defaultLineColor, defaults, kDefaultLineColorDataKey);
    
    [[NSUserDefaults standardUserDefaults] registerDefaults:defaults];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
