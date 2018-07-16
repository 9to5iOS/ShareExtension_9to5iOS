//
//  ShareViewController.m
//  shareAppExtension
//
//  Created by admin on 16/07/18.
//  Copyright © 2018 admin. All rights reserved.
//

#import "ShareViewController.h"
@import MobileCoreServices;

static NSString *const AppGrpId = @"group.tag.AppDemoGroup";

@interface ShareViewController ()

@end

@implementation ShareViewController

- (BOOL)isContentValid {
    // Do validation of contentText and/or NSExtensionContext attachments here
    return YES;
}

- (void)didSelectPost {
    // This is called after the user selects Post. Do the upload of contentText and/or NSExtensionContext attachments.
    
    // Inform the host that we're done, so it un-blocks its UI. Note: Alternatively you could call super's -didSelectPost, which will similarly complete the extension context.
    inputExtensionItem = self.extensionContext.inputItems.firstObject;
    
    NSItemProvider *urlItemProvider = [[inputExtensionItem.userInfo valueForKey:NSExtensionItemAttachmentsKey] objectAtIndex:0];
    
    if ([urlItemProvider hasItemConformingToTypeIdentifier:(__bridge NSString *)kUTTypeURL])
    {
        [urlItemProvider loadItemForTypeIdentifier:(__bridge NSString *)kUTTypeURL options:nil completionHandler:^(NSURL *url, NSError *error)
         {
             if (error)
             {
                 NSLog(@"Error occured");
             }
             else
             {
                 NSMutableArray *arr_shareLinks;
                 if ([sharedUserDefaults valueForKey:@"9to5iOS_SharedExtension"])
                     arr_shareLinks = [sharedUserDefaults valueForKey:@"SharedExtension"];
                 else
                     arr_shareLinks = [[NSMutableArray alloc] init];
                 NSDictionary *dictSite = [NSDictionary dictionaryWithObjectsAndKeys:self.contentText, @"contentText", url.absoluteString, @"URL",nil];
                 [arr_shareLinks addObject:dictSite];
                 [sharedUserDefaults setObject:arr_shareLinks forKey:@"9to5iOS_SharedExtension"];
                 [sharedUserDefaults synchronize];
                 
                 UIAlertController * alert=   [UIAlertController
                                               alertControllerWithTitle:@"9to5Success Alert"
                                               message:@"9to5iOS Posted Successfully."
                                               preferredStyle:UIAlertControllerStyleAlert];
                 UIAlertAction* ok = [UIAlertAction
                                      actionWithTitle:@"OK"
                                      style:UIAlertActionStyleDefault
                                      handler:^(UIAlertAction * action)
                                      {
                                          [UIView animateWithDuration:0.20 animations:^
                                           {
                                               self.view.transform = CGAffineTransformMakeTranslation(0, self.view.frame.size.height);
                                           }
                                                           completion:^(BOOL finished)
                                           {
                                               [self.extensionContext completeRequestReturningItems:nil completionHandler:nil];
                                           }];
                                      }];
                 
                 [alert addAction:ok];
                 [self presentViewController:alert animated:YES completion:nil];
             }
         }];
    }
   // [self.extensionContext completeRequestReturningItems:@[] completionHandler:nil];
}

-(void)viewDidLoad
{
    sharedUserDefaults = [[NSUserDefaults alloc] initWithSuiteName:AppGrpId];
    
    // here we must have to provide our app group id that we created
}


- (NSArray *)configurationItems {
    // To add configuration options via table cells at the bottom of the sheet, return an array of SLComposeSheetConfigurationItem here.
    return @[];
}

@end
