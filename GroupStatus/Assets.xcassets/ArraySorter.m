//
//  ArraySorter.m
//  GroupStatus
//
//  Created by Fernando Arturo Perez on 8/2/20.
//  Copyright © 2020 Fernando Arturo Perez. All rights reserved.
//

#import "ArraySorter.h"
#import "Event.h"
@implementation ArraySorter

-(NSArray *) timeMergeSort:(NSArray<Event *>*) array
{
    
    if( [array count] <= 1)
    {
        return array;
    }
    else
    {
        int middle = (int)[array count]/2;
        NSRange rangeLeft = NSMakeRange(0, middle);
        NSRange rangeRight = NSMakeRange(middle, array.count-middle);
        NSArray <Event *>*leftArray = [array subarrayWithRange:rangeLeft];
        NSArray <Event *>*rightArray = [array subarrayWithRange:rangeRight];
        NSArray *finalArray = [self merge:[self timeMergeSort:leftArray] with:[self timeMergeSort:rightArray]];
        return finalArray;
    }
    return array;
}
-(NSArray *) merge:(NSArray<Event *>*)firstArray with:(NSArray <Event *>*)secondArray
{
    NSMutableArray <Event *>*sortedArray = [NSMutableArray new];
    int i = 0;
    int j = 0;
    
    while(i < [firstArray count] && j < [secondArray count])
    {
        NSDate *leftArrayDate = [firstArray objectAtIndex:i].time;
        NSDate *rightArrayDate = [secondArray objectAtIndex:j].time;
        
        if([leftArrayDate earlierDate:rightArrayDate]==leftArrayDate)
        {
            [sortedArray addObject:[firstArray objectAtIndex:i++]];
        }
        else
        {
            [sortedArray addObject:[secondArray objectAtIndex:j++]];
        }
        
    }
    while(i < [firstArray count])
    {
        [sortedArray addObject:[firstArray objectAtIndex:i++]];
    }
    while(j < [secondArray count])
    {
        [sortedArray addObject:[secondArray objectAtIndex:j++]];
    }
    
    return sortedArray;
}

@end
