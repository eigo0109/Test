//
//  global.h
//  mlh
//
//  Created by qd on 13-5-8.
//  Copyright (c) 2013年 sunday. All rights reserved.
//

#ifndef global_h
#define global_h

#define PATH_OF_APP_HOME    NSHomeDirectory()
#define PATH_OF_TEMP        NSTemporaryDirectory()
#define PATH_OF_DOCUMENT    [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]

#define FLOAT_EQUAL 0.000001

#define UI_NAVIGATION_BAR_HEIGHT        44
#define UI_TOOL_BAR_HEIGHT              44
#define UI_TAB_BAR_HEIGHT               49
#define UI_STATUS_BAR_HEIGHT            20
#define UI_SCREEN_WIDTH                 ([[UIScreen mainScreen] bounds].size.width)
#define UI_SCREEN_HEIGHT                ([[UIScreen mainScreen] bounds].size.height)


#define LOAD_MORE_TEXT_HEIGHT 77
// 显示文字阈值
#define LOAD_MORE_THRESHOLD (UI_SCREEN_HEIGHT - UI_STATUS_BAR_HEIGHT - UI_NAVIGATION_BAR_HEIGHT - UI_TAB_BAR_HEIGHT - LOAD_MORE_TEXT_HEIGHT)
// 刷新阈值
#define LOAD_MORE_MAX       (LOAD_MORE_THRESHOLD + 10.0)


#define DEFAULT_VOID_COLOR [UIColor whiteColor]

#define nilOrJSONObjectForKey(JSON_, KEY_) ([JSON_ valueForKeyPath:KEY_] == [NSNull null] ? nil : [JSON_ valueForKeyPath:KEY_]);

#define BASE_URL @"http://app.mxsj.yunpod.com"




static NSString * const sBaseJsonURLStr = @"http://festival.o2o2m.com/";
static NSString * const sBaseJsonURLStrWeb = @"http://festival.o2o2m.com/";
//static NSString * const sBaseUploadUrlStr = @"http://admin.sunday-mobi.com/";
static NSString * const sBaseUploadUrlStr = @"http://festival.o2o2m.com/";

static NSString * const sVersionDownloadURL = @"itms-services://?action=download-manifest&url=https://raw.githubusercontent.com/sunwen812645842/sunday/master/guojl.plist";
static NSString * const sVersionURL = @"http://vipstatic.sunday-mobi.com/download/guojl/ios/versions.plist";

// 项目名称
static NSString * const sAppName = @"GUOJL";



#define APP_LOGIN_KEY @"www.GUOJL.com/loginKey"
#define KEY_USERNAME_PASSWORD @"com.GUOJL.usernamepassword"
#define KEY_USERNAME @"com.GUOJL.username"
#define KEY_PASSWORD @"com.GUOJL.password"

#define infoTypeNone    @"0" //HtmlDetailVC不显示toolbar
#define infoTypeInfo    @"1"
#define infoTypeActivity @"2"
#define infoTypeProduct @"3"
#define infoTypeVote    @"4"


#define kUserDefaultsEverLaunch @"kEverLaunch"
#define kUserDefaultsAppHasDownload @"kAppHasDownload"


#define kUserDefaultsLastVersionCheckDate @"kAppVersionCheckDate"

#define partnerGitUrl @"https://raw.githubusercontent.com/github568/ver/master/partner.json"

#define PROJECTID @"11"

#define DEVICE_SYSTEM_VERSION ([[[UIDevice currentDevice] systemVersion] floatValue])
#define iOS6 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 6.0 ? YES:NO)
#define iOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0 ? YES:NO)
#define iOS8 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0 ? YES:NO)


#define iPhone4 (CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) ? YES: NO)

#define iPhone5 (CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) ? YES: NO)

#define iPhone6 ((CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) || CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size)) ? YES: NO)

#define iPhone6P ((CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) || CGSizeEqualToSize(CGSizeMake(1125, 2001), [[UIScreen mainScreen] currentMode].size)) ? YES: NO)



#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define UIColorFromRGBAlpha(rgbValue,aValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:aValue]


