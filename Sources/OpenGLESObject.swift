//
//  OpenGLESObject.swift
//  SwiftyOpenGLES
//
//  Created by devjia on 2022/2/20.
//

import Foundation

public protocol OpenGLESObject {
    static func create() -> OpenGLESObject
    func release()
    var ID: GLuint { get }
    func bind()
    var isValid: Bool { get }
    var tag: String { get }
}

extension OpenGLESObject {
    public var isValid: Bool {
        return ID > 0
    }
    
    public var tag: String {
        return String(describing: self)
    }
}
