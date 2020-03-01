#import "AppDelegate.h"

@interface AppDelegate ()

@property (weak) IBOutlet NSPanel * window;
@property (nonatomic, strong, readwrite) NSStatusItem * statusItem;

@end

static OSStatus handleHotKey(EventHandlerCallRef nextHandler, EventRef event, void * data) {
  AppDelegate * appDelegate = (__bridge AppDelegate *) data;
  
  // [appDelegate.window makeKeyAndOrderFront:nil];
  // [appDelegate.window orderFrontRegardless];
  
  return noErr;
}

@implementation AppDelegate

- (void) applicationDidFinishLaunching:(NSNotification *) aNotification {
  [self initializeMenu];
  [self registerHotKeys];
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

- (void) applicationWillTerminate:(NSNotification *)aNotification {
}

- (void) showClipboardWindow {
  NSLog(@"showWindow");
  [self.window makeKeyAndOrderFront:nil];
  [self.window orderFrontRegardless];
  [self.window center];
}

- (void) registerHotKeys {
  EventHotKeyID hotKeyId;
  hotKeyId.id = 0;
  hotKeyId.signature = 'hkid';
  
  EventTypeSpec eventType;
  eventType.eventClass = kEventClassKeyboard;
  eventType.eventKind = kEventHotKeyPressed;
  
  EventHotKeyRef hotKeyRef;
  
  InstallApplicationEventHandler(&handleHotKey, 1, &eventType, (__bridge void *) self, NULL);
  
  RegisterEventHotKey(8, cmdKey + optionKey, hotKeyId, GetApplicationEventTarget(), 0, &hotKeyRef);
}

@end
