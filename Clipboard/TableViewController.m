#import "TableViewController.h"

@implementation TableViewController

- (NSArray *)numbers {
  
  if (!_numbers) {
    _numbers = @[@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10"];
  }
  return _numbers;
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
  // how many rows do we have here?
  return self.numbers.count;
}

- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
  NSLog(@"tableView");
  // populate each row of our table view with data
  // display a different value depending on each column (as identified in XIB)
    return [self.numbers objectAtIndex:row];

}

- (void)tableViewSelectionDidChange:(NSNotification *)notification {
  
  NSTableView *tableView = notification.object;
  NSLog(@"User has selected row %ld", (long)tableView.selectedRow);
}


@end
