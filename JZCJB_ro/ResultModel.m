//
//  ResultModel.m
//  JZCJB_ro
//
//  Created by ryhx on 16/3/7.
//  Copyright © 2016年 lay. All rights reserved.
//

#import "ResultModel.h"
#import <objc/runtime.h>
NSString * HeadName = @"tip_";
@implementation ResultModel

//定义常量 必须是C语言字符串
static char *AttributeNameKey = "AttributeNameKey";
+(void)creatAttribute:(char *)name{
    objc_property_attribute_t type = { "T", "@\"NSString\"" };
    objc_property_attribute_t ownership = { "C", "" }; // C = copy
    objc_property_attribute_t backingivar  = { "V", "tip_1" };
    objc_property_attribute_t attrs[] = { type, ownership ,backingivar};
    
    NSString * s = [NSString stringWithFormat:@"set%@:",[NSString stringWithCString:name encoding:NSUTF8StringEncoding]];
    SEL set = NSSelectorFromString(s);
    SEL get = NSSelectorFromString([NSString stringWithCString:name encoding:NSUTF8StringEncoding]);
    
    class_addProperty([self class], name, attrs, 3);
    class_addMethod([self class], @selector(setKey:value:), nil, "v@:@");
    class_addMethod([self class], @selector(get:), nil, "@@:");
    
    
//    class_addIvar([self class], name, sizeof(NSString *), 0, "@");
//   class_addMethod([self class], @selector(myclasstest:), (IMP)myclasstest, "v@:");
//    objc_registerClassPair([self class]);
    /*
     OBJC_ASSOCIATION_ASSIGN;            //assign策略
     OBJC_ASSOCIATION_COPY_NONATOMIC;    //copy策略
     OBJC_ASSOCIATION_RETAIN_NONATOMIC;  // retain策略
     
     OBJC_ASSOCIATION_RETAIN;
     OBJC_ASSOCIATION_COPY;
     */
    /*
     * id object 给哪个对象的属性赋值
     const void *key 属性对应的key
     id value  设置属性值为value
     objc_AssociationPolicy policy  使用的策略，是一个枚举值，和copy，retain，assign是一样的，手机开发一般都选择NONATOMIC
     objc_setAssociatedObject(id object, const void *key, id value, objc_AssociationPolicy policy);
     */
    
    //objc_setAssociatedObject(self, AttributeNameKey, name, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
//-(void)setTip_1:(NSString *)s{
//
//}
//-(id)tip{
//    return nil;
//}
-(void)setKey:(NSString *)key value:(NSString *)value{
    //objc_setAssociatedObject(self, [key UTF8String], value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(id)get:(NSString*)key{
    return objc_getAssociatedObject(self,[key UTF8String]);;
}
-(void)myclasstest{
}
//调用的是这个方法
static void get(id self, SEL _cmd, char * key) //self和_cmd是必须的，在之后可以随意添加其他参数
{
    Ivar v = class_getInstanceVariable([self class], key);
    //返回名为itest的ivar的变量的值
    id o = object_getIvar(self, v);
    //成功打印出结果
    NSLog(@"%@", o);
  
}

+(NSInteger)totalCount{
    return [ResultModel findAll].count;
}
+(NSInteger)menCount{
    return [[ResultModel findByCriteria:@"where gender = 1"] count];
}
+(NSInteger)womenCount{
    return [[ResultModel findByCriteria:@"where gender = 0"] count];
}


@end
