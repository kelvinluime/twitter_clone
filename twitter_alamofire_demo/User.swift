//
//  User.swift
//  twitter_alamofire_demo
//
//  Created by Charles Hieger on 6/17/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import Foundation

enum UserKey: String {
    case name = "name"
    case friendsCount = "friends_count"
    case screenName = "screen_name"
    case followersCount = "followers_count"
    case tweetCount = "tweet_count"
    case favoriteCount = "favorite_count"
    case favorited = "favorited"
    case retweeted = "retweeted"
    case profileImageUrlHttps = "profile_image_url_https"
}

class User {
    
    var name: String?
    var dictionary: [String: Any]?
    var screenName: String?
    var profileImageUrlString: String?
    var numOfTweets: String?
    var numOfFollowing: String?
    var numOfFollowers: String?
    private static var _current: User?
    
    static var current: User? {
        get {
            if _current == nil {
                let defaults = UserDefaults.standard
                if let userData = defaults.data(forKey: "currentUserData") {
                    let dictionary = try! JSONSerialization.jsonObject(with: userData, options: []) as! [String: Any]
                    _current = User(dictionary: dictionary)
                }
            }
            return _current
        }
        set (user) {
            _current = user
            let defaults = UserDefaults.standard
            if let user = user {
                let data = try! JSONSerialization.data(withJSONObject: user.dictionary!, options: [])
                defaults.set(data, forKey: "currentUserData")
            } else {
                defaults.removeObject(forKey: "currentUserData")
            }
        }
    }
    
    init(dictionary: [String: Any]) {
        name = dictionary[UserKey.name.rawValue] as? String
        screenName = dictionary[UserKey.screenName.rawValue] as? String
        profileImageUrlString = dictionary[UserKey.profileImageUrlHttps.rawValue] as? String
        numOfFollowers = dictionary[UserKey.followersCount.rawValue] as? String
        numOfTweets = dictionary[UserKey.tweetCount.rawValue] as? String
        numOfFollowing = dictionary[UserKey.friendsCount.rawValue] as? String
        self.dictionary = dictionary
    }
}