static NSString * const jsonIndexInfos = @"mobi/active/indexGetByCode?1=1"; //首页活动
static NSString * const jsonActMenuList = @"mobi/active/getActives?1=1"; //活动列表
static NSString * const jsonActSearchList = @"mobi/active/searchActives?1=1"; //活动搜索
static NSString * const jsonActPreSign = @"mobi/active/preSign?1=1"; //活动报名（支付前）
static NSString * const jsonCommentList = @"mobi/active/getCommentList?1=1"; //获取活动列表
static NSString * const jsonUploadCommentImage = @"mobi/active/addCommentImage?1=1"; //上传评论图片
static NSString * const jsonAddComment = @"mobi/active/addComment?1=1"; //添加评论
static NSString * const jsonBuildAct = @"mobi/member/activeApply?1=1"; //我要办活动
static NSString * const jsonMyFavo = @"mobi/member/getMyFav?1=1"; //我的收藏
static NSString * const jsonisFavo = @"mobi/active/isFavourite?1=1"; //是否收藏（在活动详情里用）
static NSString * const jsonFavo = @"mobi/active/favourite?1=1"; //收藏和取消收藏
static NSString * const jsonMyAct = @"mobi/member/getMyFes?1=1"; //我的活动
static NSString * const jsonGroupList = @"mobi/club/getCatByCode?1=1"; //群体列表
static NSString * const jsonGroupDetail = @"mobi/club/getDetail?1=1"; //俱乐部详情
static NSString * const jsonGroupJoin = @"mobi/club/apply?1=1"; //申请加入俱乐部
static NSString * const jsonGroupMember = @"mobi/club/getMemberList?1=1"; //俱乐部成员列表
static NSString * const jsonMyGroup = @"mobi/member/getMyClub?1=1"; //我的群体
static NSString * const jsonFesList = @"mobi/member/getFesList?1=1"; //更多-节日列表
static NSString * const jsonFesDescr = @"mobi/member/getFesDesc?1=1"; //更多-节日简介
static NSString * const jsonFesDescDetail = @"mobi/member/getFesDescDetail?1=1"; //更多-节日简介详细
static NSString * const jsonSaveImage = @"mobi/ser/saveImage?1=1"; //通用上传图片（头像）
static NSString * const jsonUpdateInfo = @"mobi/member/updateMemberInfo?1=1"; //更新个人信息
static NSString * const jsonUpdatePwd = @"mobi/account/updatePassword?1=1"; //修改密码

static NSString * const jsonSendVerifycode = @"mobi/account/sendActiveCode?1=1"; //下发短信
static NSString * const jsonReg = @"mobi/account/reg?1=1"; //注册
static NSString * const jsonLog = @"mobi/account/log?1=1"; //登陆









static NSString * const jsonAd = @"mobi/getAdv?1=1";  //广告

static NSString * const jsonCate = @"mobi/getCategory?1=1"; //行业分类
static NSString * const jsonCateShop = @"mobi/getShops?1=1"; //分类下的店铺

static NSString * const jsonMarket = @"market/list?1=1"; //市场和商场列表

static NSString * const jsonShopProduct = @"mobi/getProductByShopId?1=1"; //店铺下的商品

static NSString * const jsonProductDetail = @"mobi/getProductDetail?1=1"; //商品详情
static NSString * const jsonRecommended = @"mobi/getRecProduct?1=1"; //同店推荐


static NSString * const jsonBalance = @"mobi/getBalance?1=1"; //我的余额
static NSString * const jsonPay = @"trade/userPay?1=1"; //支付

static NSString * const jsonMarketDetail = @"market/getMarket?1=1"; //市场/商场 详情、分类、广告
static NSString * const jsonMarketShop = @"market/getShopByMarket?1=1"; //市场下所有店
static NSString * const jsonMarketCateShop = @"market/getShopByMarketCat?1=1"; //市场下分类下的店

static NSString * const jsonAreaIdByName = @"mobi/getAreaIds?1=1"; //根据城市名和区县名得到省/市/区的ID

static NSString * const jsonAreaList = @"mobi/getCitys?1=1"; //得到省市区（迭代）

static NSString * const jsonNearby = @"mobi/getNearbyShops?1=1"; //附近

static NSString * const jsonLogin = @"user/log?1=1"; //登陆
static NSString * const jsonSendSms = @"user/sendActiveCode?1=1"; //下发短信

static NSString * const jsonRegister = @"user/reg?1=1"; //注册

static NSString * const jsonRecords = @"mobi/getRecordAsPage?1=1"; //我的交易记录


/////////////////

static NSString * const jsonErrLogSave = @"errlog_save?1=1";
static NSString * const jsonAppStartNumber = @"startnumber?1=1";  //启动数
static NSString * const jsonAppDownload = @"writedownload?1=1";   //下载量
//static NSString * const jsonLogin = @"shandi/expertLogin?1=1";   //登录

static NSString * const apiRegister = @"cheshi/cusReg?1=1"; //注册
static NSString * const apiVerify = @"cheshi/getYzm?1=1"; //验证码下发
static NSString * const apiLogin = @"cheshi/cusLog?1=1"; //登陆
static NSString * const apiOrder = @"cheshi/order?1=1"; //洗车 type=1 现在洗车 ；type=2 预约洗车
static NSString * const apiOrderDetail = @"cheshi/orderDetail?1=1"; //订单详情
static NSString * const apiShopList = @"cheshi/getCarServiceSpots?1=1"; //分店列表
static NSString * const apiInfoCenter = @"cheshi/infoCenter?1=1"; //消息中心 **
static NSString * const apiGetCitys = @"cheshi/getCitys?1=1"; //消息中心 **




typedef enum{   //4种状态, 可用于各种情况，比如异步变同步时作标志位  
    FlagWait,
    FlagNoWait,
    FlagSuccess,
    FlagFailure,
}WaitFlag;

#define HUDShowErrorServerOrNetwork [[tools shared] HUDShowHideText:@"服务器或网络异常" delay:2];

#endif
