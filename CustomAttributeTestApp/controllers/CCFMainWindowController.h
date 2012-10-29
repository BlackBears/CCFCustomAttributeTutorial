/**
 *   @file CCFMainWindowController.h
 *   @author Alan Duncan (www.cocoafactory.com)
 *
 *   @date 2012-10-29 05:56:47
 *   @version 1.0
 *
 *   @note Copyright 2011 Cocoa Factory, LLC.  All rights reserved
 */

@class CCFTextView;

@interface CCFMainWindowController : NSWindowController

@property (nonatomic, assign) IBOutlet CCFTextView *textView;
@property (nonatomic, weak) IBOutlet NSColorWell *highlightColorWell;
@property (nonatomic, weak) IBOutlet NSColorWell *lineColorWell;

@end
