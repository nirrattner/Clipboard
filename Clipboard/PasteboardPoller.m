#import "PasteboardPoller.h"

@interface PasteboardPoller ()

@property (nonatomic, strong) NSPasteboard * pasteboard;
@property (nonatomic, strong) NSTimer * timer;
@property (nonatomic, weak) id target;
@property (nonatomic) SEL selector;
@property (nonatomic) NSInteger changeCount;

@end

@implementation PasteboardPoller

- (id) initWithTarget:(id)target selector:(SEL)selector {
  if (self = [super init]) {
    self.pasteboard = [NSPasteboard generalPasteboard];
    [self.pasteboard declareTypes:[NSArray arrayWithObject:NSPasteboardTypeString] owner:nil];
    self.target = target;
    self.selector = selector;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(poll) userInfo:nil repeats:YES];
    self.changeCount = [self.pasteboard changeCount];
  }
  return self;
}

- (void) poll {
  NSInteger changeCount = [self.pasteboard changeCount];
  if (changeCount != self.changeCount) {
    NSString * value = [self.pasteboard stringForType:NSPasteboardTypeString];
    [self invokeWithValue:value];
    self.changeCount = changeCount;
  }
}

- (void) invokeWithValue:(NSString *) value {
  if (value) {
    [self.target performSelector:self.selector withObject:value];
  }
}

@end
