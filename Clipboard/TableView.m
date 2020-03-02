#import "TableView.h"

@implementation TableView

- (void) drawRect:(NSRect)dirtyRect {
  [super drawRect: dirtyRect];
}

- (void) keyDown: (NSEvent *) event {
  NSLog(@"TEST");
  TableViewController * delegate = (TableViewController *) self.delegate;
  switch (event.keyCode) {
    case ESCAPE_KEYCODE:
      [delegate didEscapeKeyDown];
      // self.window.isVisible = NO;
      // [[NSApplication sharedApplication] hide:nil];
      break;
    case ENTER_KEYCODE:
      [delegate didEnterKeyDown];
      // self.window.isVisible = NO;
      // [[NSApplication sharedApplication] hide:nil];
      // [self pasteSelection];
      break;
    default:
      [super keyDown:event];
      break;
  }  
}

@end
