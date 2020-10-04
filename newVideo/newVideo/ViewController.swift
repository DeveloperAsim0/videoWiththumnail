//
//  ViewController.swift
//  newVideo
//
//  Created by Mihir Vyas on 26/09/20.
//  Copyright © 2020 Mihir vyas. All rights reserved.
//

import UIKit
import AVKit

class ViewController: UIViewController {

    
    @IBOutlet weak var table: UITableView!
    
    var tableDataSource = [Video]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        let video1 = Video()
        video1.title = "Big Buck Bunny movie trailer"
        video1.url = "http://jplayer.org/video/m4v/Big_Buck_Bunny_Trailer.m4v"
        tableDataSource.append(video1)
        
        let video2 = Video()
        video2.title = "Kid Tobogganing"
        video2.url = "http://www.ebookfrenzy.com/ios_book/movie/movie.mov"
        tableDataSource.append(video2)
        
        let video3 = Video()
        video3.title = "Cat vs Snake"
        video3.url = "http://theapplady.net/wp-content/uploads/2014/12/Cat-VS-Snake-Video-Clip-funny-and-amazing-videos-Joy-4all.mp4"
        tableDataSource.append(video3)
        
        let video4 = Video()
        video4.title = "If I Were A Boy music video"
        video4.url = "http://theapplady.net/wp-content/uploads/2014/12/Beyonce-If-I-Were-A-Boy.mp4"
        tableDataSource.append(video4)
        
        let video5 =  Video()
        video5.title = "Beyonce Halo music video"
        video5.url = "http://theapplady.net/wp-content/uploads/2014/12/Beyonce-halo.mp4"
        tableDataSource.append(video5)
        
        let video6 =  Video()
        video6.title = "Crazy"
        video6.url = "http://theapplady.net/wp-content/uploads/2014/12/Gnarls-Barkley-Crazy.mp4"
        tableDataSource.append(video6)
    
    }


}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableDataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "cell") as! TableViewCell
        let video: Video = tableDataSource[indexPath.row]
        let url = NSURL(string: video.url)!
        AVAsset(url: url as URL).generateThumbnail { [weak self] (image) in
        DispatchQueue.main.async {
        guard let image = image else { return }
        cell.img.image = image
                       }
                   }
        cell.title.text = video.title
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 306
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "video" {
            if let indexPath = self.table.indexPathForSelectedRow {
                let video = tableDataSource[indexPath.row]
                let destination = segue.destination as! AVPlayerViewController
                let url = NSURL(string: video.url)!
                destination.player = AVPlayer(url: url as URL)
                destination.player?.play()
            }
        }
    }

}

extension AVAsset {

    func generateThumbnail(completion: @escaping (UIImage?) -> Void) {
        DispatchQueue.global().async {
            let imageGenerator = AVAssetImageGenerator(asset: self)
            let time = CMTime(seconds: 8.0, preferredTimescale: 600)
            let times = [NSValue(time: time)]
            imageGenerator.generateCGImagesAsynchronously(forTimes: times, completionHandler: { _, image, _, _, _ in
                if let image = image {
                    completion(UIImage(cgImage: image))
                } else {
                    completion(nil)
                }
            })
        }
    }
}

