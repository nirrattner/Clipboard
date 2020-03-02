#import <Cocoa/Cocoa.h>
#import <Foundation/Foundation.h>

@interface TableViewController : NSViewController <NSTableViewDataSource, NSTableViewDelegate>

@property (nonatomic, strong) NSArray *numbers;

@end
