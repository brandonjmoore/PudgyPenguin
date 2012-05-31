//
//  GCDatabase.m
//  PudgyPenguin
//
//  Created by Brandon Moore on 11/7/11.
//  Copyright (c) 2011 Vaux, Inc. All rights reserved.
//  Used to save and retrieve high scores when internet connection not available

#import "GCDatabase.h"

NSString * pathForFile(NSString *filename) {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:filename];
}

id loadData(NSString *filename) {
    NSString *filePath = pathForFile(filename);
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        NSData *data = [[[NSData alloc] initWithContentsOfFile:filePath]autorelease];
        
        NSKeyedUnarchiver *unarchiver = [[[NSKeyedUnarchiver alloc] initForReadingWithData:data] autorelease];
        
        id retval = [unarchiver decodeObjectForKey:@"Data"];
        [unarchiver finishDecoding];
        return retval;
    }
    return nil;
}

void saveData(id theData, NSString *filename) {
    NSMutableData *data = [[[NSMutableData alloc] init] autorelease];
    
    NSKeyedArchiver *archiver = [[[NSKeyedArchiver alloc] initForWritingWithMutableData:data] autorelease];
    
    [archiver encodeObject:theData forKey:@"Data"];
    [archiver finishEncoding];
    
    [data writeToFile:pathForFile(filename) atomically:YES];
}
