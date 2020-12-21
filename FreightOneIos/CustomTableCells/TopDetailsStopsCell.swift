//
//  TopDetailsStopsCell.swift
//  FreightOneIos
//
//  Created by Vasil Panov on 21.12.20.
//

import UIKit

class TopDetailsStopsCell: UITableViewCell {

    @IBOutlet weak var driverText: UILabel!
    @IBOutlet weak var customerLoadTxt: UILabel!
    @IBOutlet weak var brokerTxt: UILabel!
    @IBOutlet weak var temperatureTxt: UILabel!
    @IBOutlet weak var emptyMilesTxt: UILabel!
    @IBOutlet weak var truckTxt: UILabel!
    @IBOutlet weak var trailerTxt: UILabel!
    
    static let identifier = "TopDetailsStopsCell"
    
    static func nib()->UINib {
        return UINib(nibName: "TopDetailsStopsCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
