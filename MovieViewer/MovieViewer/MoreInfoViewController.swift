//
//  MoreInfoViewController.swift
//  MovieViewer
//
//  Created by Lucas Andrade on 1/31/16.
//  Copyright © 2016 LucasRibeiro. All rights reserved.
//

import UIKit
import MBProgressHUD
import youtube_parser
import MediaPlayer


class MoreInfoViewController: UIViewController,UIScrollViewDelegate {
    @IBOutlet weak var imageBanner: UIImageView!

    @IBOutlet weak var labelScrollToSidesToSeeMore: UILabel!
    @IBOutlet weak var labelTrailer: UILabel!
    @IBOutlet weak var buttonPlay: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelOverviewStatic: UILabel!
    @IBOutlet weak var labelOriginalLanguage: UILabel!
    @IBOutlet weak var labelOverview: UITextView!
    @IBOutlet weak var labelDate: UILabel!
    @IBOutlet weak var labelOriginalLanguageStatic: UILabel!
    @IBOutlet weak var labelPopularityStatic: UILabel!
    @IBOutlet weak var labelPopularity: UILabel!
    @IBOutlet weak var labelMovieForAdultsStatic: UILabel!
    @IBOutlet weak var labelVoteAverageStatic: UILabel!
    @IBOutlet weak var labelVoteAverage: UILabel!
    @IBOutlet weak var labelVoteCountStatic: UILabel!
    @IBOutlet weak var labelVoteCount: UILabel!
    
    @IBOutlet weak var labelMovieForAdults: UILabel!
    @IBOutlet weak var labelReleaseDateStatic: UILabel!
    @IBOutlet weak var labelInformationsStatic: UILabel!
    var movie: NSDictionary!
    var movieTrailerKey: String!
    
    
    let moviePlayer = MPMoviePlayerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Display HUD right before the request is made
        MBProgressHUD.showHUDAddedTo(self.view, animated: true)

        self.getMovieTrailer()
        
        

        
        
        //navigationBar Settings
        let bar:UINavigationBar! =  self.navigationController?.navigationBar
        bar.tintColor = UIColor.yellowColor()

        
        //set up labels and pictures data
        let posterPath = movie["poster_path"] as! String
        let baseURL = "http://image.tmdb.org/t/p/w500"
        let imageURL = NSURL(string: baseURL + posterPath)
        self.labelName.text = movie["title"] as? String
        self.imageBanner.setImageWithURL(imageURL!)
        
        self.labelOverview.text = movie["overview"] as? String
        self.labelOverview.sizeToFit()
        
        self.labelDate.text = movie["release_date"] as? String
        self.labelOriginalLanguage.text = movie["original_language"] as? String
        self.labelPopularity.text = String(movie["popularity"] as! Int)
    
        let adults = movie["adult"] as! Int
        switch (adults){
        case 1:
            self.labelMovieForAdults.text = "Yes"
            break;
        default:
            self.labelMovieForAdults.text = "No"
        }
        
        self.labelVoteAverage.text = String(movie["vote_average"] as! Int)
        self.labelVoteCount.text = String(movie["vote_count"] as! Int)
        

        
        
        
        //scrollViewSettings
        self.scrollView.frame = CGRectMake(self.scrollView.frame.origin.x, self.scrollView.frame.origin.y, self.view.frame.width, self.view.frame.height)
        self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.width * 4, 1)
        self.scrollView.delegate = self
        self.scrollView.pagingEnabled = true
        
        
        
        
        
        
        //when needed to put in other pages of ScrollView
        let scrollViewWidth:CGFloat = self.scrollView.frame.width

        self.buttonPlay.transform = CGAffineTransformMakeTranslation(scrollViewWidth*1, 0)
        self.labelTrailer.transform = CGAffineTransformMakeTranslation(scrollViewWidth*1, 0)
        
        
        //putting labels in correct pages of scrollView
        self.labelOverview.transform = CGAffineTransformMakeTranslation(scrollViewWidth*2, 0)
        self.labelOverviewStatic.transform =  CGAffineTransformMakeTranslation(scrollViewWidth*2, 0)
        
