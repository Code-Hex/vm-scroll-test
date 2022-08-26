//
//  main.m
//  vm-scroll-test
//
//  Created by Kei Kamikawa on 2022/08/25.
//

#import "appDelegate.h"
#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>
#import <Virtualization/Virtualization.h>


int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"Hello, World!");
        
        // Create a shared app instance.
        // This will initialize the global variable
        // 'NSApp' with the application instance.
        [NSApplication sharedApplication];
        
//        VZVirtualMachineView *view = [[[VZVirtualMachineView alloc] init] autorelease];
//        NSLog(@"%@", [view performSelector:@selector(_methodDescription)]);
        
        AppDelegate *appDelegate = [[[AppDelegate alloc]
                                                initWithWidth:(CGFloat)300
                                                height:(CGFloat)500] autorelease];

        
        NSApp.delegate = appDelegate;
        [NSApp run];
    }
    return 0;
}
