/**
 *   @file CCFMainWindowController.m
 *   @author Alan Duncan (www.cocoafactory.com)
 *
 *   @date 2012-10-29 05:56:53
 *   @version 1.0
 *
 *   @note Copyright 2011 Cocoa Factory, LLC.  All rights reserved
 */

#import "CCFMainWindowController.h"
#import "CCFTextView.h"

#define START_WITH_HIGHLIGHTING

static NSString * const HighlightColorWellKeypath = @"highlightColorWell.color";
static NSString * const LineColorWellKeypath = @"lineColorWell.color";

@implementation CCFMainWindowController


- (void)dealloc {
    [self removeObserver:self forKeyPath:HighlightColorWellKeypath];
    [self removeObserver:self forKeyPath:LineColorWellKeypath];
}

#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if( [keyPath isEqualToString:HighlightColorWellKeypath] || [keyPath isEqualToString:LineColorWellKeypath] ) {
        NSTextStorage *textStorage = [[self textView] textStorage];
        NSRange entireRange = NSMakeRange(0, [textStorage length] -1);
        [textStorage beginEditing];
        [textStorage enumerateAttribute:CCFSpecialHighlightAttributeName inRange:entireRange options:0 usingBlock:^(id value, NSRange range, BOOL *stop) {
            if( value ) {
                //  only change attribute if that attribute is actually set (i.e. non-nil)
                [textStorage removeAttribute:CCFSpecialHighlightAttributeName range:range];
                [textStorage addAttribute:CCFSpecialHighlightAttributeName value:[self attributeColors] range:range];
            }
        }];
        [textStorage endEditing];
    }
}

- (void)awakeFromNib {
    //  observe color changes so we can redraw if needed
    [self addObserver:self forKeyPath:HighlightColorWellKeypath options:NSKeyValueObservingOptionNew context:NULL];
    [self addObserver:self forKeyPath:LineColorWellKeypath options:NSKeyValueObservingOptionNew context:NULL];
    //  Provide some sample text to start with
    NSString *sampleString = @"Try selecting some text";
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:sampleString attributes:@{NSFontSizeAttribute:@24}];
    
#ifdef START_WITH_HIGHLIGHTING
    NSRange range = NSMakeRange(5, 2);

    NSDictionary *attributes = @{CCFSpecialHighlightAttributeName : [self attributeColors]};
    [attributedString setAttributes:attributes range:range];
#endif
    [[self textView] insertText:attributedString];
}

#pragma mark - Interface actions

- (IBAction)setCustomAttribute:(id)sender {
    //  add our custom attribute to the selected range
    NSRange selectedRange = [[self textView] selectedRange];
    NSTextStorage *textStorage = self.textView.textStorage;
    [textStorage addAttribute:CCFSpecialHighlightAttributeName value:[self attributeColors] range:selectedRange];
}

#pragma mark - Private

//  return dictionary of highlight and line colors for our custom attribute's value
- (NSDictionary *)attributeColors {
    return @{  CCFHighlightColorKey : self.highlightColorWell.color, CCFLineColorKey : self.lineColorWell.color };
}

@end
