#import <Carbon/Carbon.h>
#import <Cocoa/Cocoa.h>

#import "HotKeyManager.h"
#import "TableView.h"
#import "TableViewController.h"

#define V_KEYCODE 9
#define ENTER_KEYCODE 36
#define ESCAPE_KEYCODE 53

@interface AppDelegate : NSObject <NSApplicationDelegate>

- (void) didEscapeKeyDown;
- (void) didEnterKeyDown;

@end

