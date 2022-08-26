//
//  viewController.h
//  vm-scroll-test
//
//  Created by Kei Kamikawa on 2022/08/26.
//

#import <Cocoa/Cocoa.h>

@interface ScrollViewController : NSViewController <NSWindowDelegate>
- (instancetype)initWithView:(NSView *)view;
@end

