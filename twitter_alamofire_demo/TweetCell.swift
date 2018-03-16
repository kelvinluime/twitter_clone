//
//  TweetCell.swift
//  twitter_alamofire_demo
//
//  Created by Charles Hieger on 6/18/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import AlamofireImage
import UIKit
import TTTAttributedLabel

class TweetCell: UITableViewCell {
    
    @IBOutlet weak var tweetTextLabel: TTTAttributedLabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var useridLabel: UILabel!
    @IBOutlet weak var postTimeLabel: UILabel!
    @IBOutlet weak var userProfileImageView: UIImageView!
    @IBOutlet weak var favouriteCountLabel: UILabel!
    @IBOutlet weak var retweetCountLabel: UILabel!
    @IBOutlet weak var favouriteButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    
    var tweet: Tweet! {
        didSet {
            refreshData()
        }
    }
    
    @IBAction func didTapFavorite(_ sender: UIButton) {
        if(tweet.favorited!) {
            tweet.favorited = false
            tweet.favoriteCount! -= 1
            APIManager.shared.unfavorite(tweet) { (tweet: Tweet?, error: Error?) in
                if let error = error {
                    print("Error unfavoriting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully favorited the following Tweet: \n\(tweet.text)")
                }
            }
        } else {
            tweet.favorited = true
            tweet.favoriteCount! += 1
            APIManager.shared.favorite(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error favoriting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully favorited the following Tweet: \n\(tweet.text)")
                }
            }
        }
        
        refreshData()
    }
    
    @IBAction func didTapRetweet(_ sender: UIButton) {
        if(tweet.retweeted) {
            tweet.retweeted = false
            tweet.retweetCount -= 1
            APIManager.shared.unRetweet(tweet) { (tweet: Tweet?, error: Error?) in
                if let error = error {
                    print("Error un-retweeting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully retweeted the following Tweet: \n\(tweet.text)")
                }
            }
        } else {
            tweet.retweeted = true
            tweet.retweetCount += 1
            APIManager.shared.retweet(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error retweeting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully retweeted the following Tweet: \n\(tweet.text)")
                }
            }
        }
        
        refreshData()
    }
    
    func refreshData() {
        retweetButton.setImage(tweet.retweeted ? #imageLiteral(resourceName: "retweet-icon-green") : #imageLiteral(resourceName: "retweet-icon"), for: UIControlState.normal)
        favouriteButton.setImage(tweet.favorited! ? #imageLiteral(resourceName: "favor-icon-red.png") : #imageLiteral(resourceName: "favor-icon.png"), for: UIControlState.normal)
        tweetTextLabel.text = tweet.text
        usernameLabel.text = tweet.user.name!
        useridLabel.text = "@" + tweet.user.screenName!
        postTimeLabel.text = tweet.createdAtStringWithoutTime
        favouriteCountLabel.text = String(tweet.favoriteCount ?? 0)
        retweetCountLabel.text = String(tweet.retweetCount)
        
        let userProfileImageUrl = URL(string: tweet.user.profileImageUrlString!)
        if let url = userProfileImageUrl {
            userProfileImageView.af_setImage(withURL: url)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
