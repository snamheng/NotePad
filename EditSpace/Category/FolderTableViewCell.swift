//
//  FolderTableViewCell.swift
//  EditSpace
//
//  Created by heng on 13/9/23.
//

import UIKit

class FolderTableViewCell: UITableViewCell {

    @IBOutlet weak var folderIcon: UIImageView!
    @IBOutlet weak var folderTitle: UILabel!
    @IBOutlet weak var folderAmount: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
         super.layoutSubviews()
         let bottomSpace: CGFloat = 10.0 // Let's assume the space you want is 10
         self.contentView.frame = self.contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: bottomSpace, right: 0))
    }
    
}
