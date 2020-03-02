#import <Carbon/Carbon.h>
#import <Foundation/Foundation.h>

#define C_KEYCODE 8

@interface HotKeyManager : NSObject {
  EventHotKeyRef eventHotKeyRef;
}

- (id) initWithTarget:(id)target selector:(SEL)selector;
- (void) invoke;

@end
