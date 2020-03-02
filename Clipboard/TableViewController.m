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
  
  // populate each row of our table view with data
  // display a different value depending on each column (as identified in XIB)
  
  if ([tableColumn.identifier isEqualToString:@"TableColumnId"]) {
    
    // first colum (numbers)
    return [self.numbers objectAtIndex:row];
    
  } else {
    
    // second column (numberCodes)
    return 0;
  }
}

#pragma mark - Table View Delegate

- (void)tableViewSelectionDidChange:(NSNotification *)notification {
  
  NSTableView *tableView = notification.object;
  NSLog(@"User has selected row %ld", (long)tableView.selectedRow);
}


@end
