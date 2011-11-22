//
//  GCDatabase.h
//  PudgyPenguin
//
//  Created by Brandon Moore on 11/7/11.
//  Copyright (c) 2011 Vaux, Inc. All rights reserved.
//  Used to save and retrieve high scores when internet connection not available

#import <Foundation/Foundation.h>

id loadData(NSString * filename);
void saveData(id theData, NSString *filename);