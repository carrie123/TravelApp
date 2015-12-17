//
//  PackageDB.h
//  TravalApp
//
//  Created by qianfeng on 15/12/18.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "PackageDB.h"
#import "PackageDetailModel.h"

@implementation PackageDB

@dynamic name;
@dynamic category_title;
@dynamic country_name_cn;
@dynamic cover;
@dynamic cover_updatetime;
@dynamic file;

/**
 *  初始化模型
 */
- (void)updateWithPackageDetailModel:(PackageDetailModel *)model
{
    self.name = model.name;
    self.category_title = model.category_title;
    self.country_name_cn = model.country_name_cn;
    self.cover = model.cover;
    self.cover_updatetime = model.cover_updatetime;
    self.file = [model.mobile_guide objectForKey:@"file"];
}


@end
