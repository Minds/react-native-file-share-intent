//
//  OperationRetrieval.h
//  RNFileShareIntent
//
//  Created by Valentyn Halkin on 8/19/19.
//  Copyright © 2019 Facebook. All rights reserved.
//

#import "Operation.h"

@interface OperationRetrieval : Operation

/**
 Init for creating `OperationRetrieval` instance with the completion block.
 
 @param completion - block that will be called once network request has been completed. Will return an array of answers or nil.
 
 @return `OperationRetrieval` instance.
 */
- (instancetype)initWithItemProvider: (NSItemProvider *)item type: (NSString *)type completion:(void (^)(NSDictionary *file))completion;

@end
