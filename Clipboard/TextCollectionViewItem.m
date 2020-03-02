#import "TextCollectionViewItem.h"

@interface TextCollectionViewItem ()

@property (weak) IBOutlet NSTextField * textField;

@end

@implementation TextCollectionViewItem

- (void) viewDidLoad {
    [super viewDidLoad];
}

- (void) setRepresentedObject:(id)representedObject {
  [super setRepresentedObject:representedObject];
  if (representedObject != nil) {
    self.textField.stringValue = [representedObject valueForKey:@"copyValue"];
  }
}

@end
