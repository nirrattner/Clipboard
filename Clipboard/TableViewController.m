#import "TableViewController.h"

#import "AppDelegate.h"

#define LIST_CAPACITY (100)

@interface TableViewController ()

@property (weak) IBOutlet TableView * tableView;
@property (weak) IBOutlet NSScrollView * scrollView;

@end

@implementation TableViewController

- (NSMutableOrderedSet *)values {
  if (!_values) {
    _values = [NSMutableOrderedSet orderedSetWithCapacity:10];
  }
  return _values;
}

- (void) addValue:(NSString *) value {
  [self.values removeObject:value];
  [self.values addObject:value];
  [self.tableView reloadData];
  
  while (self.values.count > LIST_CAPACITY) {
    [self.values removeObjectAtIndex:0];
  }
}

- (NSInteger) numberOfRowsInTableView:(NSTableView *)tableView {
  return [self.values count];
}

- (id) tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
  return [self.values objectAtIndex:[self.values count] - row - 1];
}

/*
- (void) tableViewSelectionDidChange:(NSNotification *)notification {
  NSTableView *tableView = notification.object;
  NSLog(@"User has selected row %ld", (long)tableView.selectedRow);
}
 */

- (void) didEscapeKeyDown {
  [self.appDelegate didEscapeKeyDown];
}

- (void) didEnterKeyDown {
  [self.appDelegate didEnterKeyDown];
}

@end
