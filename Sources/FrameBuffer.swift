//
//  FrameBuffer.swift
//  SwiftyOpenGLES
//
//  Created by devjia on 2022/2/20.
//

import Foundation
import OpenGLES

public final class FrameBuffer: OpenGLESObject {
    
    private var framebufferId: GLuint = 0
    
    public init() {
        glGenFramebuffers(1, &framebufferId)
    }
    
    public static func create() -> OpenGLESObject {
        return FrameBuffer()
    }
    
    public func release() {
        if framebufferId != 0 {
            glDeleteFramebuffers(1, &framebufferId)
            framebufferId = 0
        }
    }
    
    public var ID: GLuint {
        return framebufferId
    }
    
    public func bind() {
        glBindFramebuffer(GLenum(GL_FRAMEBUFFER), framebufferId)
    }
    
    public func bindTexture(_ texture: GLuint) {
        bind()
        glFramebufferTexture2D(GLenum(GL_FRAMEBUFFER), GLenum(GL_COLOR_ATTACHMENT0), GLenum(GL_TEXTURE_2D), texture, 0)
        if glCheckFramebufferStatus(GLenum(GL_FRAMEBUFFER)) != GLenum(GL_FRAMEBUFFER_COMPLETE) {
            Common.log(tag: tag, level: .error, msg: "FrameBuffer bindTexture2D - Frame buffer is not valid!")
        }
    }
}
