//
//  FSLogger.swift
//  FSLogger
//
//  Created by 王正一 on 16/4/12.
//  Copyright © 2016年 王正一. All rights reserved.
//

import UIKit

public enum outputLevel {
    case all
    case info
    case warnning
    case error
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
    public static var enable : Bool = true
    #endif
    
    /// 输出等级 1 - 4 分别为all, info, warning, error, 默认为ALL
    public static var logLevelShown : outputLevel = .all
    
    public static var colorForLogLevels : [String] = [
        "⚪️Verbose⚪️",        //All
        "🎾  Info 🎾",        //Info
        "⚠️Warning⚠️",        //Warn
        "‼️ Error ‼️"         //Error
    ]
    
    fileprivate static func shouldPrint(fileName file: String, level: outputLevel) -> Bool {
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
    let dateFormat = DateFormatter()
    dateFormat.locale = Locale(identifier: "zh_CN")
    dateFormat.dateFormat = "yyyy-MM-dd"
    let dateStr = dateFormat.string(from: Date())
    
    //获取文件路径
    let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
    var logDirectory = paths.first
    logDirectory!.append("/Log")
    //判断文件夹是否存在
    let isDirExist = FileManager.default.fileExists(atPath: logDirectory!)
    //如果存在则直接写入,否则去创建
    if isDirExist != true {
        do {
            //创建log文件
            try FileManager.default.createDirectory(atPath: logDirectory!, withIntermediateDirectories: true, attributes: nil)
        } catch {
            return
        }
    }
    //获取文件夹路径
    let logFilePath = logDirectory! + "/\(dateStr).log"
    let isFileExist = FileManager.default.fileExists(atPath: logFilePath)
    if isFileExist != true {
        do {
            //文件内容以时间戳作为开头
            let dateStringForStart = dateStr + "\n"
            //创建文件并向文件内写入时间戳开头
            try dateStringForStart.write(toFile: logFilePath, atomically: false, encoding: String.Encoding.utf8)
        } catch {
            return
        }
    }
    let fileHandle = FileHandle(forWritingAtPath: logFilePath)
    if fileHandle == nil {
        return
    }
    fileHandle?.seekToEndOfFile()
    let writeData: Data? = string?.data(using: String.Encoding.utf8)
    if writeData == nil {
        return
    }
    fileHandle?.write(writeData!)
    fileHandle?.closeFile()
    // TODO: - log文件每周清理一次
    
}

// MARK: - log输出有关
private func FSLogManager<T>(_ obj: T, file: String, function: String, line: Int, level: outputLevel){
    
    let fileName = file.NS.lastPathComponent.NS.deletingPathExtension
    
    if FSLog.shouldPrint(fileName: fileName, level: level) {
        let infoPart : String = "\(fileName).\(function)[\(line)]"
        printLog(infoPart, objText: obj ,level: level)
    }
}

private func printLog<T>(_ informationPart: String, objText: T, level: outputLevel){
    print("\(colorLogs.colorTheLog(informationPart, colorLevel: level))", terminator: "")
    saveOutputLogInfos(stringToSave: "\(informationPart)")
    print("\(objText)\n", terminator: "")
    saveOutputLogInfos(stringToSave: "\(objText)\n")
}

private struct colorLogs{
    
    static func colorTheLog<T>(_ obj: T, colorLevel: outputLevel) -> String {
        return "<\(FSLog.colorForLogLevels[colorLevel.hashValue])>\(obj)"
    }
}

// All - output : 灰色
public func Fs<T>(_ all: T, _ file: String = #file, _ function: String = #function, _ line: Int = #line){
    FSLogManager(all, file: file, function: function, line: line, level: .all)
}

// Info - output : 白色
public func FsInfo<T>(_ info: T, _ file: String = #file, _ function: String = #function, _ line: Int = #line){
    FSLogManager(info, file: file, function: function, line: line, level: .info)
}

// Warnning - output : 灰色
public func FsWarn<T>(_ warn: T, _ file: String = #file, _ function: String = #function, _ line: Int = #line){
    FSLogManager(warn, file: file, function: function, line: line, level: .warnning)
}

// Error - output : 灰色
public func FsError<T>(_ error: T, _ file: String = #file, _ function: String = #function, _ line: Int = #line){
    FSLogManager(error, file: file, function: function, line: line, level: .error)
}

// extension String
private extension String {
    var NS : NSString {
        return self as NSString
    }
}

