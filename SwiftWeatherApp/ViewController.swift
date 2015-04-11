//
//  ViewController.swift
//  SwiftWeatherApp
//

import UIKit
import SwiftHTTP

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate {

    @IBOutlet weak var layoutTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        self.setupWeatherOverviewFrame()
        
        self.updateWeatherInfo(121.53, latitude: 25.05);
    }
    
    func setupWeatherOverviewFrame() {
        var headerFrame: CGRect = UIScreen.mainScreen().bounds
        var inset: CGFloat = 20
        
        var temperatureHeight: CGFloat  = 110
        var hiloHeight: CGFloat  = 40
        var iconHeight: CGFloat  = 30
        
        // Create various frames
        var hiloFrame = CGRectMake(inset, headerFrame.size.height - hiloHeight, headerFrame.size.width - (2 * inset), hiloHeight)
        
        var temperatureFrame = CGRectMake(inset, headerFrame.size.height - (temperatureHeight + hiloHeight), headerFrame.size.width - (2 * inset), temperatureHeight)
        
        var iconFrame = CGRectMake(inset, temperatureFrame.origin.y - iconHeight, iconHeight, iconHeight)
        
        var conditionsFrame = iconFrame;
        conditionsFrame.size.width = self.view.bounds.size.width - (((2 * inset) + iconHeight) + 10)
        conditionsFrame.origin.x = iconFrame.origin.x + (iconHeight + 10)
        
        // Setup the frames position
        var header = UIView(frame: headerFrame)
        header.backgroundColor = UIColor.clearColor()
        self.layoutTable.tableHeaderView = header
        
        // Create temperature label
        var temperatureLabel = UILabel(frame: temperatureFrame)
        temperatureLabel.backgroundColor = UIColor.clearColor()
        temperatureLabel.textColor = UIColor.whiteColor()
        temperatureLabel.text = "0°"
        temperatureLabel.font = UIFont(name: "HelveticaNeue-UltraLight", size: 80)
        header.addSubview(temperatureLabel)
        
        // Create hilo label
        var hiloLabel = UILabel(frame: hiloFrame)
        hiloLabel.backgroundColor = UIColor.clearColor()
        hiloLabel.textColor = UIColor.whiteColor()
        hiloLabel.text = "0° / 0°"
        hiloLabel.font = UIFont(name: "HelveticaNeue-UltraLight", size: 28)
        header.addSubview(hiloLabel)
        
        // Create city label
        var cityLabel = UILabel(frame: CGRectMake(0, 35, self.view.bounds.size.width, 30))
        cityLabel.backgroundColor = UIColor.clearColor()
        cityLabel.textColor = UIColor.whiteColor()
        cityLabel.text = "Loading..."
        cityLabel.font = UIFont(name: "HelveticaNeue-UltraLight", size: 30)
        cityLabel.textAlignment = NSTextAlignment.Center
        header.addSubview(cityLabel)
        
        // Create conditions label
        var conditionsLabel = UILabel(frame: conditionsFrame)
        conditionsLabel.backgroundColor = UIColor.clearColor()
        conditionsLabel.textColor = UIColor.whiteColor()
        conditionsLabel.font = UIFont(name: "HelveticaNeue-UltraLight", size: 18)
        conditionsLabel.text = "Clear"
        header.addSubview(conditionsLabel)
        
        // Create icon view
        var iconView = UIImageView(frame: iconFrame)
        iconView.contentMode = UIViewContentMode.ScaleAspectFit
        iconView.backgroundColor = UIColor.clearColor()
        header.addSubview(iconView)
    }

    func updateWeatherInfo(longitude: Float, latitude: Float) {
        var request = HTTPTask()
        request.responseSerializer = JSONResponseSerializer()
        request.GET("http://api.openweathermap.org/data/2.5/weather",
            //parameters: ["lon": longitude, "lat": latitude],
            parameters: ["q": "Taipei", "units": "metric"],
            success: {(response: HTTPResponse) in
                if let weatherData = response.responseObject as? Dictionary<String, AnyObject> {
                    self.updateUISuccess(weatherData)
                }
            },
            failure: {(error: NSError, response: HTTPResponse?) in
                println("error: \(error)")
            }
        )
    }
    
    func updateUISuccess(weatherData : NSDictionary!) {
        if let tempResult = weatherData["main"]?["temp"] as? Double {
            var temperature = round(10 * tempResult) / 10
            var cityName = weatherData["name"] as! String
            
            println("cityName=\(cityName), temperature=\(temperature)")
        } else {
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = self.layoutTable.dequeueReusableCellWithIdentifier("Cell") as! UITableViewCell?
        cell?.selectionStyle = UITableViewCellSelectionStyle.None
        cell?.backgroundColor = UIColor(white:0, alpha:0.2)
        cell?.textLabel?.textColor = UIColor.whiteColor()
        cell?.detailTextLabel?.textColor = UIColor.whiteColor()
        cell?.textLabel?.text = "Weather Podcast @ \(indexPath.section) / \(indexPath.row)"
        
        // TODO: Setup the cell
        
        return cell!
    }
}

