//
//  RecordedAudio.swift
//  Pitch Perfect
//
//  Created by Steven Marlowe on 4/25/15.
//  Copyright (c) 2015 Steven Marlowe. All rights reserved.
//

import Foundation

class RecordedAudio: NSObject
{
    var filePathUrl: NSURL!
    var title: String!
    

    
    init(url: NSURL, titleIn: String)
    {
       filePathUrl = url
        title = titleIn
    }
}