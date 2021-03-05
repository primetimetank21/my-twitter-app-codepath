//
//  TweetCellTableViewCell.swift
//  Twitter
//
//  Created by Earl Tankard, Jr. on 2/28/21.
//  Copyright © 2021 Dan. All rights reserved.
//

import UIKit

class TweetCellTableViewCell: UITableViewCell {
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var tweetContent: UILabel!
    @IBOutlet weak var favButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    
    var favorited:Bool = false
    var tweetID:Int    = -1
    
    func setFavorite(_ isFavorited: Bool) {
        favorited = isFavorited
        if (favorited) {
            favButton.setImage(UIImage(named: "favor-icon-red"),for: UIControl.State.normal)
        }
        else {
            favButton.setImage(UIImage(named: "favor-icon"),for: UIControl.State.normal)
        }
        
    }
    
    

    @IBAction func favTweet(_ sender: Any) {
        let toBeFavorited = !favorited
        if(toBeFavorited) {
            TwitterAPICaller.client?.favoriteTweet(tweetID: tweetID, success: {
                self.setFavorite(true)
            }, failure: { (error) in
                print("Favorite did not succeed: \(error)")
            })
        }
        else {
            TwitterAPICaller.client?.unfavoriteTweet(tweetID: tweetID, success: {
                self.setFavorite(false)
            }, failure: { (error) in
                print("Unfavorite did not succeed: \(error)")
            })
        }
    }
    
    @IBAction func retweet(_ sender: Any) {
        TwitterAPICaller.client?.retweet(tweetID: tweetID, success: {
            self.setRetweeted(true)
        }, failure: {(error) in
            print("Error in retweeting: \(error)")
        })
    }
    
    func setRetweeted(_ isRetweeted: Bool){
        if (isRetweeted) {
            retweetButton.setImage(UIImage(named: "retweet-icon-green"), for: UIControl.State.normal)
            retweetButton.isEnabled = false
        }
        else {
            retweetButton.setImage(UIImage(named: "retweet-icon"), for: UIControl.State.normal)
            retweetButton.isEnabled = true

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
