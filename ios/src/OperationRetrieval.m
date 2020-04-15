//
//  OperationRetrieval.m
//  RNFileShareIntent
//
//  Created by Valentyn Halkin on 8/19/19.
//  Copyright © 2019 Facebook. All rights reserved.
//

#import "OperationRetrieval.h"
#import "FileHelper.h"

@interface OperationRetrieval ()

/**
 Completion block to be called once the the request and parsing is completed. Will return the parsed answers or nil.
 */
@property (nonatomic, copy) void (^completion)(NSDictionary *file);
@property (nonatomic, copy) NSItemProvider *item;
@property (nonatomic, copy) NSString *type;

@end

@implementation OperationRetrieval

#pragma mark - Init

- (instancetype)initWithItemProvider:(NSItemProvider *)item type:(NSString *)type completion:(void (^)(NSDictionary *file))completion {
    self = [super init];
    
    if (self)
    {
        self.completion = completion;
        self.item = item;
        self.type = type;
        self.name = @"URL-Retrieval";
    }
    
    return self;
}

#pragma mark - Start

- (void)start
{
    [super start];
    
    [self.item loadItemForTypeIdentifier:self.type options:nil completionHandler:^(NSURL *url, NSError *error) {
        if (self.completion)
        {
            self.completion([FileHelper getFileData:url]);
        }
        
        [self finish];
    }];
}

#pragma mark - Cancel

- (void)cancel
{
    [super cancel];
    
    [self finish];
}
@end
