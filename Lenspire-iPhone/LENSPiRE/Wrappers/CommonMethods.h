//
//  CommonMethods.h
//  Lenspire
//
//  Created by Thulasi on 17/08/15.
//  Copyright (c) 2015 Nesh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CommonMethods : NSObject
+ (NSString *) data2UTF8String:(NSData *) data;
+ (UIImage *) squareImageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize;
+ (UIImage *) getThumbnail:(UIImage *)image andSize:(CGSize)toSize;
+ (NSString *)urlEncodeUsingEncoding:(NSStringEncoding)encoding string:(NSString *)kStr;
@end
