//
//  StopsTableViewCell.swift
//  FreightOneIos
//
//  Created by Vasil Panov on 17.12.20.
//

import UIKit

protocol StopsTableViewCellDelegate: AnyObject {
    func didTapArriveButton(_ tag: Int)
    func didTapLoadedButton(_ tag: Int)
}

class StopsTableViewCell: UITableViewCell {
    
    weak var delegate: StopsTableViewCellDelegate?
    
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
        delegate?.didTapArriveButton(sender.tag)
        arriveButton.setTitleColor(UIColor.white, for: .normal)
        arriveButton.backgroundColor = UIColor.green
        arriveButton.isEnabled = false
    }
    
    @IBAction func loadedButtonClicked(_ sender: UIButton) {
        delegate?.didTapLoadedButton(sender.tag)
        arriveButton.isEnabled = false
        loadedButton.isEnabled = false
        
        arriveButton.setTitleColor(UIColor.white, for: .normal)
        loadedButton.setTitleColor(UIColor.white, for: .normal)
        arriveButton.backgroundColor = UIColor.green
        loadedButton.backgroundColor = UIColor.green
    }
}
