//
//  ComposeViewController.swift
//  twitter_alamofire_demo
//
//  Created by Kelvin Lui on 3/15/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit

protocol ComposeViewControllerDelegate {
    func did(post: Tweet)
}

class ComposeViewController: UIViewController, UITextViewDelegate {
    
    var delegate: ComposeViewControllerDelegate?
    
    @IBOutlet weak var textField: UITextView!
    @IBOutlet weak var wordCountLabel: UILabel!
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        // Set the max character limit
        let characterLimit = 140
        
        // Construct what the new text would be if we allowed the user's latest edit
        let newText = NSString(string: textView.text!).replacingCharacters(in: range, with: text)
        
        // TODO: Update Character Count Label
        wordCountLabel.text = "\(140 - newText.count) words left"
        
        // The new text should be allowed? True/False
        return newText.count < characterLimit
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        textField.delegate = self
        textField.layer.borderWidth = 1
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didTapPost(_ sender: UIButton) {
        APIManager.shared.composeTweet(with: "This is my tweet 😀") { (tweet, error) in
            if let error = error {
                print("Error composing Tweet: \(error.localizedDescription)")
            } else if let tweet = tweet {
                self.delegate?.did(post: tweet)
                print("Compose Tweet Success!")
            }
        }
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
