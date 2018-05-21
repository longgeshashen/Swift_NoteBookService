//
//  main.swift
//  PerfectTemplate
//
//  Created by Kyle Jessup on 2015-11-05.
//	Copyright (C) 2015 PerfectlySoft, Inc.
//
//===----------------------------------------------------------------------===//
//
// This source file is part of the Perfect.org open source project
//
// Copyright (c) 2015 - 2016 PerfectlySoft Inc. and the Perfect project authors
// Licensed under Apache License v2.0
//
// See http://perfect.org/licensing.html for license information
//
//===----------------------------------------------------------------------===//
//

import PerfectHTTP
import PerfectHTTPServer
import PerfectMustache

//MARK:------------------------高级用法------------------//
//初始化服务对象
let server = HTTPServer()
//初始化路由对象
var routes = Routes()

//MARK:-----------------NoteBook实战接口----------------//
//查询用户信息
routes.add(method: .post, uri: "/queryUserInfoByUserName") { (request, response) in
    guard let userName : String = request.param(name: "userName") else {
        print("username 为空，不存在")
        return
    }
    
    guard let json = UserOperator().queryUserInfo(userName: userName) else {
        print("json 为nil")
        return
    }
    print(json)
    response.setBody(string: json)
    response.completed()
}
//注册
routes.add(method: .post, uri: "/register") { (request, response) in
    guard let userName: String = request.param(name: "userName") else {
        print("userName为nil")
        return
    }
    
    guard let password: String = request.param(name: "password") else {
        print("password为nil")
        return
    }
    guard let json = UserOperator().insertUserInfo(userName: userName, password: password) else {
        print("josn为nil")
        return
    }
    print(json)
    response.setBody(string: json)
    response.completed()
}

//登录
routes.add(method: .post, uri: "/login") { (request, response) in
    guard let userName: String = request.param(name: "userName") else {
        print("userName为nil")
        return
    }
    guard let password: String = request.param(name: "password") else {
        print("password为nil")
        return
    }
    guard let json = UserOperator().queryUserInfo (userName: userName, password: password) else {
        print("josn为nil")
        return
    }
    print(json)
    response.setBody(string: json)
    response.completed()
}

//content表方法
//获取内容列表
routes.add(method: .post, uri: "/contentList") { (request, response) in
    guard let userId: String = request.param(name: "userId") else {
        print("userId为nil")
        return
    }
    
    guard let json = ContentOperator().queryContentList(userId: userId) else {
        print("josn为nil")
        return
    }
    print(json)
    response.setBody(string: json)
    response.completed()
}

//获取详情
routes.add(method: .post, uri: "/contentDetail") { (request, response) in
    guard let contentId: String = request.param(name: "contentId") else {
        print("contentId为nil")
        return
    }
    guard let json = ContentOperator().queryContentDetail(contentId: contentId) else {
        print("josn为nil")
        return
    }
    print(json)
    response.setBody(string: json)
    response.completed()
}

//添加内容
routes.add(method: .post, uri: "/contentAdd") { (request, response) in
    guard let userId: String = request.param(name: "userId") else {
        print("userId为nil")
        return
    }
    
    guard let title: String = request.param(name: "title") else {
        print("title为nil")
        return
    }
    
    guard let content: String = request.param(name: "content") else {
        print("content为nil")
        return
    }
    
    guard let json = ContentOperator().addContent(userId: userId, title: title, content: content) else {
        print("josn为nil")
        return
    }
    print(json)
    response.setBody(string: json)
    response.completed()
}

//更新内容
routes.add(method: .post, uri: "/contentUpdate") { (request, response) in
    guard let contentId: String = request.param(name: "contentId") else {
        print("contentId为nil")
        return
    }
    
    guard let title: String = request.param(name: "title") else {
        print("title为nil")
        return
    }
    
    guard let content: String = request.param(name: "content") else {
        print("content为nil")
        return
    }
    
    guard let json = ContentOperator().updateContent(contentId: contentId, title: title, content: content) else {
        print("josn为nil")
        return
    }
    print(json)
    response.setBody(string: json)
    response.completed()
}

//删除内容
routes.add(method: .post, uri: "/contentDelete") { (request, response) in
    guard let contentId: String = request.param(name: "contentId") else {
        print("contentId为nil")
        return
    }
    
    guard let json = ContentOperator().deleteContent(contentId: contentId) else {
        print("josn为nil")
        return
    }
    print(json)
    response.setBody(string: json)
    response.completed()
}
////////////////////////////////////////////



//MARK: 配置server
//注意：浏览器编码设置为UTF-8，否则页面显示乱码
//配置服务器：端口、document路径、添加路由
server.addRoutes(routes)

server.serverPort = 8181

server.documentRoot = "./wwwroot"

/*
 //基本启动方法
 do {
 // Launch the servers based on the configuration data.
 try HTTPServer.launch(configurationData: confData)
 
 } catch {
 fatalError("\(error)") // fatal error launching one of the servers
 }
 */
//MARK:--高级启动方法
do {
    // Launch the servers based on the configuration data.
    try server.start()
    
} catch {
//    fatalError("\(error)") // fatal error launching one of the servers
}

