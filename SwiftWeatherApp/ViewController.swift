//
//  ViewController.swift
//  SwiftWeatherApp
//

import UIKit
import SwiftHTTP

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate {
    
    @IBOutlet weak var layoutTable: UITableView!
    var cityLabel: UILabel?
    var temperatureLabel: UILabel?
    var hiloLabel: UILabel?
    var conditionsLabel: UILabel?
    var conditionsIconView: UIImageView?
    
    private var _openWeatherClient = OpenWeatherClient()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        self.setupOverviewWeatherLayout()
        
        self._openWeatherClient.fetchCurrentWeatherInfo(121.53, latitude: 25.05, success: updateUISuccess)
    }
    
    func setupOverviewWeatherLayout() {
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
        temperatureLabel = UILabel(frame: temperatureFrame)
        temperatureLabel!.backgroundColor = UIColor.clearColor()
        temperatureLabel!.textColor = UIColor.whiteColor()
        temperatureLabel!.text = "0°"
        temperatureLabel!.font = UIFont(name: "HelveticaNeue-UltraLight", size: 80)
        header.addSubview(temperatureLabel!)
        
        // Create hilo label
        hiloLabel = UILabel(frame: hiloFrame)
        hiloLabel!.backgroundColor = UIColor.clearColor()
        hiloLabel!.textColor = UIColor.whiteColor()
        hiloLabel!.text = "0° / 0°"
        hiloLabel!.font = UIFont(name: "HelveticaNeue-UltraLight", size: 28)
        header.addSubview(hiloLabel!)
        
        // Create city label
        cityLabel = UILabel(frame: CGRectMake(0, 35, self.view.bounds.size.width, 30))
        cityLabel!.backgroundColor = UIColor.clearColor()
        cityLabel!.textColor = UIColor.whiteColor()
        cityLabel!.text = "Loading..."
        cityLabel!.font = UIFont(name: "HelveticaNeue-Medium", size: 30)
        cityLabel!.textAlignment = NSTextAlignment.Center
        header.addSubview(cityLabel!)
        
        // Create conditions label
        conditionsLabel = UILabel(frame: conditionsFrame)
        conditionsLabel!.backgroundColor = UIColor.clearColor()
        conditionsLabel!.textColor = UIColor.whiteColor()
        conditionsLabel!.font = UIFont(name: "HelveticaNeue-UltraLight", size: 18)
        conditionsLabel!.text = "Clear"
        header.addSubview(conditionsLabel!)
        
        // Create icon view
        conditionsIconView = UIImageView(frame: iconFrame)
        conditionsIconView!.contentMode = UIViewContentMode.ScaleAspectFit
        conditionsIconView!.backgroundColor = UIColor.clearColor()
        header.addSubview(conditionsIconView!)
    }
    
    func updateUISuccess(weatherCondition : WeatherCondition) {
        self.cityLabel!.text = weatherCondition.cityName
        self.temperatureLabel!.text = "\(weatherCondition.temperature)°"
        self.hiloLabel!.text = "\(weatherCondition.temperatureHigh)° / \(weatherCondition.temperatureLow)°"
        self.conditionsLabel!.text = weatherCondition.condition
        self.conditionsIconView?.image = UIImage(named: weatherCondition.getIconName())
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: UITableViewDataSource
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = self.layoutTable.dequeueReusableCellWithIdentifier("Cell") as! UITableViewCell
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        cell.backgroundColor = UIColor(white:0, alpha:0.2)
        cell.textLabel?.textColor = UIColor.whiteColor()
        cell.textLabel?.backgroundColor = UIColor.clearColor()
        cell.detailTextLabel?.textColor = UIColor.whiteColor()
        cell.detailTextLabel?.backgroundColor = UIColor.clearColor()
        
        // Setup cell's content
        if (indexPath.section == 0) {
            if (indexPath.row == 0) {
                self.configureHeaderCell(cell, title: "Hourly Forecast")
            } else {
                self.configureHourlyCell(cell);
            }
        } else if (indexPath.section == 1) {
            if (indexPath.row == 0) {
                self.configureHeaderCell(cell, title: "Daily Forecast")
            } else {
                self.configureDailyCell(cell);
            }
        }
        
        return cell
    }
    
    func configureHeaderCell(cell: UITableViewCell, title: String) {
        cell.textLabel?.font = UIFont(name: "HelveticaNeue-Medium", size: 18)
        cell.textLabel?.text = title
        cell.detailTextLabel?.text = ""
        cell.imageView?.image = nil
    }
    
    func configureHourlyCell(cell: UITableViewCell) {
        cell.textLabel?.font = UIFont(name: "HelveticaNeue-Light", size: 18)
        cell.detailTextLabel?.font = UIFont(name: "HelveticaNeue-Medium", size: 18)
        cell.textLabel?.text = "test"
        cell.detailTextLabel?.text = "detail"
        cell.imageView?.image = UIImage(named: "weather-broken");
        cell.imageView?.contentMode = UIViewContentMode.ScaleAspectFit
    }
    
    func configureDailyCell(cell: UITableViewCell) {
        cell.textLabel?.font = UIFont(name: "HelveticaNeue-Light", size: 18)
        cell.detailTextLabel?.font = UIFont(name: "HelveticaNeue-Medium", size: 18)
        cell.textLabel?.text = "test"
        cell.detailTextLabel?.text = "detail"
        cell.detailTextLabel
        cell.imageView?.image = UIImage(named: "weather-clear");
        cell.imageView?.contentMode = UIViewContentMode.ScaleAspectFit
    }
    
    // MARK: UITableViewDelegate
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        var cellCount = CGFloat(self.tableView(tableView, numberOfRowsInSection: indexPath.section))
        return UIScreen.mainScreen().bounds.height / cellCount
    }
}
