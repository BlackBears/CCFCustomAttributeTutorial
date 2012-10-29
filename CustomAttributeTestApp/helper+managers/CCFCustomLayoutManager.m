//
//  CCFCustomLayoutManager.m
//  LayoutManagerTest
//
//  Created by alanduncan on 10/29/12.
//  Copyright (c) 2012 Cocoa Factory, LLC. All rights reserved.
//

#import "CCFCustomLayoutManager.h"

NSString * const  CCFHighlightColorKey = @"com.cocoafactory.HighlightColor";
NSString * const  CCFLineColorKey = @"com.cocoafactory.LineColor";
NSString * const  CCFSpecialHighlightAttributeName = @"com.cocoafactory.SpecialHighlightAttribute";

@implementation CCFCustomLayoutManager

- (void)drawGlyphsForGlyphRange:(NSRange)glyphsToShow atPoint:(NSPoint)origin {
    NSTextStorage *textStorage = self.textStorage;
    NSRange glyphRange = glyphsToShow;
    while (glyphRange.length > 0) {
        NSRange charRange = [self characterRangeForGlyphRange:glyphRange actualGlyphRange:NULL], attributeCharRange, attributeGlyphRange;
        id attribute = [textStorage attribute:CCFSpecialHighlightAttributeName
                                      atIndex:charRange.location longestEffectiveRange:&attributeCharRange
                                      inRange:charRange];
        attributeGlyphRange = [self glyphRangeForCharacterRange:attributeCharRange actualCharacterRange:NULL];
        attributeGlyphRange = NSIntersectionRange(attributeGlyphRange, glyphRange);
        if( attribute != nil ) {
            [NSGraphicsContext saveGraphicsState];
            
            NSColor *bgColor = [attribute objectForKey:CCFHighlightColorKey];
            NSColor *lineColor = [attribute objectForKey:CCFLineColorKey];
            
            NSTextContainer *textContainer = self.textContainers[0];
            NSRect boundingRect = [self boundingRectForGlyphRange:attributeGlyphRange inTextContainer:textContainer];
            
            [bgColor setFill];
            NSRectFill(boundingRect);
            
            NSRect bottom = NSMakeRect(NSMinX(boundingRect), NSMaxY(boundingRect)-1.0, NSWidth(boundingRect), 1.0f);
            [lineColor setFill];
            NSRectFill(bottom);
            
            NSRect topRect = NSMakeRect(NSMinX(boundingRect), NSMinY(boundingRect), NSWidth(boundingRect), 1.0);
            NSRectFill(topRect);
                       
            [super drawGlyphsForGlyphRange:attributeGlyphRange atPoint:origin];
            [NSGraphicsContext restoreGraphicsState];
        }
        else {
            [super drawGlyphsForGlyphRange:glyphsToShow atPoint:origin];
        }
        glyphRange.length = NSMaxRange(glyphRange) - NSMaxRange(attributeGlyphRange);
        glyphRange.location = NSMaxRange(attributeGlyphRange);
    }
}

@end
