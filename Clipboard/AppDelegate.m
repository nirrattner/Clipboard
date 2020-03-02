#import "AppDelegate.h"

@interface AppDelegate ()

@property (weak) IBOutlet NSPanel * window;
@property (weak) IBOutlet NSTextField * textField;
@property (weak) IBOutlet NSCollectionView * collectionView;
@property (weak) IBOutlet NSTableView * tableView;
@property (nonatomic, strong) NSStatusItem * statusItem;
@property (nonatomic, strong) HotKeyManager * hotKeyManager;
@property (nonatomic, strong) id keyMonitor;

@end

@implementation AppDelegate

- (void) applicationDidFinishLaunching:(NSNotification *)notification {
  [self initializeMenu];
  [self initializeKeyMonitor];
  self.hotKeyManager = [[HotKeyManager alloc] initWithTarget:self selector:@selector(showWindow)];
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

- (void) initializeKeyMonitor {
  NSEvent* (^handler)(NSEvent*) = ^(NSEvent *event) {
    if (event.keyCode == 53) {
      self.window.isVisible = NO;
    }
    return event;
  };
  self.keyMonitor = [NSEvent addLocalMonitorForEventsMatchingMask:NSEventMaskKeyDown handler:handler];
}

- (void) applicationWillTerminate:(NSNotification *)notification {
}

- (void) showWindow {
  [self.window makeKeyAndOrderFront:nil];
  [self.window orderFrontRegardless];
  [self.window center];
  [[NSApplication sharedApplication] activateIgnoringOtherApps:YES];
  
  [self.textField becomeFirstResponder];
  
  NSLog(@"keywindow: %hhd", self.window.canBecomeKeyWindow);

}

@end
