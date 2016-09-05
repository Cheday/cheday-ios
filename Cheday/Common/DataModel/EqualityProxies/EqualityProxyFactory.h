//
//  EqualityProxyFactory.h
//  Cheday
//
//  Created by Andrey Krukovskiy on 24.08.16.
//  Copyright © 2016 Cheday. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EqualityProxyProtocol.h"

@interface EqualityProxyFactory : NSObject

@property(nonatomic, strong) NSMutableSet *equalityProxiesForSelectedObjects;

-(id<EqualityProxyProtocol>) proxyForObject:(id)object;
-(NSArray*) proxyArrayForObjectsArray:(NSArray*)array;

@end
