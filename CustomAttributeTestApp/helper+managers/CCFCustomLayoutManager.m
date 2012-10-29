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
        NSRange charRange = [self characterRangeForGlyphRange:glyphRange
                                             actualGlyphRange:NULL], attributeCharRange, attributeGlyphRange;
        id attribute = [textStorage attribute:CCFSpecialHighlightAttributeName
                                      atIndex:charRange.location longestEffectiveRange:&attributeCharRange
                                      inRange:charRange];
        attributeGlyphRange = [self glyphRangeForCharacterRange:attributeCharRange actualCharacterRange:NULL];
        attributeGlyphRange = NSIntersectionRange(attributeGlyphRange, glyphRange);
        if( attribute != nil ) {
            [NSGraphicsContext saveGraphicsState];
            
            NSColor *bgColor = [attribute objectForKey:CCFHighlightColorKey];
            NSColor *lineColor = [attribute objectForKey:CCFLineColorKey];
            
            for( NSInteger idx = glyphRange.location; idx < NSMaxRange(glyphRange); idx++ ) {
                NSRect rect = [self lineFragmentUsedRectForGlyphAtIndex:idx effectiveRange:NULL];
                
                [bgColor setFill];
                NSRectFill(rect);
                
                NSRect bottom = NSMakeRect(NSMinX(rect), NSMaxY(rect)-1.0, NSWidth(rect), 1.0f);
                [lineColor setFill];
                NSRectFill(bottom);
                
                NSRect topRect = NSMakeRect(NSMinX(rect), NSMinY(rect), NSWidth(rect), 1.0);
                NSRectFill(topRect);
            }
            
            [super drawGlyphsForGlyphRange:attributeGlyphRange atPoint:origin];
            [NSGraphicsContext restoreGraphicsState];
        }
        else {
            [super drawGlyphsForGlyphRange:attributeGlyphRange atPoint:origin];
        }
        glyphRange.length = NSMaxRange(glyphRange) - NSMaxRange(attributeGlyphRange);
        glyphRange.location = NSMaxRange(attributeGlyphRange);
    }
}

@end
