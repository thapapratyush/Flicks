//
//  DetailViewController.swift
//  iFindMovies
//
//  Created by Pratyush Thapa on 2/13/17.
//  Copyright © 2017 Pratyush. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var TitleLabel: UILabel!
    @IBOutlet weak var OverviewLabel: UILabel!
    @IBOutlet weak var PosterView: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var documentView: UIView!
    
    var movie: NSDictionary!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.contentSize = CGSize(width: scrollView.frame.size.width, height: documentView.frame.origin.y + documentView.frame.size.height)
        let title = movie["title"] as? String
        self.title = title
        TitleLabel.text = title
        let overview = movie["overview"] as? String
        OverviewLabel.text = overview
        OverviewLabel.sizeToFit()
        let smallImagePath = "https://image.tmdb.org/t/p/w45"
        let largeImagePath = "https://image.tmdb.org/t/p/w500/"
        if let posterPath = movie["poster_path"] as? String{
            let smallImageUrl = NSURL(string: smallImagePath + posterPath)
            let largeImageUrl = NSURL(string: largeImagePath + posterPath)
            let smallImageRequest = NSURLRequest(url: smallImageUrl! as URL)
            let largeImageRequest = NSURLRequest(url: largeImageUrl! as URL)
            self.PosterView.setImageWith(
                smallImageRequest as URLRequest,
                placeholderImage: nil,
                success: { (smallImageRequest, smallImageResponse, smallImage) -> Void in
                    self.PosterView.alpha = 0.0
                    self.PosterView.image = smallImage;
                    UIView.animate(withDuration: 0.3, animations: { () -> Void in
                        self.PosterView.alpha = 1.0
                    }, completion: { (sucess) -> Void in
                        self.PosterView.setImageWith(
                            largeImageRequest as URLRequest,
                            placeholderImage: smallImage,
                            success: { (largeImageRequest, largeImageResponse, largeImage) -> Void in
                                self.PosterView.image = largeImage;
                        },
                            failure: { (request, response, error) -> Void in
                        })
                    })
            },
                failure: { (request, response, error) -> Void in
            })
        }

        // Do any additional setup after loading the view.
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
