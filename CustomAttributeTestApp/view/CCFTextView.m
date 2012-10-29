/**
 *   @file CCFTextView.m
 *   @author Alan Duncan (www.cocoafactory.com)
 *
 *   @date 2012-10-29 06:01:01
 *   @version 1.0
 *
 *   @note Copyright 2011 Cocoa Factory, LLC.  All rights reserved
 */

#import "CCFTextView.h"


static CCFTextView *commonInit(CCFTextView *self) {
    //  set up our initial text size
    NSFont *font = [[NSFontManager sharedFontManager] fontWithFamily:@"Helvetica" traits:0 weight:5 size:24.0];
    NSDictionary *attributes = @{NSFontAttributeName : font};
    [self setTypingAttributes:attributes];
    
    //  replace our layout manager with custom layout manager
    CCFCustomLayoutManager *layoutManager = [[CCFCustomLayoutManager alloc] init];
    NSTextContainer *textContainer = [[NSTextContainer alloc] init];
    
    [self replaceTextContainer:textContainer];
    [textContainer replaceLayoutManager:layoutManager];
    return self;
}

@implementation CCFTextView

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if( !self ) return nil;
    
    return commonInit(self);
}

- (id)initWithFrame:(NSRect)frameRect {
    self = [super initWithFrame:frameRect];
    if( !self ) return nil;
    
    return commonInit(self);
}

@end
