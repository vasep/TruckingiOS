//
//  StopsTableViewCell.swift
//  FreightOneIos
//
//  Created by Vasil Panov on 17.12.20.
//

import UIKit

class StopsTableViewCell: UITableViewCell {
        
    @IBOutlet weak var stopTypeLabel: UILabel!
    @IBOutlet weak var arriveButton: UIButton!
    @IBOutlet weak var loadedButton: UIButton!
    @IBOutlet weak var zipLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var streetLabel: UILabel!
    static let identifier = "StopsTableViewCell"
    
    static func nib()->UINib {
        return UINib(nibName: "StopsTableViewCell", bundle: nil)
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func arriveButtonClicked(_ sender: UIButton) {
    }
    
    @IBAction func loadedButtonClicked(_ sender: UIButton) {
    }
}
