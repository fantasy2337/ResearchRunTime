//
//  ViewController.m
//  ResearchRunTime
//
//  Created by kk on 15/1/15.
//  Copyright (c) 2015年 刘 亚东. All rights reserved.
//

#import "ViewController.h"

#import  <objc/runtime.h>
@interface CustomClass : NSObject

-(void)test;

@end

@implementation CustomClass

-(void)test
{
    NSLog(@"%s",__func__);
}

@end



@interface TestClass : NSObject


-(void)testFun;

@end

@implementation TestClass

-(void)testFun{

    NSLog(@"%s",__func__);
}

@end

@interface ViewController ()

@end



@implementation ViewController


//对某对象进行复制和释放
-(void)copyObj
{
    CustomClass *obj = [CustomClass new];
    NSLog(@"CustomClass obj = %p",&obj);
    
//    id objTest = object_copy(obj, sizeof(obj)); //object_copy 对obj 对象进行copy 已经不再使用
//    object_dispose(obj); //释放obj对象，释放后在用obj调用其方法会crash  废弃
}



// 更改对象的类
-(void)resetObjectClass
{
    CustomClass * obj = [CustomClass new];
    [obj test];
    
    
    //将CustomClass对象 转化为TestClass类型的对象 ，返回值：obj原来的类型
    Class aClass = object_setClass(obj, [TestClass class]);
    
    NSLog(@"obj 原来的类型 ---aClass :%@",NSStringFromClass(aClass));
    NSLog(@"obj 更改后的类型 ---aClass obj :%@",NSStringFromClass([obj class]));

}


//得到obj的类名
-(void)getClassTest{

    CustomClass * obj = [CustomClass new];
    Class aLogClass = object_getClass(obj); //<==============> [obj class];
    NSLog(@"obj class = %@",NSStringFromClass(aLogClass));
}


void cfuntion(id self,SEL _cmd){
    
    printf("This is c funtion");

}


-(void)oneParam{

    
    
    class_addMethod([TestClass class], @selector(resolveThisMethodDynamically),(IMP)cfuntion, "v@:");
    
    TestClass * obj = [TestClass new];
    if ([obj respondsToSelector:@selector(resolveThisMethodDynamically)]) {
        NSLog(@"YES, obj response To selector ");
    }else {
        NSLog(@"--------sorry---------");
    }
    
    
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self resetObjectClass];
    [self getClassTest];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
