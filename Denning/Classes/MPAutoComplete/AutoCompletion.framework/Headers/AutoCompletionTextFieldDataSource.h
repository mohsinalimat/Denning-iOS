//
//  AutoCompletionTextFieldDataSource.h
//  AutoCompletion
//


#import <Foundation/Foundation.h>

@class AutoCompletionTextField;
typedef void (^FetchCompletionBlock)(NSArray *items, NSString* titleKey, NSString* titleValue);

@protocol AutoCompletionTextFieldDataSource <NSObject>

@required
- (void)fetchSuggestionsForIncompleteString:(NSString*)incompleteString
                 withCompletionBlock:(FetchCompletionBlock)completion;

@end
