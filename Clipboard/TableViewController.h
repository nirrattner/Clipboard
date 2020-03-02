#import <Cocoa/Cocoa.h>
#import <Foundation/Foundation.h>

//#import "AppDelegate.h"
@class AppDelegate;

@interface TableViewController : NSViewController <NSTableViewDataSource, NSTableViewDelegate>

@property (weak) AppDelegate * appDelegate;
@property (nonatomic, strong) NSArray *numbers;

- (void) didEscapeKeyDown;
- (void) didEnterKeyDown;


@end
