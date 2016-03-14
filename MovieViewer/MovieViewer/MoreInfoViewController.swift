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
    @IBOutlet weak var labelOverview: UILabel!
    @IBOutlet weak var labelOverviewStatic: UILabel!
    @IBOutlet weak var labelOriginalLanguage: UILabel!
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
        
        self.buttonPlay.frame = CGRectMake(scrollViewWidth*1 + self.buttonPlay.frame.origin.x, self.buttonPlay.frame.origin.y, self.buttonPlay.frame.size.width, self.buttonPlay.frame.size.height)
        self.labelTrailer.frame = CGRectMake(scrollViewWidth*1 + self.labelTrailer.frame.origin.x, self.labelTrailer.frame.origin.y, self.labelTrailer.frame.size.width, self.labelTrailer.frame.size.height)
        
        
        //putting labels in correct pages of scrollView
        self.labelOverview.frame = CGRectMake(scrollViewWidth*2 + self.labelOverview.frame.origin.x, self.labelOverview.frame.origin.y, self.labelOverview.frame.size.width, self.labelOverview.frame.size.height)
        self.labelOverviewStatic.frame = CGRectMake(scrollViewWidth*2 + self.labelOverviewStatic.frame.origin.x, self.labelOverviewStatic.frame.origin.y, self.labelOverviewStatic.frame.size.width, self.labelOverviewStatic.frame.size.height)
        
        self.labelInformationsStatic.frame = CGRectMake(scrollViewWidth*3 + self.labelInformationsStatic.frame.origin.x, self.labelInformationsStatic.frame.origin.y, self.labelInformationsStatic.frame.size.width, self.labelInformationsStatic.frame.size.height)
        self.labelReleaseDateStatic.frame = CGRectMake(scrollViewWidth*3 + self.labelReleaseDateStatic.frame.origin.x, self.labelReleaseDateStatic.frame.origin.y, self.labelReleaseDateStatic.frame.size.width, self.labelReleaseDateStatic.frame.size.height)
        self.labelDate.frame = CGRectMake(scrollViewWidth*3 + self.labelDate.frame.origin.x, self.labelDate.frame.origin.y, self.labelDate.frame.size.width, self.labelDate.frame.size.height)
        self.labelOriginalLanguageStatic.frame = CGRectMake(scrollViewWidth*3 + self.labelOriginalLanguageStatic.frame.origin.x, self.labelOriginalLanguageStatic.frame.origin.y, self.labelOriginalLanguageStatic.frame.size.width, self.labelOriginalLanguageStatic.frame.size.height)
        self.labelOriginalLanguage.frame = CGRectMake(scrollViewWidth*3 + self.labelOriginalLanguage.frame.origin.x, self.labelOriginalLanguage.frame.origin.y, self.labelOriginalLanguage.frame.size.width, self.labelOriginalLanguage.frame.size.height)
        self.labelPopularityStatic.frame = CGRectMake(scrollViewWidth*3 + self.labelPopularityStatic.frame.origin.x, self.labelPopularityStatic.frame.origin.y, self.labelPopularityStatic.frame.size.width, self.labelPopularityStatic.frame.size.height)
        self.labelPopularity.frame = CGRectMake(scrollViewWidth*3 + self.labelPopularity.frame.origin.x, self.labelPopularity.frame.origin.y, self.labelPopularity.frame.size.width, self.labelPopularity.frame.size.height)
        self.labelMovieForAdultsStatic.frame = CGRectMake(scrollViewWidth*3 + self.labelMovieForAdultsStatic.frame.origin.x, self.labelMovieForAdultsStatic.frame.origin.y, self.labelMovieForAdultsStatic.frame.size.width, self.labelMovieForAdultsStatic.frame.size.height)
        self.labelMovieForAdults.frame = CGRectMake(scrollViewWidth*3 + self.labelMovieForAdults.frame.origin.x, self.labelMovieForAdults.frame.origin.y, self.labelMovieForAdults.frame.size.width, self.labelMovieForAdults.frame.size.height)
        self.labelVoteAverageStatic.frame = CGRectMake(scrollViewWidth*3 + self.labelVoteAverageStatic.frame.origin.x, self.labelVoteAverageStatic.frame.origin.y, self.labelVoteAverageStatic.frame.size.width, self.labelVoteAverageStatic.frame.size.height)
        self.labelVoteAverage.frame = CGRectMake(scrollViewWidth*3 + self.labelVoteAverage.frame.origin.x, self.labelVoteAverage.frame.origin.y, self.labelVoteAverage.frame.size.width, self.labelVoteAverage.frame.size.height)
        self.labelVoteCountStatic.frame = CGRectMake(scrollViewWidth*3 + self.labelVoteCountStatic.frame.origin.x, self.labelVoteCountStatic.frame.origin.y, self.labelVoteCountStatic.frame.size.width, self.labelVoteCountStatic.frame.size.height)
        self.labelVoteCount.frame = CGRectMake(scrollViewWidth*3 + self.labelVoteCount.frame.origin.x, self.labelVoteCount.frame.origin.y, self.labelVoteCount.frame.size.width, self.labelVoteCount.frame.size.height)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidAppear(animated: Bool) {
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            self.scrollView.contentOffset.x += 320
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
