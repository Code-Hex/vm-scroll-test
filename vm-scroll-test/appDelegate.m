//
//  appDelegate.m
//  vm-scroll-test
//
//  Created by Kei Kamikawa on 2022/08/26.
//

#import "appDelegate.h"
#import "viewController.h"
#import "view.h"

@implementation AppDelegate {
    VZCustomVirtualMachineView *_virtualMachineView;
    CGFloat _windowWidth;
    CGFloat _windowHeight;
}

- (instancetype)initWithWidth:(CGFloat)width height:(CGFloat)height
{
    self = [super init];

    // Setup virtual machine view configs
    VZCustomVirtualMachineView *view = [[VZCustomVirtualMachineView alloc]
                                            initWithWidth:width
                                            height:height];
    _virtualMachineView = view;

    // Setup some window configs
    _windowWidth = width;
    _windowHeight = height;
    return self;
}

/* IMPORTANT: delegate methods are called from VM's queue */
- (void)guestDidStopVirtualMachine:(VZVirtualMachine *)virtualMachine {
    NSLog(@"VM %@ guest stopped", virtualMachine);
    [NSApp performSelectorOnMainThread:@selector(terminate:) withObject:self waitUntilDone:NO];
}

- (void)virtualMachine:(VZVirtualMachine *)virtualMachine didStopWithError:(NSError *)error {
    NSLog(@"VM %@ didStopWithError: %@", virtualMachine, error);
    [NSApp performSelectorOnMainThread:@selector(terminate:) withObject:self waitUntilDone:NO];
}

- (void)applicationDidFinishLaunching:(NSNotification *)notification {
    [self setupMenuBar];
    [self setupGraphicWindow];

    // These methods are required to call here. Because the menubar will be not active even if
    // application is running.
    // See: https://stackoverflow.com/questions/62739862/why-doesnt-activateignoringotherapps-enable-the-menu-bar
    [NSApp setActivationPolicy:NSApplicationActivationPolicyRegular];
    [NSApp activateIgnoringOtherApps:YES];
}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender
{
    return YES;
}

- (void)setupGraphicWindow
{
    NSRect rect = NSMakeRect(0, 0, _windowWidth, _windowHeight);
    NSWindow *window = [[[NSWindow alloc] initWithContentRect:rect
                            styleMask:NSWindowStyleMaskTitled|NSWindowStyleMaskClosable|NSWindowStyleMaskMiniaturizable|NSWindowStyleMaskResizable//|NSTexturedBackgroundWindowMask
                            backing:NSBackingStoreBuffered defer:NO] autorelease];

    [window setOpaque:NO];
    
    ScrollViewController *viewController = [[ScrollViewController alloc] initWithView:_virtualMachineView];
    [window setDelegate:viewController];
    [window setContentViewController:viewController];
//    NSView *view = [[NSView alloc] initWithFrame:window.frame];
//    [window setContentView:viewController.view];
//    [window setDelegate:self];
//    [window setTitleVisibility:NSWindowTitleHidden];
    [window center];

    [window makeKeyAndOrderFront:nil];

    // This code to prevent crash when called applicationShouldTerminateAfterLastWindowClosed.
    // https://stackoverflow.com/a/13470694
    [window setReleasedWhenClosed:NO];
}

- (void)setupMenuBar
{
    NSMenu *menuBar = [[[NSMenu alloc] init] autorelease];
    NSMenuItem *menuBarItem = [[[NSMenuItem alloc] init] autorelease];
    [menuBar addItem:menuBarItem];
    [NSApp setMainMenu:menuBar];

    // App menu
    NSMenu *appMenu = [self setupApplicationMenu];
    [menuBarItem setSubmenu:appMenu];
}


- (NSMenu *)setupApplicationMenu
{
    NSMenu *appMenu = [[[NSMenu alloc] init] autorelease];
    NSString *applicationName = [[NSProcessInfo processInfo] processName];


    // Service menu
    NSMenuItem *servicesMenuItem = [[[NSMenuItem alloc] initWithTitle:@"Services" action:nil keyEquivalent:@""] autorelease];
    NSMenu *servicesMenu = [[[NSMenu alloc] initWithTitle:@"Services"] autorelease];
    [servicesMenuItem setSubmenu:servicesMenu];
    [NSApp setServicesMenu:servicesMenu];

    NSMenuItem *hideOthersItem = [[[NSMenuItem alloc]
            initWithTitle:@"Hide Others"
            action:@selector(hideOtherApplications:)
            keyEquivalent:@"h"] autorelease];
    [hideOthersItem setKeyEquivalentModifierMask:(NSEventModifierFlagOption|NSEventModifierFlagCommand)];

    NSArray *menuItems = @[
        servicesMenuItem,
        [NSMenuItem separatorItem],
        [[[NSMenuItem alloc]
            initWithTitle:[@"Hide " stringByAppendingString:applicationName]
            action:@selector(hide:)
            keyEquivalent:@"h"] autorelease],
        hideOthersItem,
        [NSMenuItem separatorItem],
        [[[NSMenuItem alloc]
            initWithTitle:[@"Quit " stringByAppendingString:applicationName]
            action:@selector(terminate:)
            keyEquivalent:@"q"] autorelease],
    ];
    for (NSMenuItem *menuItem in menuItems) {
        [appMenu addItem:menuItem];
    }
    return appMenu;
}

@end


