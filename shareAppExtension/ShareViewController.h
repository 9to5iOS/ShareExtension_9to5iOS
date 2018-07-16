//
//  ShareViewController.h
//  shareAppExtension
//
//  Created by admin on 16/07/18.
//  Copyright © 2018 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Social/Social.h>

@interface ShareViewController : SLComposeServiceViewController
{
    NSUserDefaults *sharedUserDefaults;
    NSExtensionItem *inputExtensionItem;
}
@end
