
import UIKit

class TableViewCell: UITableViewCell {

    
    @IBOutlet weak var myImage: UIImageView!
    
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var myDescription: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
