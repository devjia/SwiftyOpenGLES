//
//  Common.swift
//  SwiftyOpenGLES
//
//  Created by devjia on 2022/2/21.
//

import Foundation
import OpenGLES

public class Common {
    #if DEBUG
    static let DEBUG = true
    #else
    static let DEBUG = false
    #endif
    
    enum LogLevel: Int, Comparable {
        case debug
        case info
        case warning
        case error
        
        static func < (lhs: Common.LogLevel, rhs: Common.LogLevel) -> Bool {
            return lhs.rawValue < rhs.rawValue
        }
    }
    
    static func log(tag: String = "Common", level: LogLevel = .debug, msg: String) {
        let filterLevel: LogLevel = DEBUG ? .debug : .warning
        if level >= filterLevel {
            print("[\(tag)]: \(msg)")
        }
    }
    
    public static func checkGLError(tag: String = "") {
        let error = glGetError()
        if error != GLenum(GL_NO_ERROR) {
            let msg: String
            switch error {
            case GLenum(GL_INVALID_ENUM):
                msg = "invalid enum"
            case GLenum(GL_INVALID_FRAMEBUFFER_OPERATION):
                msg = "invalid framebuffer operation"
            case GLenum(GL_INVALID_OPERATION):
                msg = "invalid operation"
            case GLenum(GL_INVALID_VALUE):
                msg = "invalid value"
            case GLenum(GL_OUT_OF_MEMORY):
                msg = "out of memory"
            default:
                msg = "unknown error"
            }
            log(level: .error, msg: msg)
        }
     }
}
