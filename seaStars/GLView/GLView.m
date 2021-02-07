//
//  GLView.m
//  seaStars
//
//  Created by jjy on 2021/2/5.
//

#import "GLView.h"
#import <OpenGLES/ES3/gl.h>
#import <OpenGLES/ES3/glext.h>

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"

@interface GLView (){
    
    EAGLContext * _mContext;
    GLuint _mRenderBuffer;
    GLuint _mframeBuffer;
}
@end

@implementation GLView


-(id)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
        [self setBuffer];
        [self render];
    }
    return self;
}

-(void)setup{
    
    CAEAGLLayer * layer = (CAEAGLLayer *)self.layer;
    layer.opaque = YES;
    layer.drawableProperties = @{kEAGLDrawablePropertyRetainedBacking:@(NO),
                                 kEAGLDrawablePropertyColorFormat:kEAGLColorFormatRGBA8};

    _mContext = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES3];
    if (!_mContext) {
        NSLog(@"failed to initalize opengles 3 context");
        exit(1);
    }
    
    if (![EAGLContext setCurrentContext:_mContext]) {
        NSLog(@"failed to set current contex");
        exit(1);
    }
}

-(void)setBuffer{
    
    glGenRenderbuffers(1, &_mRenderBuffer);
    glBindRenderbuffer(GL_RENDERBUFFER, _mRenderBuffer);
    
    glGenFramebuffers(1, &_mframeBuffer);
    glBindFramebuffer(GL_FRAMEBUFFER, _mframeBuffer);
    
    //将GL_RENDERBUFFER通过GL_COLOR_ATTACHMENT0装配到GL_FRAMEBUFFER上
    glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_COLOR_ATTACHMENT0, GL_RENDERBUFFER, _mRenderBuffer);
    
    CAEAGLLayer * layer = (CAEAGLLayer *)self.layer;
    [_mContext renderbufferStorage:GL_RENDERBUFFER fromDrawable:layer];
}


-(void)render{
    glClearColor(1, 0, 0, 0);
    glClear(GL_COLOR_BUFFER_BIT);
    
    
    [_mContext presentRenderbuffer:_mRenderBuffer];
}


+(Class)layerClass{
    return [CAEAGLLayer class];
}



@end
