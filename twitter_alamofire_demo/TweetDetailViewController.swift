//
//  TweetDetailViewController.swift
//  twitter_alamofire_demo
//
//  Created by Kelvin Lui on 3/7/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit
import AlamofireImage
import TTTAttributedLabel

class TweetDetailViewController: UIViewController {
    
    var tweet: Tweet!
    
    @IBOutlet weak var userProfileImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var useridLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var replyButton: UIButton!
    
    func refreshData() {
        retweetButton.setImage(tweet.retweeted ? #imageLiteral(resourceName: "retweet-icon-green") : #imageLiteral(resourceName: "retweet-icon"), for: UIControlState.normal)
        favoriteButton.setImage(tweet.favorited! ? #imageLiteral(resourceName: "favor-icon-red.png") : #imageLiteral(resourceName: "favor-icon.png"), for: UIControlState.normal)
        tweetTextLabel.text = tweet.text
        usernameLabel.text = tweet.user.name!
        useridLabel.text = "@" + tweet.user.screenName!
        
        let userProfileImageUrl = URL(string: tweet.user.profileImageUrlString!)
        if let url = userProfileImageUrl {
            userProfileImageView.af_setImage(withURL: url)
        }
    }
    
    @IBAction func onReply(_ sender: UIButton) {
        performSegue(withIdentifier: "pushEditViewController", sender: nil)
    }
    
    @IBAction func onRetweet(_ sender: UIButton) {
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
    
    @IBAction func onFavorite(_ sender: UIButton) {
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
