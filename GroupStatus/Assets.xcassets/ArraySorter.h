//
//  ArraySorter.h
//  GroupStatus
//
//  Created by Fernando Arturo Perez on 8/2/20.
//  Copyright © 2020 Fernando Arturo Perez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Event.h"

NS_ASSUME_NONNULL_BEGIN

@interface ArraySorter : NSObject
-(NSArray *) timeMergeSort:(NSArray<Event *>*) array;
@end

NS_ASSUME_NONNULL_END
