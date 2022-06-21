#import "AppDelegate.h"

#define LIST_DISPLAY_CAPACITY (10)
#define SCROLL_Y_POSITION (20)
#define SCROLL_Y_SIZE_OFFSET (2)
#define WINDOW_Y_SIZE_OFFSET (42)
#define ELEMENT_Y_HEIGHT (26)

@interface AppDelegate ()

@property (weak) IBOutlet NSPanel * window;
@property (weak) IBOutlet TableView * tableView;
@property (weak) IBOutlet NSScrollView * scrollView;
@property (nonatomic, strong) PasteboardPoller * pasteboardPoller;
@property (nonatomic, strong) NSPasteboard * pasteboard;
@property (nonatomic, strong) NSStatusItem * statusItem;
@property (nonatomic, strong) HotKeyManager * hotKeyManager;
@property (nonatomic, strong) id keyMonitor;

@end

@implementation AppDelegate

- (void) applicationDidFinishLaunching:(NSNotification *)notification {
  // NSDictionary * options = @{(__bridge id) kAXTrustedCheckOptionPrompt: @YES};
  // AXIsProcessTrustedWithOptions((CFDictionaryRef)options);
  
  [self initializeMenu];
  self.pasteboard = [NSPasteboard generalPasteboard];
  [self.pasteboard declareTypes:[NSArray arrayWithObject:NSPasteboardTypeString] owner:nil];

  self.hotKeyManager = [[HotKeyManager alloc] initWithTarget:self selector:@selector(showWindow)];
  
  ((TableViewController *) self.tableView.delegate).appDelegate = self;
  
  self.pasteboardPoller = [[PasteboardPoller alloc] initWithTarget:self.tableView.delegate selector:@selector(addValue:)];
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
  TableViewController * tableViewController = (TableViewController *) self.tableView.delegate;
  NSUInteger count = [tableViewController.values count];
  NSUInteger limitedCount = MIN(count, LIST_DISPLAY_CAPACITY);

  NSRect rect = [self.window frame];
  rect.size.height = WINDOW_Y_SIZE_OFFSET + (ELEMENT_Y_HEIGHT * limitedCount);
  [self.window setFrame:rect display:NO];
  
  rect = [self.tableView frame];
  rect.size.height = ELEMENT_Y_HEIGHT * count;
  [self.tableView setFrame:rect];
  
  rect = [self.scrollView frame];
  rect.origin.y = SCROLL_Y_POSITION;
  rect.size.height = SCROLL_Y_SIZE_OFFSET + (ELEMENT_Y_HEIGHT * limitedCount);
  [self.scrollView setFrame:rect];

  [self.window setCollectionBehavior:NSWindowCollectionBehaviorMoveToActiveSpace];
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
  if ([tableViewController.values count] > 0) {
    [self.pasteboard clearContents];
    [self.pasteboard setString:[tableViewController.values objectAtIndex:self.tableView.selectedRow] forType:NSPasteboardTypeString];
    
    CGEventRef event1, event2;
    event1 = CGEventCreateKeyboardEvent(NULL, (CGKeyCode) V_KEYCODE, true);
    event2 = CGEventCreateKeyboardEvent(NULL, (CGKeyCode) V_KEYCODE, false);
    
    CGEventSetFlags(event1, (CGEventFlags) kCGEventFlagMaskCommand);
    CGEventSetFlags(event2, (CGEventFlags) kCGEventFlagMaskCommand);
    
    CGEventPost(kCGSessionEventTap, event1);
    CGEventPost(kCGSessionEventTap, event2);
    
    CFRelease(event1);
    CFRelease(event2);
  }
}

@end
