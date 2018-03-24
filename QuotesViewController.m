//
//  QuotesViewController.m
//  CWSingles
//
//  Created by Navin Arora on 9/6/17.
//  Copyright © 2017 String. All rights reserved.
//

#import "QuotesViewController.h"
#import "IIViewDeckController.h"
#import "AppDelegate.h"
#define FONT_SIZE 14.0f
#define CELL_CONTENT_WIDTH 320.0f
#define CELL_CONTENT_MARGIN 10.0f


@interface QuotesViewController ()
{
    NSMutableArray *LikeArray;
    NSMutableArray* arrayCount;
    NSMutableArray* notiArray;
    UIButton *slogan;
    int get_id;
    NSUserDefaults *defaultsData;
    int button;
    int saveid;
    int indexvalue;

    NSMutableArray*like_count;
    NSString*dataMatch;
    
}

@end

@implementation QuotesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    dataMatch=@"avlData";
    
    _liked_array=[[NSMutableArray alloc]init];
    like_count=[[NSMutableArray alloc]init];
    notiArray=[[NSMutableArray alloc]init];
    defaultsData = [NSUserDefaults standardUserDefaults];

    
    NSLog(@"%@",notiArray);
    
    
    NSString*notificationBody = [NSString stringWithFormat:@"%@", [defaultsData valueForKey:@"alertbody"]];
    
    NSLog(@">>>>notificationBody:%@",notificationBody);
    
    notiArray = [[defaultsData valueForKey:@"notificationarray"]mutableCopy];
    
    if (!notiArray || notiArray == nil )
    {
        notiArray=[[NSMutableArray alloc]init];
    }
    if ([notificationBody isEqualToString:@""] || [notificationBody isEqualToString:@"(null)"])
    {
        
    }
    else
    {
    [notiArray addObject:notificationBody];
    }
    [defaultsData setObject:notiArray forKey:@"notificationarray"];
    NSLog(@">>>>notificationBody:%@",notiArray);
    

    [[AppDelegate appDelegate].quotesArray removeAllObjects];
    
    activity.hidden=NO;
    [activity startAnimating];
    
    _liked_array=[[defaultsData objectForKey:@"notifictionlike"]mutableCopy];

  [AppDelegate appDelegate].quotesArray = [[defaultsData valueForKey:@"addNotification"]mutableCopy];
     NSLog(@">>>>notificationBody:%@",[AppDelegate appDelegate].quotesArray);
    
    
    
     [self LocalNotifictionLoad];
    
   menuBtn.hidden=NO;
   [menuBtn addTarget:self.viewDeckController action:@selector(toggleLeftView) forControlEvents:UIControlEventTouchUpInside];
    [self.viewDeckController setLeftLedge:70];
   
    
    
    
    self.navigationController.navigationBarHidden= YES;
    
    
    if (![AppDelegate appDelegate].quotesArray)
    {
   
        activity.hidden= YES;
        [activity stopAnimating];
        UILabel *notifyLbl=[[UILabel alloc]initWithFrame:CGRectMake(0, 120, self.view.frame.size.width, self.view.frame.size.height*0.33)];
        notifyLbl.text=[NSString stringWithFormat:@"No tips for you now, Please continue visit and wait for tips"];
        notifyLbl.textColor =[UIColor redColor];
        notifyLbl.numberOfLines=0;
        notifyLbl.textAlignment =NSTextAlignmentCenter;
        [self.view addSubview:notifyLbl];
        
        
    }
    else
    {
        
        
        NSOrderedSet *orderedSet1 = [NSOrderedSet orderedSetWithArray:notiArray];
        NSArray *arrayWithoutDuplicates1 = [orderedSet1 array];
        
        [notiArray setArray:arrayWithoutDuplicates1];
        
        
        
        
        NSOrderedSet *orderedSet = [NSOrderedSet orderedSetWithArray:[AppDelegate appDelegate].quotesArray];
        NSArray *arrayWithoutDuplicates = [orderedSet array];
        
        [[AppDelegate appDelegate].quotesArray setArray:arrayWithoutDuplicates];
        NSLog(@"%@",arrayWithoutDuplicates);
    }
   

    // Do any additional setup after loading the view.
} 

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    [self.viewDeckController closeLeftViewAnimated:YES];
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{

    CGSize constraint = CGSizeMake(tableView.frame.size.width-10, 20000.0f);
    CGSize size;
    
    NSStringDrawingContext *context = [[NSStringDrawingContext alloc] init];
    NSString *text = [notiArray objectAtIndex:indexPath.row];
    
    CGSize boundingBox = [text boundingRectWithSize:constraint
                                                  options:NSStringDrawingUsesLineFragmentOrigin
                                               attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:FONT_SIZE]}
                                                  context:context].size;
    
    size = CGSizeMake(ceil(boundingBox.width), ceil(boundingBox.height));
    
    return size.height + (CELL_CONTENT_MARGIN * 2)+55;

}
- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (!notiArray.count) {
        
        return 0;
        
        
    }
    else
    {
        return notiArray.count;
    }


}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
  
    
    
    
    
    UILabel *quotes= [[UILabel alloc] initWithFrame:CGRectZero];
    CGSize constraint = CGSizeMake(tableView.frame.size.width , 20000.0f);
    CGSize size;
    
    NSStringDrawingContext *context = [[NSStringDrawingContext alloc] init];
    NSString *text = [notiArray objectAtIndex:indexPath.row];
    
    CGSize boundingBox = [text boundingRectWithSize:constraint
                                            options:NSStringDrawingUsesLineFragmentOrigin
                                         attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:FONT_SIZE]}
                                            context:context].size;
    
    size = CGSizeMake(ceil(boundingBox.width), ceil(boundingBox.height));
    
    if (!quotes)
        quotes = (UILabel*)[cell viewWithTag:1];
    [quotes setNumberOfLines:0];
    
    [quotes setText:[NSString stringWithFormat:@"%@",[notiArray objectAtIndex:indexPath.row]]];
    [quotes setFrame:CGRectMake(5,5, tableView.frame.size.width-10, size.height+30)];
    
    quotes.textAlignment = UITextAlignmentLeft;
    quotes.font= [UIFont fontWithName:@"Open Sans" size:13.0];
    quotes.textColor= [UIColor whiteColor];
    
    
    UIImageView *backimg= [[UIImageView alloc] initWithFrame:CGRectMake(0,0,tableView.frame.size.width,size.height+ (CELL_CONTENT_MARGIN * 2)+55)];
    backimg.backgroundColor=[UIColor colorWithRed:(255/255.0) green:(90/255.0) blue:(95/255.0) alpha:1];

    backimg.layer.cornerRadius=5.0;
    backimg.clipsToBounds=YES;
    backimg.layer.borderColor= [[UIColor whiteColor]CGColor];
    backimg.layer.borderWidth=2.0;
    
    [cell.contentView addSubview:backimg];

    [cell.contentView addSubview:quotes];
  
    UILabel *counter= [[UILabel alloc] initWithFrame:CGRectMake(((tableView.frame.size.width-60)/2)+48,size.height+17,30,30)];
    counter.font=[UIFont fontWithName:@"Open Sans" size:13.0];
    counter.textAlignment=UITextAlignmentLeft;
    counter.text =@"20";
    
    
    int g;
    
    g=[[[[AppDelegate appDelegate].quotesArray objectAtIndex:indexPath.row ] valueForKey:@"id"]intValue];
    
    for (int j=0; j<like_count.count; j++)
    {
        
        
        int f=[[[like_count valueForKey:@"id"] objectAtIndex:j]intValue];;
        
        if (f==g) {
            
            counter.text =[NSString stringWithFormat:@"%@",[[like_count valueForKey:@"likes"] objectAtIndex:j]];
            
            
            
        }
        
    }
    
 
    
    
    counter.backgroundColor=[UIColor clearColor];
    counter.textColor=[UIColor whiteColor];
    [cell.contentView addSubview:counter];
    
   slogan= [[UIButton alloc] initWithFrame:CGRectMake((tableView.frame.size.width-60)/2,size.height+37,50,25)];
    
    slogan.font=[UIFont fontWithName:@"Open Sans" size:13.0];
    [slogan setTitle:@"Like" forState:UIControlStateNormal]; // To set t
    slogan.backgroundColor=[UIColor clearColor];
    slogan.layer.cornerRadius=5.0;
    slogan.clipsToBounds=YES;
    slogan.layer.borderColor= [[UIColor whiteColor]CGColor];
    slogan.layer.borderWidth=2.0;
    
    slogan.titleLabel.textColor=[UIColor whiteColor];
    slogan.tag=indexPath.row;
    
    
    [ slogan addTarget:self
                action:@selector(yourButtonClicked:) forControlEvents:UIControlEventTouchDown];
    [cell.contentView addSubview:slogan];
    
    indexvalue=[[[[AppDelegate appDelegate].quotesArray objectAtIndex:indexPath.row ] valueForKey:@"id"]intValue];
    
    
    
    for (int j=0; j<_liked_array.count; j++)
    {
        
        saveid=[[_liked_array objectAtIndex:j]intValue];
        
        
        if (indexvalue==saveid) {
            
            [slogan setTitle:@"Liked" forState:UIControlStateNormal];
            
            
        }
    }

    activity.hidden=YES;
    [activity stopAnimating];
  
   return cell;
    
}


