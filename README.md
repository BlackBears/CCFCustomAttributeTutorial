## About project ##

This is a quick tutorial application for Mac OS to illustrate some of the features of `NSAttributedString`, `NSTextView` and `NSLayoutManager`.

In this application we create a custom `NSTextView` and `NSLayoutManager` that draws a new type of attribute with background highlighting and under- and overlining.

![CustomAttributeTestApp](http://i.imgur.com/mErdK.png)

## Installation ##

Download the source, build and run. The project is structured the way we structure all of our code at Cocoa Factory.  A brief digression on source code organization.  A lot of people like to use Xcode's internal organization as the sole way of bringing order to the source files.  That's OK until you want to share the project with others (e.g. Github)  Then it looks like a mess because the source files live at the project root level. As an alternative you could force the file system organization to look exactly like the internal organization of the project inside Xcode, but that would be overkill.  So what we do is impose some higher-order structure on the filesystem side with the following structure:

* singletons (e.g. application delegate)
* model
* helpers+managers
* controllers
* views
* resources
    * images
    * html
    * nibs
    * property lists
    
Any organization more finally grained than that is created solely in Xcode.

## Featured classes ##

`CCFTextView` is an `NSTextView` subclass that just replaces the default layout manager with our own.

`CCFCustomLayoutManager` is a `CCFLayoutManager` subclass used with our custom text view.  It only overrides `drawGlyphsForGlyphRange:atPoint:` to do the custom drawing.

`CCFMainWindowController` is an `NSWindowController` subclass that manages the main window.  duh.

