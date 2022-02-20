//
//  Program.swift
//  SwiftyOpenGLES
//
//  Created by devjia on 2022/2/20.
//

import Foundation
import OpenGLES

public final class Program: OpenGLESObject {

    private var programID: GLuint = 0
    
    init(vsh: String, fsh: String) {
        programID = glCreateProgram()
        let vertexShader = Shader(code: vsh, type: GLenum(GL_VERTEX_SHADER))
        let fragmentShader = Shader(code: fsh, type: GLenum(GL_FRAMEBUFFER))
        glAttachShader(programID, vertexShader.ID)
        glAttachShader(programID, fragmentShader.ID)
        glLinkProgram(programID)
        
        var linkStatus:GLint = 0
        glGetProgramiv(programID, GLenum(GL_LINK_STATUS), &linkStatus)
        if (linkStatus == GL_FALSE) {
            var logLength:GLint = 0
            glGetProgramiv(programID, GLenum(GL_INFO_LOG_LENGTH), &logLength)
            if (logLength > 0) {
                var compileLog = [CChar](repeating:0, count:Int(logLength))
                glGetProgramInfoLog(programID, logLength, &logLength, &compileLog)
                Common.log(tag: tag, level: .error, msg: "Link log: \(String(cString:compileLog))")
            }
        }
    }
    
    deinit {
        release()
    }
    
    public static func create() -> OpenGLESObject {
        return Program(vsh: "", fsh: "")
    }
    
    public static func create(vsh: String, fsh: String) -> Program {
        return Program(vsh: vsh, fsh: fsh)
    }
    
    public func release() {
        if programID != 0 {
            glDeleteProgram(programID)
            programID = 0
        }
    }
    
    public var ID: GLuint {
        return programID
    }
    
    public func bind() {
        glUseProgram(programID)
    }
    
    // MARK: - uniform
    public func getUniformLocation(name: String) -> GLint? {
        let cString = (name as NSString).utf8String
        let loc = glGetUniformLocation(programID, cString)
        if loc < 0 {
            Common.log(tag: tag, level: .debug, msg: "uniform name \(name) does not exist!")
            return nil
        }
        return loc
    }
    
    public func sendUniformf(loc: GLint, value:[GLfloat]) {
        if value.count == 1 {
            glUniform1fv(loc, 1, value)
        }
        if value.count == 2 {
            glUniform2fv(loc, 2, value)
        }
        if value.count == 3 {
            glUniform3fv(loc, 3, value)
        }
        if value.count == 4 {
            glUniform4fv(loc, 4, value)
        }
    }
    
    public func sendUniformf(name: String, value:[GLfloat]) {
        if let loc = getUniformLocation(name: name) {
            sendUniformf(loc: loc, value: value)
        }
    }
    
    public func sendUniformi(loc: GLint, value:[GLint]) {
        if value.count == 1 {
            glUniform1iv(loc, 1, value)
        }
        if value.count == 2 {
            glUniform2iv(loc, 2, value)
        }
        if value.count == 3 {
            glUniform3iv(loc, 3, value)
        }
        if value.count == 4 {
            glUniform4iv(loc, 4, value)
        }
    }
    
    public func sendUniformi(name: String, value:[GLint]) {
        if let loc = getUniformLocation(name: name) {
            sendUniformi(loc: loc, value: value)
        }
    }
    
    // TODO: sendUniformMatrix
    
    // MARK: - attribute
    public func getAttributeLocation(name: String) -> GLuint? {
        let cString = (name as NSString).utf8String
        let loc = glGetAttribLocation(programID, cString)
        if loc < 0 {
            Common.log(tag: tag, level: .debug, msg: "attribute name \(name) does not exist!")
            return nil
        }
        glEnableVertexAttribArray(GLuint(loc))
        return GLuint(loc)
    }
    
    public func bindAttribLocation(name: String, index: GLuint) {
        glBindAttribLocation(programID, index, name);
    }
}

public final class Shader: OpenGLESObject {
    enum `Type` {
        case vertex
        case fragment
    }

    private var shaderID: GLuint = 0
    private var shaderType: GLenum = 0
    
    init(code: String, type: GLenum) {
        shaderID = loadShader(code: code, type: type)
        shaderType = type
    }
    
    deinit {
        release()
    }
    
    public var ID: GLuint {
        return shaderID
    }
    
    public static func create() -> OpenGLESObject {
        fatalError()
    }
    
    public func bind() {
        fatalError()
    }
    
    public func release() {
        if shaderID != 0 {
            glDeleteShader(shaderID)
            shaderID = 0
        }
    }
    
    private func loadShader(code: String, type: GLenum) -> GLuint {
        let shaderID = glCreateShader(type)
        if shaderID != 0 {
            var cString = (code as NSString).utf8String
            glShaderSource(shaderID, 1, &cString, nil)
            glCompileShader(shaderID)
            
            var compileStatus:GLint = 1
            glGetShaderiv(shaderID, GLenum(GL_COMPILE_STATUS), &compileStatus)
            if (compileStatus != GL_TRUE) {
                var logLength:GLint = 0
                glGetShaderiv(shaderID, GLenum(GL_INFO_LOG_LENGTH), &logLength)
                if (logLength > 0) {
                    var compileLog = [CChar](repeating:0, count:Int(logLength))
                    
                    glGetShaderInfoLog(shaderID, logLength, &logLength, &compileLog)
                    Common.log(tag: tag, level: .error, msg: "Compile log: \(String(cString:compileLog))")
                }
            }
        }
        return shaderID
    }
}
