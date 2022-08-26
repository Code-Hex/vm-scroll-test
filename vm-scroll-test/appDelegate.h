//
//  appDelegate.h
//  vm-scroll-test
//
//  Created by Kei Kamikawa on 2022/08/26.
//

#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate, NSWindowDelegate>
- (instancetype)initWithWidth:(CGFloat)width height:(CGFloat)height;
@end

