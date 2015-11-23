//
//  ITSprojectInterface.h
//  InterestedTourist
//
//  Created by qianfeng on 15/11/8.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#ifndef InterestedTourist_ITSprojectInterface_h
#define InterestedTourist_ITSprojectInterface_h

//首页广告
#define URL_ITS_AD @"http://api.breadtrip.com/v5/index/"

//首页精选推荐
#define URL_ITS_DATA @"http://api.breadtrip.com/v5/index/?next_start=2387135357"
//2387135357
#define path_act(page) [NSString stringWithFormat:URL_ITS_DATA, page]

//精选推荐游记界面
#define URL_ITS_TN @"http://api.breadtrip.com/trips/%@/trackpoints/"

//目的地首页
#define URL_DES @"http://open.qyer.com/qyer/footprint/continent_list?app_installtime=1442377290&client_id=qyer_ios&client_secret=cd254439208ab658ddf9&count=20&lat=38.88261142477122&lon=121.5393278677953&page=1&track_app_channel=App%2520Store&track_app_version=6.3&track_device_info=iPhone%25204S&track_deviceid=FA9EF80E-DDC3-4C2E-B562-DBDDB49D009A&track_os=ios%25206.1&v=1"

//目的地国家首页
#define URL_DES_CON @"http://open.qyer.com/qyer/footprint/country_detail?app_installtime=1442377290&client_id=qyer_ios&client_secret=cd254439208ab658ddf9&count=20&country_id=%d&page=1&track_app_version=6.3"




#define con_ID(id) [NSString stringWithFormat:URL_DES_CON, id]

//http://open.qyer.com/qyer/footprint/country_detail?app_installtime=1442377290&client_id=qyer_ios&client_secret=cd254439208ab658ddf9&count=20&country_id=11&page=1&track_app_channel=App%2520Store&track_app_version=6.3


//目的地城市首页（广告视图）

#define URL_DES_CITYADS @"http://open.qyer.com/qyer/footprint/city_detail?app_installtime=1442377290&city_id=%ld&client_id=qyer_ios&client_secret=cd254439208ab658ddf9&v=1"

//目的地
    //城市
        //景点
#define  URL_DES_DES @"http://open.qyer.com/qyer/onroad/poi_list?app_installtime=1442377290&category_id=32&city_id=%ld&client_id=qyer_ios&client_secret=cd254439208ab658ddf9&count=20&orderby=popular&page=1"
        //美食
#define URL_DES_FOOD @"http://open.qyer.com/qyer/onroad/poi_list?app_installtime=1442377290&category_id=78&city_id=%ld&client_id=qyer_ios&client_secret=cd254439208ab658ddf9&count=20&orderby=popular&page=1"
        //购物
#define URL_DES_BUY @"http://open.qyer.com/qyer/onroad/poi_list?app_installtime=1442377290&category_id=147&city_id=%ld&client_id=qyer_ios&client_secret=cd254439208ab658ddf9&count=20&orderby=popular&page=1"
        //活动
#define URL_DES_ACT @"http://open.qyer.com/qyer/onroad/poi_list?app_installtime=1442377290&category_id=148&city_id=%ld&client_id=qyer_ios&client_secret=cd254439208ab658ddf9&count=20&orderby=popular&page=1"


#define URL_DES_LAST @"http://open.qyer.com/qyer/footprint/poi_detail?app_installtime=1442377290&client_id=qyer_ios&client_secret=cd254439208ab658ddf9&count=20&page=1&poi_id=%@"


//抢特价首页
#define URL_Spp @"http://api.breadtrip.com/hunter/products/more/?start=0&city_name=%E5%85%A8%E9%83%A8%E5%9F%8E%E5%B8%82&lat=38.88238855942058&lng=121.53905415009308"





#endif


 