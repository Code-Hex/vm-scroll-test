//
//  view.m
//  vm-scroll-test
//
//  Created by Kei Kamikawa on 2022/08/26.
//

#import "view.h"

@implementation FlippedView : NSClipView {}
- (BOOL)isFlipped
{
    return NO;
}
@end

@implementation VZCustomVirtualMachineView {
    CGFloat _minWindowWidth;
    CGFloat _minWindowHeight;
}

- (VZMacPlatformConfiguration *)createMacPlatformConfiguration
{
    VZMacPlatformConfiguration *macPlatformConfiguration = [[VZMacPlatformConfiguration alloc] init];
    VZMacAuxiliaryStorage *auxiliaryStorage = [[VZMacAuxiliaryStorage alloc] initWithContentsOfURL:getAuxiliaryStorageURL()];
    macPlatformConfiguration.auxiliaryStorage = auxiliaryStorage;

   
    // Retrieve the hardware model; you should save this value to disk
    // during installation.
    NSData *hardwareModelData = [[NSData alloc] initWithContentsOfURL:getHardwareModelURL()];
    
    VZMacHardwareModel *hardwareModel = [[VZMacHardwareModel alloc] initWithDataRepresentation:hardwareModelData];
    
    macPlatformConfiguration.hardwareModel = hardwareModel;

    // Retrieve the machine identifier; you should save this value to disk
    // during installation.
    NSData *machineIdentifierData = [[NSData alloc] initWithContentsOfURL:getMachineIdentifierURL()];
   

    VZMacMachineIdentifier *machineIdentifier = [[VZMacMachineIdentifier alloc] initWithDataRepresentation:machineIdentifierData];
   
    macPlatformConfiguration.machineIdentifier = machineIdentifier;

    return macPlatformConfiguration;
}


- (VZVirtioBlockDeviceConfiguration *)createBlockDeviceConfiguration
{
    NSError *error;
    VZDiskImageStorageDeviceAttachment *diskAttachment = [[VZDiskImageStorageDeviceAttachment alloc] initWithURL:getDiskImageURL() readOnly:NO error:&error];
    VZVirtioBlockDeviceConfiguration *disk = [[VZVirtioBlockDeviceConfiguration alloc] initWithAttachment:diskAttachment];
    return disk;
}

- (instancetype)initWithWidth:(CGFloat)width height:(CGFloat)height
{
    
    self = [super initWithFrame:NSMakeRect(0, 0, width, height)];
    
    VZVirtualMachineConfiguration *configuration = [[VZVirtualMachineConfiguration new] autorelease];
    configuration.platform = [self createMacPlatformConfiguration];
    configuration.CPUCount = (NSUInteger)2;
    configuration.memorySize = 2ull * 1024ull * 1024ull * 1024ull;
    VZMacOSBootLoader *bootloader = [[[VZMacOSBootLoader alloc] init] autorelease];
    configuration.bootLoader = bootloader;
//    configuration.graphicsDevices = @[ [MacOSVirtualMachineConfigurationHelper createGraphicsDeviceConfiguration] ];
    configuration.storageDevices = @[ [self createBlockDeviceConfiguration] ];
    configuration.networkDevices = @[[[[VZVirtioNetworkDeviceConfiguration alloc] init] autorelease]];

    VZVirtualMachine *vm = [[VZVirtualMachine alloc] initWithConfiguration:configuration];
    self.virtualMachine = vm;
    _minWindowWidth = width;
    _minWindowHeight = height;
    [self setWantsLayer:YES];
    
    NSData *imageData = [[NSData alloc] initWithBase64EncodedString:IMAGE_BASE64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
    NSImage *image = [[[NSImage alloc] initWithData:imageData] autorelease];
    [self.layer setOpacity:0.3];
    [self.layer setContentsGravity:kCAGravityResizeAspectFill];
    [self.layer setContents:image];

    return self;
}

- (void)magnifyWithEvent:(NSEvent *)event
{
    [super magnifyWithEvent:event];
}

- (void)updateTrackingAreas
{}


- (void)mouseDown:(NSEvent *)event
{}

- (void)mouseDragged:(NSEvent *)event
{}

- (void)mouseUp:(NSEvent *)event
{}

- (void)mouseEntered:(NSEvent *)event
{}

- (void)mouseMoved:(NSEvent *)event
{}

- (void)mouseExited:(NSEvent *)event
{}

- (void)rightMouseDown:(NSEvent *)event
{}

- (void)rightMouseDragged:(NSEvent *)event
{}

- (void)rightMouseUp:(NSEvent *)event
{}

- (void)otherMouseDown:(NSEvent *)event
{}

- (void)otherMouseDragged:(NSEvent *)event
{}

- (void)otherMouseUp:(NSEvent *)event
{}

- (void)scrollWheel:(NSEvent *)event
{}

@end
