#import <Carbon/Carbon.h>
#import <Foundation/Foundation.h>

@interface HotKeyManager : NSObject {
  EventHotKeyRef eventHotKeyRef;
}

- (id) initWithTarget:(id)target selector:(SEL)selector;
- (void) invoke;

@end
