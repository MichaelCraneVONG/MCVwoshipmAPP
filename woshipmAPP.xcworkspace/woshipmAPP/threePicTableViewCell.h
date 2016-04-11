//
//  threePicTableViewCell.h
//  woshipmAPP
//
//  Created by myApple on 16/4/9.
//  Copyright © 2016年 myApple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface threePicTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lab_Titile;
@property (weak, nonatomic) IBOutlet UIImageView *imgV_Image1;
@property (weak, nonatomic) IBOutlet UIImageView *imgV_Image2;
@property (weak, nonatomic) IBOutlet UIImageView *imgV_Image3;
@property (weak, nonatomic) IBOutlet UILabel *lab_Date;
@property (weak, nonatomic) IBOutlet UILabel *lab_Time;
@property (weak, nonatomic) IBOutlet UIImageView *lab_See;
@property (weak, nonatomic) IBOutlet UILabel *lab_NumberOfSee;
@property (weak, nonatomic) IBOutlet UIImageView *imgV_Good;
@property (weak, nonatomic) IBOutlet UILabel *lab_NumberOfGood;

@end
