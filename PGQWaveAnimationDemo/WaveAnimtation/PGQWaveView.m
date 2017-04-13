//
//  PGQWaveView.m
//  PGQWaveAnimationDemo
//
//  Created by Lois_pan on 17/4/12.
//  Copyright © 2017年 Lois_pan. All rights reserved.
//

#import "PGQWaveView.h"
#define kScrrenWidth self.frame.size.width
@interface PGQWaveView()
//定时器
@property (nonatomic, strong) CADisplayLink *timer;

@end


@implementation PGQWaveView {
    CGFloat _waterLineY;//线的起始位置
    CGFloat _waveCycle; //波浪线的弧度
    CGFloat _offsetX;    //正弦函数中变量   切换速度
}

- (instancetype)init {

    if (self = [super init]) {
        [self initData];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)initData {
    self.waveSpeed = 0.2;
    _offsetX = self.waveSpeed;
    _waveCycle = 100;
    self.waveHeight = 5;
    _waterLineY=120.0;

    [self startWaveAnimation];
}

- (void)startWaveAnimation{
    self.timer = [CADisplayLink displayLinkWithTarget:self selector:@selector(wave)];
    [self.timer addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)stopWaveAnimation{
    
    [self.timer invalidate];
    self.timer = nil;
}

- (void)wave {
    _offsetX += self.waveSpeed;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    UIColor * blue = [UIColor colorWithRed:0 green:0 blue:1 alpha:0.3];
    UIColor * redCOlor = [UIColor redColor];
    UIColor * yellow = [UIColor yellowColor];

    [self drawLineWithIndex:1 andColor:blue];
    [self drawLineWithIndex:2 andColor:redCOlor];
    [self drawLineWithIndex:3 andColor:yellow];
}

- (void)drawLineWithIndex:(NSInteger)index andColor:(UIColor *)color{
    float frontY;

    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGContextSetLineWidth(currentContext, 1);
    CGContextSetStrokeColorWithColor(currentContext, color.CGColor);
    CGPathMoveToPoint(path, NULL, 0, _waterLineY);
    for (float x = 0.f; x <= kScrrenWidth ; x++) {
        //前波浪绘制
        if (index == 1) {
            frontY =  self.waveHeight*sin( x/_waveCycle * M_PI  - _offsetX * M_PI/10) + _waterLineY;

        } else if (index == 2) {
            frontY = self.waveHeight*sin( x/_waveCycle * M_PI  + _offsetX * M_PI/10) + _waterLineY;
            CGPathAddLineToPoint(path, nil, x, frontY);
        } else {
            frontY = self.waveHeight*cos(x/_waveCycle * M_PI  - _offsetX * M_PI/10) + _waterLineY;
            CGPathAddLineToPoint(path, nil, x, frontY);
        }
        CGPathAddLineToPoint(path, nil, x, frontY);
    }
    CGContextAddPath(currentContext, path);
    CGContextDrawPath(currentContext, kCGPathStroke);
    CGPathRelease(path);
}

- (void)draw1 {
    float frontY;
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    CGContextBeginPath(currentContext);
    CGContextMoveToPoint(currentContext, 0, 100);
    for (float x = 0.f; x <= kScrrenWidth ; x++) {
        //前波浪绘制
        frontY =  5*sin( x/100 * M_PI  - _offsetX * M_PI/3) + 100;
        CGContextAddLineToPoint(currentContext, x, frontY);
    }
    [[UIColor blackColor] setStroke];
    CGContextStrokePath(currentContext);
}

@end
