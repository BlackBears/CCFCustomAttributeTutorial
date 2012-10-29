/**
 *   @file CCFDataToColorValueTransformer.m
 *   @author Alan Duncan (www.cocoafactory.com)
 *
 *   @date 2012-10-24 10:24:27
 *   @version 1.0
 *
 *   @note Copyright 2011 Cocoa Factory, LLC.  All rights reserved
 */

#import "CCFDataToColorValueTransformer.h"

@implementation CCFDataToColorValueTransformer

+ (Class)transformedValueClass {
    return [NSColor class];
}

+ (BOOL)allowsReverseTransformation {
    return YES;
}

- (id)transformedValue:(id)value {
    return (NSString *)[NSKeyedUnarchiver unarchiveObjectWithData:value];
    
}

- (id)reverseTransformedValue:(id)value {
    return [NSKeyedArchiver archivedDataWithRootObject:value];
}

@end
