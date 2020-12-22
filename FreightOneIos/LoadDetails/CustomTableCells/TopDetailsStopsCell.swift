//
//  TopDetailsStopsCell.swift
//  FreightOneIos
//
//  Created by Vasil Panov on 21.12.20.
//

import UIKit

class TopDetailsStopsCell: UITableViewCell {

    @IBOutlet weak var driverText: UILabel!
    @IBOutlet weak var driver2: UILabel!
    @IBOutlet weak var customerLoadTxt: UILabel!
    @IBOutlet weak var brokerTxt: UILabel!
    @IBOutlet weak var temperatureTxt: UILabel!
    @IBOutlet weak var emptyMilesTxt: UILabel!
    @IBOutlet weak var truckTxt: UILabel!
    @IBOutlet weak var trailerTxt: UILabel!
    
    @IBOutlet weak var trailerIV: UIImageView!
    @IBOutlet weak var truckIV: UIImageView!
    @IBOutlet weak var dashboardIV: UIImageView!
    @IBOutlet weak var termometarIV: UIImageView!
    @IBOutlet weak var driverIV: UIImageView!
    @IBOutlet weak var brokerIV: UIImageView!
    
    static let identifier = "TopDetailsStopsCell"
    
    static func nib()->UINib {
        return UINib(nibName: "TopDetailsStopsCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        trailerIV.image = trailerIV.image?.withRenderingMode(.alwaysTemplate)
        truckIV.image = truckIV.image?.withRenderingMode(.alwaysTemplate)
        dashboardIV.image = dashboardIV.image?.withRenderingMode(.alwaysTemplate)
        termometarIV.image = termometarIV.image?.withRenderingMode(.alwaysTemplate)
        driverIV.image = driverIV.image?.withRenderingMode(.alwaysTemplate)
        brokerIV.image = brokerIV.image?.withRenderingMode(.alwaysTemplate)
        
        trailerIV.tintColor = UIColor.systemBlue
        truckIV.tintColor = UIColor.systemBlue
        dashboardIV.tintColor = UIColor.systemBlue
        termometarIV.tintColor = UIColor.systemBlue
        driverIV.tintColor = UIColor.systemBlue
        brokerIV.tintColor = UIColor.systemBlue

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
