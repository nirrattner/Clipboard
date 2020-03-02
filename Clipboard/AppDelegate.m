#import "AppDelegate.h"

@interface AppDelegate ()

@property (weak) IBOutlet NSPanel * window;
@property (nonatomic, strong) NSStatusItem * statusItem;
@property (nonatomic, strong) HotKeyManager * hotKeyManager;
@property (nonatomic, strong) id escapeKeyMonitor;

@end

@implementation AppDelegate

- (void) applicationDidFinishLaunching:(NSNotification *)notification {
  [self initializeMenu];
  self.hotKeyManager = [[HotKeyManager alloc] initWithTarget:self selector:@selector(showWindow)];
  
  
  
  // monitor ESC key
  NSEvent* (^handler)(NSEvent*) = ^(NSEvent *event) {
    if (event.keyCode == 53) {
      self.window.isVisible = NO;
    }
    return event;
  };
  self.escapeKeyMonitor = [NSEvent addLocalMonitorForEventsMatchingMask:NSEventMaskKeyDown handler:handler];
  
}

- (void) initializeMenu {
  NSMenu * menu = [[NSMenu alloc] init];
  [menu addItemWithTitle:@"Show window" action:@selector(showWindow) keyEquivalent:@""];
  [menu addItemWithTitle:@"Quit" action:@selector(terminate:) keyEquivalent:@""];
  
  self.statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
  self.statusItem.button.title = @"";
  self.statusItem.button.image = [NSImage imageNamed:@"Clipboard"];
  self.statusItem.menu = menu;
}

- (void) applicationWillTerminate:(NSNotification *)notification {
}

- (void) showWindow {
  [self.window makeKeyAndOrderFront:nil];
  [self.window orderFrontRegardless];
  [self.window center];
  [[NSApplication sharedApplication] activateIgnoringOtherApps:YES];
}

@end
