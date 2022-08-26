//
//  viewController.m
//  vm-scroll-test
//
//  Created by Kei Kamikawa on 2022/08/26.
//

#import "viewController.h"

@implementation ScrollViewController {
    NSView *_contentView;
}

- (instancetype)initWithView:(NSView *)view
{
    self = [super initWithNibName:nil bundle:nil];
    _contentView = view;
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"view loaded");
}


- (void)windowDidResize:(NSNotification *)notification
{
    NSWindow *window = notification.object;
    [((NSScrollView *)self.view).documentView setFrameSize:window.frame.size];
}

- (void)loadView
{
//    FlippedView *flippedView = [[[FlippedView alloc] initWithFrame:self.view.frame] autorelease];

    NSScrollView *scrollView = [[[NSScrollView alloc] initWithFrame:_contentView.frame] autorelease];
    [scrollView setBorderType:NSNoBorder];
    [scrollView setHasVerticalScroller:YES];
    [scrollView setHasHorizontalScroller:YES];
    [scrollView setAllowsMagnification:YES];
    [scrollView setMinMagnification:1.0];

    // [scrollView setNeedsDisplay:YES];
//    [flippedView setDocumentView:_virtualMachineView];
//    FlippedView *view = [[FlippedView alloc] initWithFrame:_contentView.frame];
//    [scrollView setContentView:view];
    [scrollView setDocumentView:_contentView];
    
    self.view = scrollView;
    
//    [self.view addSubview:scrollView];
    
//    NSImageView *imageView = [NSImageView imageViewWithImage:[NSApp applicationIconImage]];
//    NSTextField *appLabel = [self makeLabel:[[NSProcessInfo processInfo] processName]];
//    [appLabel setFont:[NSFont boldSystemFontOfSize:16]];
//    NSTextField *subLabel = [self makePoweredByLabel];
//
//    NSStackView *stackView = [NSStackView stackViewWithViews:@[
//        imageView,
//        appLabel,
//        subLabel,
//    ]];
//    [stackView setOrientation:NSUserInterfaceLayoutOrientationVertical];
//    [stackView setDistribution:NSStackViewDistributionFillProportionally];
//    [stackView setSpacing:10];
//    [scrollView setAlignment:NSCenterTextAlignment];
//    [_contentView setContentCompressionResistancePriority:NSLayoutPriorityRequired forOrientation:NSLayoutConstraintOrientationHorizontal];
//    [_contentView setContentCompressionResistancePriority:NSLayoutPriorityRequired forOrientation:NSLayoutConstraintOrientationVertical];
////
//    [self.view addSubview:stackView];
//
//    [NSLayoutConstraint activateConstraints:@[
//        [_contentView.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:0],
//        [_contentView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor constant:0],
//        [_contentView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:0],
//        [_contentView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:0],
//    ]];
}

@end