-(IBAction)yourButtonClicked:(UIButton *)sender
{
    
    
    dataMatch=@"";
    button =sender.tag;
    
    get_id=[[[[AppDelegate appDelegate].quotesArray objectAtIndex:sender.tag] valueForKey:@"id"]intValue];
    
    if (_liked_array) {
        NSMutableArray *subArray = [[NSMutableArray arrayWithObjects: [NSString stringWithFormat:@"%d",get_id], nil]mutableCopy];
        [_liked_array addObjectsFromArray:subArray];
        
        [defaultsData setObject:_liked_array forKey:@"notifictionlike"];
        
        
        
    }
    else{
        NSMutableArray *subArray = [[NSMutableArray arrayWithObjects: [NSString stringWithFormat:@"%d",get_id], nil]mutableCopy];
        [defaultsData setObject:subArray forKey:@"notifictionlike"];
        
        
        
    }
    
    [self LocalNotifictionLoad];
    _liked_array=[[defaultsData objectForKey:@"notifictionlike"]mutableCopy];
    [_archivetabel reloadData];
    
   
}

-(void)LocalNotifictionLoad{
    
    [activity startAnimating];
    activity.hidden=NO;
    
    NSNumber *like_row = [NSNumber numberWithInt:get_id];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    NSMutableDictionary *dict1 = [[NSMutableDictionary alloc]init];
    [dict1 setValue:[NSString stringWithFormat:@"%d", [AppDelegate appDelegate].userID] forKey:@"userid"];
    
    [dict1 setValue:[AppDelegate appDelegate].userName forKey:@"username"];
    [dict1 setValue:[AppDelegate appDelegate].pwdStr forKey:@"password"];
    [dict1 setValue:@"add" forKey:@"mode"];
    if (dataMatch) {
        
        [dict1 setValue:@"" forKey:@"notification_id"];
        
    }
    else{
        [dict1 setValue:like_row forKey:@"notification_id"];
    }

    NSDictionary *dict =[[AppDelegate appDelegate] appendComman];
    
    NSMutableDictionary *combinedAttributes = [dict1 mutableCopy];
    [combinedAttributes addEntriesFromDictionary:dict];
    [manager POST:[NSString stringWithFormat:@"%sjson_localnotifications.php",URLBase] parameters:combinedAttributes
constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
     {
         
     } success:^(AFHTTPRequestOperation *operation, id responseObject)
     
     {
         NSLog(@"ResponseObject: %@", responseObject);
         int errCode= [[responseObject valueForKey:@"errcode"]intValue];
         if (errCode==0) {
             
             NSArray*array=[responseObject valueForKey:@"notifications"];
             
             for (NSDictionary*dict in array) {
                 
                 
                 [like_count addObject:dict];
                 
                 
                 
             }

             [_archivetabel reloadData];
             if (dataMatch) {
                 
                 
             }
             else{
                 [self alertview:@"Liked"];
                 activity.hidden=YES;
                 [activity stopAnimating];
             }

             
    
             
         }
         
         
     }
          failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         
         [self alertview:@"Please check internet connection"];
     }];


}


-(void)alertview:(NSString *)show_alert
{
    
    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:@"Alert"
                                 message:show_alert
                                 preferredStyle:UIAlertControllerStyleAlert];
    
    
    
    UIAlertAction* my_alert = [UIAlertAction
                               actionWithTitle:@"OK"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action) {
                                   //Handle your yes please button action here
                               }];
    
    
    [alert addAction:my_alert];
    
    [self presentViewController:alert animated:YES completion:nil];
    
}





@end
