//
//  ProfileViewController.swift
//  twitter_alamofire_demo
//
//  Created by Kelvin Lui on 3/15/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit
import AlamofireImage

class ProfileViewController: UIViewController {
    
    var user: User?

    @IBOutlet weak var userIconImageView: UIImageView!
    @IBOutlet weak var tweetNumberLabel: UILabel!
    @IBOutlet weak var followingNumberLabel: UILabel!
    @IBOutlet weak var followerNumberLabel: UILabel!
    
    var numOfTweets: String?
    var numOfFollowing: String?
    var numOfFollowers: String?
    var userIconUrlString: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        user = User.current!

        // Do any additional setup after loading the view.
        userIconUrlString = user?.profileImageUrlString
        if let url = URL(string: userIconUrlString!) {
            userIconImageView.af_setImage(withURL: url)
        }
        
        numOfTweets = user?.numOfTweets
        numOfFollowers = user?.numOfFollowers
        numOfFollowing = user?.numOfFollowing
        
        followerNumberLabel.text = "\(numOfFollowers ?? String(2)) followers"
        followingNumberLabel.text = "\(numOfFollowing ?? String(5)) followings"
        tweetNumberLabel.text = "\(numOfTweets ?? String(3)) tweets"
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
