#import "AppDelegate.h"

@interface AppDelegate ()

@property (weak) IBOutlet NSPanel * window;
@property (nonatomic, strong) NSStatusItem * statusItem;
@property (nonatomic, strong) HotKeyManager * hotKeyManager;

@end

@implementation AppDelegate

- (void) applicationDidFinishLaunching:(NSNotification *)notification {
  [self initializeMenu];
  self.hotKeyManager = [[HotKeyManager alloc] initWithTarget:self selector:@selector(showClipboardWindow)];
}

- (void) initializeMenu {
  NSMenu * menu = [[NSMenu alloc] init];
  [menu addItemWithTitle:@"Show window" action:@selector(showClipboardWindow) keyEquivalent:@""];
  [menu addItemWithTitle:@"Quit" action:@selector(terminate:) keyEquivalent:@""];
  
  self.statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
  self.statusItem.button.title = @"";
  self.statusItem.button.image = [NSImage imageNamed:@"Clipboard"];
  self.statusItem.menu = menu;
}

- (void) applicationWillTerminate:(NSNotification *)notification {
}

- (void) showClipboardWindow {
  NSLog(@"showWindow");
  [self.window makeKeyAndOrderFront:nil];
  [self.window orderFrontRegardless];
  [self.window center];
}

@end
