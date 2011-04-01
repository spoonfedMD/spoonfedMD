/*
 * AppController.j
 * NewApplication
 *
 * Created by You on February 22, 2011.
 * Copyright 2011, Your Company All rights reserved.
 */

@import <Foundation/CPObject.j>


@implementation AppController : CPObject
{
	CPTextField label;
}

- (void)applicationDidFinishLaunching:(CPNotification)aNotification
{
    var theWindow = [[CPWindow alloc] initWithContentRect:CGRectMakeZero() styleMask:CPBorderlessBridgeWindowMask],
        contentView = [theWindow contentView];

    label = [[CPTextField alloc] initWithFrame:CGRectMakeZero()];

    [label setStringValue:@"Hello World!"];
    [label setFont:[CPFont boldSystemFontOfSize:24.0]];

    [label sizeToFit];

    [label setAutoresizingMask:CPViewMinXMargin | CPViewMaxXMargin | CPViewMinYMargin | CPViewMaxYMargin];
    [label setCenter:[contentView center]];

    [contentView addSubview:label];

    var button1 = [[CPButton alloc] initWithFrame: CGRectMake(
                CGRectGetWidth([contentView bounds])/2.0 - 40,
                CGRectGetMaxY([label frame]) + 10,
                80, 18
        )] ;

 	var button2 = [[CPButton alloc] initWithFrame: CGRectMake(
                CGRectGetWidth([contentView bounds])/2.0 - 40,
                CGRectGetMaxY([button1 frame]) + 10,
                80, 18
        )] ;        

    [button1 setAutoresizingMask:CPViewMinXMargin |
                                CPViewMaxXMargin |
                                CPViewMinYMargin |
                                CPViewMaxYMargin] ;

	[button2 setAutoresizingMask:CPViewMinXMargin |
                                CPViewMaxXMargin |
                                CPViewMinYMargin |
                                CPViewMaxYMargin] ;
                              
    [button1 setTitle:"Login"] ;
    [button2 setTitle:"Logout"] ;
    
    [button1 setTarget:self] ;
	[button2 setTarget:self] ;
    [button1 setAction:@selector(button_1:)];
    [button2 setAction:@selector(button_2:)];
        
    [contentView addSubview:button1] ;
    [contentView addSubview:button2] ;

    [theWindow orderFront:self];

    // Uncomment the following line to turn on the standard menu bar.
    //[CPMenu setMenuBarVisible:YES];
}

var connection;

- (void)button_1:(id)sender
{
	[label setStringValue:@"Logging in..."] ;
    [label setFont:[CPFont boldSystemFontOfSize:24.0]] ;
    [label sizeToFit] ;
	var request = [CPURLRequest requestWithURL:"http://localhost:3000/login"] ;
	connection = [CPURLConnection connectionWithRequest:request delegate:self] ;
}

- (void)button_2:(id)sender
{
	[label setStringValue:@"Logging out..."] ;
    [label setFont:[CPFont boldSystemFontOfSize:24.0]] ;
    [label sizeToFit] ;
	var request = [CPURLRequest requestWithURL:"http://localhost:3000/logout"] ;
	connection = [CPURLConnection connectionWithRequest:request delegate:self] ;
}

- (void)connection:(CPURLConnection)aConnection didReceiveData:(CPString)data
{
	var result = CPJSObjectCreateWithJSON(data);
    alert(result.message);
}

- (void)connection:(CPURLConnection)aConnection didFailWithError:(CPError)anError
{
    alert();
}


@end
