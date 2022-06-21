#import "TableView.h"

@implementation TableView

- (void) drawRect:(NSRect)dirtyRect {
  [super drawRect: dirtyRect];
}

- (void) keyDown: (NSEvent *) event {
  TableViewController * delegate = (TableViewController *) self.delegate;
  switch (event.keyCode) {
    case ESCAPE_KEYCODE:
      [delegate didEscapeKeyDown];
      break;
    case ENTER_KEYCODE:
      [delegate didEnterKeyDown];
      break;
    default:
      [super keyDown:event];
      break;
  }  
}

@end
