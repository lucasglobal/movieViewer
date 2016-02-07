//
//  MoreInfoViewController.swift
//  MovieViewer
//
//  Created by Lucas Andrade on 1/31/16.
//  Copyright © 2016 LucasRibeiro. All rights reserved.
//

import UIKit

class MoreInfoViewController: UIViewController {
    @IBOutlet weak var imageBanner: UIImageView!

    @IBOutlet weak var labelName: UILabel!
    
    var movie: NSDictionary!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(movie)
        let posterPath = movie["poster_path"] as! String
        let baseURL = "http://image.tmdb.org/t/p/w500"
        let imageURL = NSURL(string: baseURL + posterPath)
        
        
        self.labelName.text = movie["title"] as? String
        self.imageBanner.setImageWithURL(imageURL!)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation

    
}
