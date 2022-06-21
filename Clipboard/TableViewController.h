#import <Cocoa/Cocoa.h>
#import <Foundation/Foundation.h>

#import "PasteboardPoller.h"

@class AppDelegate;

@interface TableViewController : NSViewController <NSTableViewDataSource, NSTableViewDelegate>

@property (weak) AppDelegate * appDelegate;
@property (nonatomic, strong) NSMutableOrderedSet * values;

- (void) addValue:(NSString *) value;
- (void) didEscapeKeyDown;
- (void) didEnterKeyDown;

@end
