//
//  PayConfig.h
//  base_project
//
//  Created by jangbuk on 15/12/3.
//  Copyright © 2015年 jangbuk. All rights reserved.
//

#pragma mark--支付宝支付

/**
 *  将支付宝的配置信息 写入对应的宏定义里
 */
/*
#define AliPay_PrivateKey @"MIICdgIBADANBgkqhkiG9w0BAQEFAASCAmAwggJcAgEAAoGBAOyzGCdwl8k3yF4fdyJRe6tYiFcH+ILV/av53xY20zcygy0cQij85w1obEbRnkui5MeB4Uzw5iFocSguApsQDNsmfyshuZUCrxNztzetLOZbyzkXDmmh0oMb8/cU1EB6TDfNTh8h6xqTKHdpbxwK9ByCevLr80wKOVL+AerAbbJpAgMBAAECgYABAQl7MVkTe28YJx4EQUA7C9cYN2pwc6Pt1NODbpwawdYYnOQS9G+ueODss/rt6zT5O63O+76eKalBOGC+c6T6TurL4fADqSauaaHc4rbFvPdMH9tD9ZSMwrEhdXVKsfv3FSpWayj6CqB3MC3Cvy2XYSDRnq5PJa2ayojjiducOQJBAPot26EdPtsQdGgd2sYwnHmfacR5Q8V/2vsJDtMHdtzT4Ntejv66fxnY3dyzgp7mFXxBGlEPbY26EefHdjXvrZ8CQQDyNPK9e44s1G7fJNtzRYqVtO9pPsGg6zTMTGFEys33G0VUFMfaE9/7m0froPZ8UahvBZbDeTUPJJPWEAcxCBL3AkADBQCsniS/EiDFjO6yC64nzaPCKlCGFrf25bIXG/T0T15cZ3TEYE3eav6qhkQiVNaXjFWb+tqwpjlHGeI0XnMzAkBW9d+5XGUdf2AXSfpolq09NutGVDvc9NXODBZYRqBQekAYAiYHDF+8zHG0DeSxmffpdI4+vIPqXe2eS77pQcbdAkEA7iyWIXxwhxNcRfu4URzwg2UNOTzSFnheHW98Oxo8T8qOIPEUXaI0CzPIISPrsUJy9OHqAH2BmNN53VPS/5whHg=="

#define AliPay_Partner @"2088611881165043"

#define AliPay_Seller @"473276@qq.com"

#define AliPay_NotifyURL @"http://daping.api.yunfengapp.com:8888/Alipay/PayNotify.aspx"

#define AliPay_AppScheme @"baseproject"//info.plist 中配置的跳转信息
*/

#define AliPay_PrivateKey @"MIICdgIBADANBgkqhkiG9w0BAQEFAASCAmAwggJcAgEAAoGBAM3f/wp5zMmTKhxxsC5so1mvvEVxy4YIVCuGoZ/feOSlrIE1mrnlm8go+V/Qu05BiSjyWdGCzwtPf+3Tn2KWXrTaA7e9MQ7CFfsOcOLL5MJ0FkHGumZiherZnr57M8D8Mc4mLxEVf3h6SkzWMwspropNlxuLm+/HTAUX8LIDn399AgMBAAECgYAub32ZIUvdk4IGFGaGsh5OFmNCzp33R12ky6Mc6kzcVboJEswpbe6rQQKuZ+g3iHSldbRomzaT+ISEYh0rIXuOq1MDZBzmOhy9q+SN3zibTb7hVp7KS3C4k6hJ+IOFtwv4cNpbRL/r9oXmTnh6FDuaS1JHvh2Ttr56sQqIthofwQJBAPhyznqsTcHYSzYP0/grI4PNabQr5gb/66Xl8i1LrJOD1XZyjSw/6R7qT2jvdCqkDcWKUNd8vRQWLMlzycIvkjUCQQDUIew4Fn/U7aUqiJUeFPLkVOnZitlEF2bLPhYrqN0ebIRT1NQBt0CM+iTEiPUpRMVbQTaf8MDPFuyTzzVYj2EpAkEAtP7ubXAZNZ7dLAVb5u+Gb/61gwx4B6FpivJ5+4Wls9HXMPNC5Xmp21vXfhr0Bhx96+tX+aRmGrwM5LX1xgHiAQJAGLq7pu44iMILdyHlAFTA3A1qFYoyOdXgjeD3BK/y1xEffAZbkLekNssSbjbpHZ5+w1ye2ZZfY8TwX2rQdTqBwQJABipg5eVMsIeNo3pEGSticG5SjWptMoxo60k9/IuypBDz0zm18+zVLyPRQR5zF9zd793HzduoyCAL43TNn6dCwg=="

#define AliPay_Partner @"2088121049811861"

#define AliPay_Seller @"1654171312@qq.com"

#define AliPay_NotifyURL @"http://daping.api.yunfengapp.com:8888/Alipay/PayNotify.aspx"

#define AliPay_AppScheme @"baseproject"//info.plist 中配置的跳转信息
#pragma mark--微信支付

/**
 *  将微信支付的配置信息 写入对应的宏定义里
 */

//APPID
#define WeChat_App_ID  @"wx7d09cdaa382814f1"

//appsecret
#define WeChat_App_Secret @"be91b2a541dea2bb79ca8dfe7919f4ad"

//商户号，填写商户对应参数
#define WeChat_MCH_ID   @"1246495701"

//商户API密钥，填写相应参数
#define WeChat_Partner_ID @"433ad8747fbe97fe8e5216627b0814e3"

//支付结果回调页面
#define WeChat_Notify_URL @"http://daping.api.yunfengapp.com:8888/WechatPay/PayNotify.aspx"

//获取服务器端支付数据地址（商户自定义）
#define WeChat_SP_URL @"http://wxpay.weixin.qq.com/pub_v2/app/app_pay.php"

