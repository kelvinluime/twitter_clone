//
//  Tweet.swift
//  twitter_alamofire_demo
//
//  Created by Charles Hieger on 6/18/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import Foundation

enum TweetKey: String {
    case id = "id"  // Int64
    case text = "text"  // String
    case favorited = "favorited"    // Int
    case retweetCount = "retweet_count" // Int
    case retweeted = "retweeted"    // boolean
    case createdAt = "created_at"   // String
    case favoriteCount = "favorite_count"   // Int
    case user = "user"
}

class Tweet {
    
    // MARK: Properties
    var id: Int64 // For favoriting, retweeting & replying
    var text: String // Text content of tweet
    var favoriteCount: Int? // Update favorite count label
    var favorited: Bool? // Configure favorite button
    var retweetCount: Int // Update favorite count label
    var retweeted: Bool // Configure retweet button
    var user: User // Contains name, screenname, etc. of tweet author
    var createdAtStringWithoutTime: String // Display date
    var createdAtStringWithTime: String
    
    // MARK: - Create initializer with dictionary
    init(dictionary: [String: Any]) {
        id = dictionary[TweetKey.id.rawValue] as! Int64
        text = dictionary[TweetKey.text.rawValue] as! String
        favoriteCount = dictionary[TweetKey.favoriteCount.rawValue] as? Int
        favorited = dictionary[TweetKey.favorited.rawValue] as? Bool
        retweetCount = dictionary[TweetKey.retweetCount.rawValue] as! Int
        retweeted = dictionary[TweetKey.retweeted.rawValue] as! Bool
        
        let user = dictionary[TweetKey.user.rawValue] as! [String: Any]
        self.user = User(dictionary: user)
        
        let createdAtOriginalString = dictionary[TweetKey.createdAt.rawValue] as! String
        createdAtStringWithoutTime = Tweet.getFormattedTimeStamp(createdAtOriginalString, include: false)
        createdAtStringWithTime = Tweet.getFormattedTimeStamp(createdAtOriginalString, include: true)
    }
    
    static func getFormattedTimeStamp(_ rawTimeString: String, include time: Bool) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "E MM d HH:mm:ss Z y"
        let date = formatter.date(from: rawTimeString)!
        formatter.dateStyle = .short
        formatter.timeStyle = time ? .medium : .none
        return formatter.string(from: date)
    }
    
    static func tweets(with array: [[String: Any]]) -> [Tweet] {
        var tweets: [Tweet] = []
        for tweetDictionary in array {
            let tweet = Tweet(dictionary: tweetDictionary)
            tweets.append(tweet)
        }
        return tweets
    }
}

