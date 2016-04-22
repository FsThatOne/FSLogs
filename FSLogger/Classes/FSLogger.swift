//
//  FSLogger.swift
//  FSLogger
//
//  Created by 王正一 on 16/4/12.
//  Copyright © 2016年 王正一. All rights reserved.
//

import UIKit

public typealias FSColor = UIColor

public enum outputLevel {
    case All
    case Info
    case Warnning
    case Error
}

///Debug logLevel - All
private let kLogAll : String = "All"

///Debug logLevel - Info
private let kLogInfo : String = "Info"

///Debug logLevel - Warning
private let kLogWarn : String = "Warning"

///Debug logLevel - Error
private let kLogError : String = "Error"

public struct FSLog {
    
    #if DEBUG
    public static var enable : Bool = true
    #else
    public static var enable : Bool = false
    #endif
    
    /// 输出等级 1 - 4 分别为all, info, warning, error, 默认为ALL
    public static var logLevelShown : outputLevel = .All
    
    public static var colorForLogLevels : [FSColor] = [
        FSColor(r: 120, g: 120, b: 120),        //灰色
        FSColor(r: 255, g: 255, b: 255),        //白色
        FSColor(r: 240, g: 240, b: 80),         //黄色
        FSColor(r: 255, g: 0, b: 0)               //红色
    ]
    
    private static func shouldPrint(fileName file: String, level: outputLevel) -> Bool {
        if !FSLog.enable {
            return false
        } else if level.hashValue < FSLog.logLevelShown.hashValue {
            return false
        } else {
            // 符合等级要求,可以打印
            return true
        }
    }
}

// MARK: - log日志输出到沙盒文档
public func saveOutputLogInfos(stringToSave string: String?){
    //时间戳
    let dateFormat = NSDateFormatter()
    dateFormat.locale = NSLocale(localeIdentifier: "zh_CN")
    dateFormat.dateFormat = "yyyy-MM-dd"
    let dateStr = dateFormat.stringFromDate(NSDate())
    
    //获取文件路径
    let paths = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
    var logDirectory = paths.first
    logDirectory!.appendContentsOf("/Log")
    //判断文件夹是否存在
    let isDirExist = NSFileManager.defaultManager().fileExistsAtPath(logDirectory!)
    //如果存在则直接写入,否则去创建
    if isDirExist != true {
        do {
            //创建log文件
            try NSFileManager.defaultManager().createDirectoryAtPath(logDirectory!, withIntermediateDirectories: true, attributes: nil)
        } catch {
            return
        }
    }
    //获取文件夹路径
    let logFilePath = logDirectory!.stringByAppendingString("/\(dateStr).log")
    let isFileExist = NSFileManager.defaultManager().fileExistsAtPath(logFilePath)
    if isFileExist != true {
        do {
            //文件内容以时间戳作为开头
            let dateStringForStart = dateStr + "\n"
            //创建文件并向文件内写入时间戳开头
            try dateStringForStart.writeToFile(logFilePath, atomically: false, encoding: NSUTF8StringEncoding)
        } catch {
            return
        }
    }
    let fileHandle = NSFileHandle(forWritingAtPath: logFilePath)
    if fileHandle == nil {
        return
    }
    fileHandle?.seekToEndOfFile()
    let writeData: NSData? = string?.dataUsingEncoding(NSUTF8StringEncoding)
    if writeData == nil {
        return
    }
    fileHandle?.writeData(writeData!)
    fileHandle?.closeFile()
    // TODO: - log文件每周清理一次
    
}

// MARK: - log输出有关
private func FSLogManager<T>(obj: T, file: String, function: String, line: Int, level: outputLevel){
    
    let fileName = file.NS.lastPathComponent.NS.stringByDeletingPathExtension
    
    if FSLog.shouldPrint(fileName: fileName, level: level) {
        let infoPart : String = "\(fileName).\(function)[\(line)]"
        printLog(infoPart, objText: obj ,level: level)
    }
}

private func printLog<T>(informationPart: String, objText: T, level: outputLevel){
    print("\(colorLogs.colorTheLog(informationPart, colorLevel: outputLevel.Info))", terminator: "")
    saveOutputLogInfos(stringToSave: "\(informationPart)")
    print("\(colorLogs.colorTheLog(objText, colorLevel: level))\n", terminator: "")
    saveOutputLogInfos(stringToSave: "\(objText)\n")
}

private struct colorLogs{
    private static let Escape = "\u{001b}["
    private static let Reset = Escape + ";"
    
    static func colorTheLog<T>(obj: T, colorLevel: outputLevel) -> String {
        return "\(Escape)fg\(FSLog.colorForLogLevels[colorLevel.hashValue].r),\(FSLog.colorForLogLevels[colorLevel.hashValue].g),\(FSLog.colorForLogLevels[colorLevel.hashValue].b);\(obj)\(Reset)"
    }
}

// All - output : 灰色
public func FS1<T>(all: T, _ file: String = #file, _ function: String = #function, _ line: Int = #line){
    FSLogManager(all, file: file, function: function, line: line, level: .All)
}

// Info - output : 白色
public func FS2<T>(info: T, _ file: String = #file, _ function: String = #function, _ line: Int = #line){
    FSLogManager(info, file: file, function: function, line: line, level: .Info)
}

// Warnning - output : 灰色
public func FS3<T>(warn: T, _ file: String = #file, _ function: String = #function, _ line: Int = #line){
    FSLogManager(warn, file: file, function: function, line: line, level: .Warnning)
}

// Error - output : 灰色
public func FS4<T>(error: T, _ file: String = #file, _ function: String = #function, _ line: Int = #line){
    FSLogManager(error, file: file, function: function, line: line, level: .Error)
}

// extension String
private extension String {
    var NS : NSString {
        return self as NSString
    }
}

//extension FSColor
private extension FSColor {
    convenience init(r:CGFloat, g:CGFloat, b:CGFloat) {
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: 1.0)
    }
    
    var r : Int {
        var red : CGFloat = 0
        getRed(&red, green: nil, blue: nil, alpha: nil)
        return Int(red * 255)
    }
    
    var g : Int {
        var green : CGFloat = 0
        getRed(nil, green: &green, blue: nil, alpha: nil)
        return Int(green * 255)
    }
    
    var b : Int {
        var blue : CGFloat = 0
        getRed(nil, green: nil, blue: &blue, alpha: nil)
        return Int(blue * 255)
    }
}