//
//  ShareFileIntentModule.m
//  Share Intent
//
//  Created by Ajith A B on 16/08/19.
//  Copyright :copyright: 2019 Facebook. All rights reserved.
//

#import "RNFileShareIntent.h"
#import "RCTRootView.h"
#import "MobileCoreServices/MobileCoreServices.h"
#import "RCTLog.h"
@implementation RNFileShareIntent
static NSItemProvider* ShareFileIntentModule_itemProvider;
static NSExtensionContext* extContext;

RCT_EXPORT_MODULE();

RCT_EXPORT_METHOD(getFilePath:(RCTResponseSenderBlock)callback)
{
    NSItemProvider *itemProvider = ShareFileIntentModule_itemProvider;
    NSExtensionItem *inputItem = extContext.inputItems.firstObject;
    for (itemProvider in [inputItem.userInfo valueForKey:NSExtensionItemAttachmentsKey]) {
        if ([itemProvider hasItemConformingToTypeIdentifier:(NSString *) kUTTypeURL]) {
            break;
        }
    }
    
    if (!itemProvider) {
        for (itemProvider in [inputItem.userInfo valueForKey:NSExtensionItemAttachmentsKey]) {
            if ([itemProvider hasItemConformingToTypeIdentifier:(NSString *) kUTTypeText]) {
                break;
            }
        }
    }
    
    ShareFileIntentModule_itemProvider = itemProvider;
    
    if ([ShareFileIntentModule_itemProvider hasItemConformingToTypeIdentifier:(NSString *)kUTTypeURL]) {
        [ShareFileIntentModule_itemProvider loadItemForTypeIdentifier:(NSString *)kUTTypeURL options:nil completionHandler:^(NSURL *url, NSError *error) {
            callback(@[url.absoluteString]);
        }];
    }
    
    if ([ShareFileIntentModule_itemProvider hasItemConformingToTypeIdentifier:(NSString *)kUTTypeFileURL]) {
        [ShareFileIntentModule_itemProvider loadItemForTypeIdentifier:(NSString *)kUTTypeFileURL options:nil completionHandler:^(NSString *url, NSError *error) {
            callback(@[url]);
        }];
    }
    if ([ShareFileIntentModule_itemProvider hasItemConformingToTypeIdentifier:(NSString *)kUTTypePDF]) {
        [ShareFileIntentModule_itemProvider loadItemForTypeIdentifier:(NSString *)kUTTypePDF options:nil completionHandler:^(NSString *url, NSError *error) {
            callback(@[url]);
        }];
    }
    
    if ([ShareFileIntentModule_itemProvider hasItemConformingToTypeIdentifier:(NSString *)kUTTypeBMP]) {
        [ShareFileIntentModule_itemProvider loadItemForTypeIdentifier:(NSString *)kUTTypeBMP options:nil completionHandler:^(NSString *url, NSError *error) {
            callback(@[url]);
        }];
    }
    
    if ([ShareFileIntentModule_itemProvider hasItemConformingToTypeIdentifier:(NSString *)kUTTypeGIF]) {
        [ShareFileIntentModule_itemProvider loadItemForTypeIdentifier:(NSString *)kUTTypeGIF options:nil completionHandler:^(NSString *url, NSError *error) {
            callback(@[url]);
        }];
    }
    if ([ShareFileIntentModule_itemProvider hasItemConformingToTypeIdentifier:(NSString *)kUTTypeICO]) {
        [ShareFileIntentModule_itemProvider loadItemForTypeIdentifier:(NSString *)kUTTypeICO options:nil completionHandler:^(NSString *url, NSError *error) {
            callback(@[url]);
        }];
    }
    if ([ShareFileIntentModule_itemProvider hasItemConformingToTypeIdentifier:(NSString *)kUTTypeMP3]) {
        [ShareFileIntentModule_itemProvider loadItemForTypeIdentifier:(NSString *)kUTTypeMP3 options:nil completionHandler:^(NSString *url, NSError *error) {
            callback(@[url]);
        }];
    }
    if ([ShareFileIntentModule_itemProvider hasItemConformingToTypeIdentifier:(NSString *)kUTTypePNG]) {
        [ShareFileIntentModule_itemProvider loadItemForTypeIdentifier:(NSString *)kUTTypePNG options:nil completionHandler:^(NSString *url, NSError *error) {
            callback(@[url]);
        }];
    }
    if ([ShareFileIntentModule_itemProvider hasItemConformingToTypeIdentifier:(NSString *)kUTTypeJPEG]) {
        [ShareFileIntentModule_itemProvider loadItemForTypeIdentifier:(NSString *)kUTTypeJPEG options:nil completionHandler:^(NSString *url, NSError *error) {
            callback(@[url]);
        }];
    }
    if ([ShareFileIntentModule_itemProvider hasItemConformingToTypeIdentifier:(NSS
tring *)kUTTypeMPEG]) {
        [ShareFileIntentModule_itemProvider loadItemForTypeIdentifier:(NSString *)kUTTypeMPEG options:nil completionHandler:^(NSString *url, NSError *error) {
            callback(@[url]);
        }];
    }
    if ([ShareFileIntentModule_itemProvider hasItemConformingToTypeIdentifier:(NSString *)kUTTypeImage]) {
        [ShareFileIntentModule_itemProvider loadItemForTypeIdentifier:(NSString *)kUTTypeImage options:nil completionHandler:^(NSString *url, NSError *error) {
            callback(@[url]);
        }];
    }
    if ([ShareFileIntentModule_itemProvider hasItemConformingToTypeIdentifier:(NSString *)kUTTypeText]) {
        [ShareFileIntentModule_itemProvider loadItemForTypeIdentifier:(NSString *)kUTTypeText options:nil completionHandler:^(NSString *url, NSError *error) {
            callback(@[url]);
        }];
    }
    if ([ShareFileIntentModule_itemProvider hasItemConformingToTypeIdentifier:(NSString *)kUTTypeAudio]) {
        [ShareFileIntentModule_itemProvider loadItemForTypeIdentifier:(NSString *)kUTTypeAudio options:nil completionHandler:^(NSString *url, NSError *error) {
            callback(@[url]);
        }];
    }
    if ([ShareFileIntentModule_itemProvider hasItemConformingToTypeIdentifier:(NSString *)kUTTypeVideo]) {
        [ShareFileIntentModule_itemProvider loadItemForTypeIdentifier:(NSString *)kUTTypeVideo options:nil completionHandler:^(NSString *url, NSError *error) {
            callback(@[url]);
        }];
    }
    if ([ShareFileIntentModule_itemProvider hasItemConformingToTypeIdentifier:(NSString *)kUTTypeInkText]) {
        [ShareFileIntentModule_itemProvider loadItemForTypeIdentifier:(NSString *)kUTTypeInkText options:nil completionHandler:^(NSString *url, NSError *error) {
            callback(@[url]);
        }];
    }
    if ([ShareFileIntentModule_itemProvider hasItemConformingToTypeIdentifier:@"public.url"]) {
        [ShareFileIntentModule_itemProvider loadItemForTypeIdentifier:@"public.url" options:nil completionHandler:^(NSURL *url, NSError *error) {
            callback(@[url.absoluteString]);
        }];
    }
    if ([ShareFileIntentModule_itemProvider hasItemConformingToTypeIdentifier:@"public.plain-text"]) {
        [ShareFileIntentModule_itemProvider loadItemForTypeIdentifier:@"public.plain-text" options:nil completionHandler:^(NSString *url, NSError *error) {
            callback(@[url]);
        }];
    }
}

RCT_EXPORT_METHOD(openURL:(NSString *)url) {
    UIApplication *application = [UIApplication sharedApplication];
    NSURL *urlToOpen = [NSURL URLWithString:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    [application openURL:urlToOpen options:@{} completionHandler: nil];
}


RCT_EXPORT_METHOD(close)
{
    
    [ extContext completeRequestReturningItems: @[] completionHandler: nil ];
}

+(void) setShareFileIntentModule_itemProvider: (NSItemProvider*) itemProvider
{
    ShareFileIntentModule_itemProvider = itemProvider;
}

+(void) setContext: (NSExtensionContext*) context
{
    extContext = context;
}
@end