//        self.labelOverview.sizeToFit()
//        self.labelOverview.numberOfLines = 30
//        self.labelOverview.lineBreakMode = NSLineBreakMode.ByWordWrapping
//        self.labelOverview.text = self.labelOverview.text!
//        print(self.labelOverview.numberOfLines)
//        print(self.labelOverview.text!)
//        print(self.labelOverview.bounds)
//        self.labelOverview.textRectForBounds(self.labelOverview.bounds, limitedToNumberOfLines: 50)


        
        self.labelInformationsStatic.transform = CGAffineTransformMakeTranslation(scrollViewWidth*3, 0)
        self.labelReleaseDateStatic.transform = CGAffineTransformMakeTranslation(scrollViewWidth*3, 0)
        self.labelDate.transform = CGAffineTransformMakeTranslation(scrollViewWidth*3, 0)
        self.labelOriginalLanguageStatic.transform = CGAffineTransformMakeTranslation(scrollViewWidth*3, 0)
        self.labelOriginalLanguage.transform = CGAffineTransformMakeTranslation(scrollViewWidth*3, 0)
        self.labelPopularityStatic.transform = CGAffineTransformMakeTranslation(scrollViewWidth*3, 0)
        self.labelPopularity.transform = CGAffineTransformMakeTranslation(scrollViewWidth*3, 0)
        self.labelMovieForAdultsStatic.transform = CGAffineTransformMakeTranslation(scrollViewWidth*3, 0)
        self.labelMovieForAdults.transform = CGAffineTransformMakeTranslation(scrollViewWidth*3, 0)
        self.labelVoteAverageStatic.transform = CGAffineTransformMakeTranslation(scrollViewWidth*3, 0)
        self.labelVoteAverage.transform = CGAffineTransformMakeTranslation(scrollViewWidth*3, 0)
        self.labelVoteCountStatic.transform = CGAffineTransformMakeTranslation(scrollViewWidth*3, 0)
        self.labelVoteCount.transform = CGAffineTransformMakeTranslation(scrollViewWidth*3, 0)
        

        
        
                // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidAppear(animated: Bool) {
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            self.scrollView.contentOffset.x += self.scrollView.frame.size.width
            
        })
        

    }

    func getMovieTrailer(){
        let apiKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
        let url = NSURL(string: "https://api.themoviedb.org/3/movie/\(self.movie["id"]!)/videos?api_key=\(apiKey)")
        let request = NSURLRequest(
            URL: url!,
            cachePolicy: NSURLRequestCachePolicy.ReloadIgnoringLocalCacheData,
            timeoutInterval: 10)
        
        let session = NSURLSession(
            configuration: NSURLSessionConfiguration.defaultSessionConfiguration(),
            delegate: nil,
            delegateQueue: NSOperationQueue.mainQueue()
        )
        
        let task: NSURLSessionDataTask = session.dataTaskWithRequest(request,
            completionHandler: { (dataOrNil, response, error) in
                if let data = dataOrNil {
                    if let responseDictionary = try! NSJSONSerialization.JSONObjectWithData(
                        data, options:[]) as? NSDictionary {
                            // Hide HUD once the network request comes back (must be done on main UI thread)
                            MBProgressHUD.hideHUDForView(self.view, animated: true)
                            
                            self.movieTrailerKey = String((responseDictionary["results"]![0]!["key"]!)!)
                            
                    }
                }
                else{
                    // Hide HUD once the network request comes back (must be done on main UI thread)
                    MBProgressHUD.hideHUDForView(self.view, animated: true)

                    print(error)
                }
        })
        task.resume()

    }
    
    func playVideoWithYoutubeURL(url: NSURL) {
        Youtube.h264videosWithYoutubeURL(url, completion: { (videoInfo, error) -> Void in
            if let videoURLString = videoInfo?["url"] as? String {
                    self.moviePlayer.contentURL = NSURL(string: videoURLString)
            }
        })
    }

    @IBAction func actionPlayButton(sender: AnyObject) {
    //when needed to put in other pages of ScrollView
    let scrollViewWidth:CGFloat = self.scrollView.frame.width
        

    self.moviePlayer.view.frame = CGRectMake(scrollViewWidth*1 + self.moviePlayer.view.frame.origin.x, self.labelScrollToSidesToSeeMore.frame.origin.y - 130, self.view.frame.size.width, self.imageBanner.frame.size.height)
    self.scrollView.addSubview(self.moviePlayer.view)
    self.moviePlayer.fullscreen = false
    let youtubeURL = NSURL(string: "https://www.youtube.com/watch?v=\(self.movieTrailerKey)")
    self.playVideoWithYoutubeURL(youtubeURL!)

    }
    override func viewDidDisappear(animated: Bool) {
        //stopping video if playing
        self.moviePlayer.contentURL = nil
    }
}
