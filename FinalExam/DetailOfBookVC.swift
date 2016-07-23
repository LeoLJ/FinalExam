//
//  DetailOfBookVC.swift
//  FinalExam
//
//  Created by Leo on 7/22/16.
//  Copyright © 2016 Leo. All rights reserved.
//

import UIKit
import SafariServices
import MapKit
import SystemConfiguration

class DetailOfBookVC: UIViewController, MKMapViewDelegate, UIScrollViewDelegate {
    @IBOutlet weak var bookNameLabel: UILabel!
    @IBOutlet weak var storeAddreLabel: UIButton!
    @IBOutlet weak var storeTelLabel: UIButton!
    @IBOutlet weak var storeWebLabel: UIButton!
    @IBOutlet weak var bookSummaryLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var bookImage: UIImageView?
    @IBOutlet weak var imageScrollView: UIScrollView!
    var index: Int?
    var imageView: UIImageView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imageScrollView.delegate = self
        self.mapView.hidden = true
        self.imageScrollView.hidden = true
        
        bookNameLabel.text = BookLists.shareInstance.currentLists[index!].bookName
        storeTelLabel.setTitle("\(BookLists.shareInstance.currentLists[index!].storeTel!)", forState: .Normal)
        storeWebLabel.setTitle("Go Web", forState: .Normal)
        storeAddreLabel.setTitle("\(BookLists.shareInstance.currentLists[index!].storeAddre!)", forState: .Normal)
        bookSummaryLabel.text = BookLists.shareInstance.currentLists[index!].bookSummary       
        bookImage?.image =  BookLists.shareInstance.currentLists[index!].bookImage
        imageView = UIImageView(image: BookLists.shareInstance.currentLists[index!].bookImage)
        self.imageScrollView.addSubview(imageView!)
        self.imageScrollView.contentSize = bookImage!.frame.size
        self.imageScrollView.delegate = self
        self.imageScrollView.maximumZoomScale = 1.0
        self.imageScrollView.minimumZoomScale = 0.1
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func openWeb(sender: AnyObject) {
        let url = NSURL(string: "\(BookLists.shareInstance.currentLists[index!].storeWeb!)")
        let controller = SFSafariViewController(URL: url!)
        self.presentViewController(controller, animated: true, completion: nil)
    }
    

    @IBAction func checkDetailImage(sender: AnyObject) {
        self.mapView.hidden = true
        self.imageScrollView.hidden = false
    }
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return self.imageView
    }
    
    @IBAction func callStore(sender: AnyObject) {
        if let url = NSURL(string: "tel://\(BookLists.shareInstance.currentLists[index!].storeTel!)") {
            UIApplication.sharedApplication().openURL(url)
        }
    }
    // Just copy
    @IBAction func goStore(sender: AnyObject) {
        
        if BookLists.shareInstance.currentLists[index!].storeAddre != nil {
            
            self.mapView.hidden = false
            self.imageScrollView.hidden = true
            
            let geoCoder = CLGeocoder()
            geoCoder.geocodeAddressString(BookLists.shareInstance.currentLists[index!].storeAddre!, completionHandler: { (placemarks, error) in
                if placemarks?.isEmpty == false {
                    
                    let placemark = placemarks?.first
                    
                    let annotation = MKPointAnnotation()
                    annotation.title = placemark?.name
                    annotation.coordinate = (placemark?.location?.coordinate)!
                    
                    self.mapView.showAnnotations([annotation], animated: true)
                    
                    self.zoomMapViewFromCoordinate((placemark!.location?.coordinate)!)
                }
            })
        }
        
    }
    // Just copy
    func zoomMapViewFromCoordinate(coordinate: CLLocationCoordinate2D) {
        let latDelta: CLLocationDegrees = 0.05
        let lonDelta: CLLocationDegrees = 0.05
        
        let span: MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: lonDelta)
        let location: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude)
        
        let region: MKCoordinateRegion = MKCoordinateRegion(center: location, span: span)
        
        self.mapView.setRegion(region, animated: true)
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
