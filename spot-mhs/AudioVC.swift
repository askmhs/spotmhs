//
//  AudioVC.swift
//  spot-mhs
//
//  Created by M Harits S on 12/25/16.
//  Copyright © 2016 M Harits S. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

class AudioVC: UIViewController {
    
    @IBOutlet var backgroundImage: UIImageView!
    @IBOutlet var mainImageView: UIImageView!
    @IBOutlet var songTitle: UILabel!
    @IBOutlet var playOrPause: UIButton!
    
    var image = UIImage()
    var mainSongTitle = String()
    var mainPreviewURL = String()
    
    override func viewDidLoad() {
        songTitle.text = mainSongTitle
        backgroundImage.image = image
        mainImageView.image = image
        
        downloadFileFromURL(url: URL(string: mainPreviewURL)!)
        
        playOrPause.setTitle("Pause", for: .normal)
    }
    
    func downloadFileFromURL(url: URL) {
        var downloadTask = URLSessionDownloadTask()
        downloadTask = URLSession.shared.downloadTask(with: url, completionHandler: {
            customURL, response, error in
            
            self.playSong(url: customURL!)
        })
        
        downloadTask.resume()
    }
    
    func playSong(url: URL) {
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player.prepareToPlay()
            player.play()
        } catch {
            print(error)
        }
    }
    
    @IBAction func playPause(_ sender: Any) {
        if player.isPlaying {
            player.pause()
            playOrPause.setTitle("Play", for: .normal)
        } else {
            player.play()
            playOrPause.setTitle("Pause", for: .normal)
        }
    }
}
