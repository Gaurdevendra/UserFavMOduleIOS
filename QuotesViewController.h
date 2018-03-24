//
//  QuotesViewController.h
//  CWSingles
//
//  Created by Navin Arora on 9/6/17.
//  Copyright © 2017 String. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ArchiveTableViewCell.h"
#import "Utility.h"
#import "AFHTTPRequestOperation.h"
#import "AFHTTPRequestOperationManager.h"

@interface QuotesViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate>
{
    IBOutlet UIButton *menuBtn;
    IBOutlet UIActivityIndicatorView *activity;
}

@property (strong, nonatomic) IBOutlet UITableView *archivetabel;

@property (nonatomic,copy)  NSMutableArray*liked_array;

@end
