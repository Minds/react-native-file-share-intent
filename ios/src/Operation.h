//
//  Operation.h
//  RNFileShareIntent
//
//  Created by Valentyn Halkin on 8/19/19.
//  Copyright © 2019 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 Abstract class for asynchronus operations.
 */
@interface Operation : NSOperation

/**
 Finishes the execution of the operation.
 
 @note - This shouldn’t be called externally as this is used internally by subclasses. To cancel an operation use cancel instead.
 */
- (void)finish;

@end
