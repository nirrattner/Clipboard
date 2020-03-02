#import "AppDelegate.h"

@interface AppDelegate ()

@property (weak) IBOutlet NSPanel * window;
@property (weak) IBOutlet TableView * tableView;
@property (nonatomic, strong) NSPasteboard * pasteboard;
@property (nonatomic, strong) NSStatusItem * statusItem;
@property (nonatomic, strong) HotKeyManager * hotKeyManager;
@property (nonatomic, strong) id keyMonitor;

@end

@implementation AppDelegate

- (void) applicationDidFinishLaunching:(NSNotification *)notification {
  // NSDictionary * options = @{(__bridge id) kAXTrustedCheckOptionPrompt: @YES};
  // BOOL accessibilityEnabled = AXIsProcessTrustedWithOptions((CFDictionaryRef)options);
  
  [self initializeMenu];
  self.pasteboard = [NSPasteboard generalPasteboard];
  [self.pasteboard declareTypes:[NSArray arrayWithObject:NSPasteboardTypeString] owner:nil];

  self.hotKeyManager = [[HotKeyManager alloc] initWithTarget:self selector:@selector(showWindow)];
  
  ((TableViewController *) self.tableView.delegate).appDelegate = self;
}

- (void) initializeMenu {
  NSMenu * menu = [[NSMenu alloc] init];
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
  
  [self.tableView becomeFirstResponder];
  NSIndexSet * indexSet = [NSIndexSet indexSetWithIndex:0];
  [self.tableView selectRowIndexes:indexSet byExtendingSelection:NO];
}

- (void) didEscapeKeyDown {
  self.window.isVisible = NO;
  [[NSApplication sharedApplication] hide:nil];
}

- (void) didEnterKeyDown {
  self.window.isVisible = NO;
  [[NSApplication sharedApplication] hide:nil];
  [self pasteSelection];
}

- (void) pasteSelection {
  TableViewController * tableViewController = (TableViewController *) self.tableView.delegate;
  NSLog(@"%@", [tableViewController.numbers objectAtIndex:self.tableView.selectedRow]);
  BOOL result = [self.pasteboard setString:@"TEST_STRING" forType:NSPasteboardTypeString];
  
  NSLog(@"%d", result == YES);
  
  CGEventRef event1, event2;
  event1 = CGEventCreateKeyboardEvent (NULL, (CGKeyCode) V_KEYCODE, true);
  event2 = CGEventCreateKeyboardEvent (NULL, (CGKeyCode) V_KEYCODE, false);
  
  CGEventSetFlags(event1, (CGEventFlags) kCGEventFlagMaskCommand);
  CGEventSetFlags(event2, (CGEventFlags) kCGEventFlagMaskCommand);
  
  CGEventPost(kCGSessionEventTap, event1);
  CGEventPost(kCGSessionEventTap, event2);
}

@end
