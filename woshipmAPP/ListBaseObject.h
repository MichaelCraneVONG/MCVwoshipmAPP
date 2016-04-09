//
//  ListBaseObject.h
//  woshipmAPP
//
//  Created by myApple on 16/4/9.
//  Copyright © 2016年 myApple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ListBaseObject : NSObject
//"id":315623,
//"type":"it",
//"title":"基于角色的导航系统：我反对的五大理由",
//"image":"http://image.woshipm.com/wp-files/2016/04/daohang-202x150.jpg",
//"creator":"逗比联盟会长",
//"tag":"业界动态 导航系统 用户导航",
//"link":"http://api.woshipm.com/m/news/detail.htm?sf=app&id=315623",
//"description":"“你是怎么看待基于角色的导航的？”这个问题在我的例行可用性周会上常常被问起，我很清楚大家为什么关心这个问题。这 ...",
//"publishTime":1460185401000,
//"clickCount":594,
//"praiseCount":4,
//"tClickCount":51

@property (nonatomic,strong)NSString *strId;
@property (nonatomic,strong)NSString *strType;
@property (nonatomic,strong)NSString *strTitle;
@property (nonatomic,strong)NSString *strImage;
@property (nonatomic,strong)NSString *strCreator;
@property (nonatomic,strong)NSString *strTag;
@property (nonatomic,strong)NSString *strLink;
@property (nonatomic,strong)NSString *strDescription;
@property (nonatomic,strong)NSString *strPublishTime;
@property (nonatomic,strong)NSString *strClickCount;
@property (nonatomic,strong)NSString *strPraiseCount;
@property (nonatomic,strong)NSString *strTClickCount;
@end
