


import UIKit

protocol ButtonTableViewCellDelegate {
    func buttonTableViewCellDidPress(cell: UITableViewCell)
}

class ButtonTableViewCell: UITableViewCell {
    
    @IBOutlet weak var button: UIButton!
    
    var delegate: ButtonTableViewCellDelegate?
    
    @IBAction func press(sender: UIButton) {
        if let delegate = self.delegate {
            delegate.buttonTableViewCellDidPress(cell: self)
        }
    }
}
