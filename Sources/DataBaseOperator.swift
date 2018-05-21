//
//  DataBaseOperator.swift
//  PerfectTemplate
//
//  Created by SSLong on 2018/5/14.
//

import Foundation
import PerfectMySQL

class MySQLConnect {
    var host: String {
        get {
            return "127.0.0.1"
        }
    }
    var port: String {
        get {
            return "3306"       //数据库端口
        }
    }
    
    var user: String {          //数据库用户名
        get {
            return "root"
        }
    }
    
    var password: String {      //数据库密码
        get {
            return "ssl998"
        }
    }
    
    private var connect: MySQL!   //用于操作MySql的句柄
    private static var instance:MySQL!
    public static func shareInstance(dataBaseName: String) -> MySQL {
        if instance == nil {
            instance = MySQLConnect(dataBaseName: dataBaseName).connect
        }
        return instance
    }
    
    private init(dataBaseName: String) {
        self.connectDataBase()
        self.selectDataBase(name: dataBaseName)
    }
    
    //连接数据库
    private func connectDataBase() {
        if connect == nil {
            connect = MySQL()
        }
        
        let connected = connect.connect(host: "\(host)", user: user, password: password)
        guard connected else {
            print("连接数据库失败")
            return
        }
        print("连接数据库成功")
    }
    
    //选择数据库Schema
    func selectDataBase(name: String) {
        print("表名字是：\(name)")
        guard connect.selectDatabase(named: name) else {
            print("选择数据库失败")
            return
        }
        
        print("选择数据库成功")
    }
    
    deinit {
    }
    
}
