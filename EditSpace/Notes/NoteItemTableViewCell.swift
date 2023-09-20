//
//  NoteItemTableViewCell.swift
//  EditSpace
//
//  Created by heng on 14/9/23.
//

import UIKit

class NoteItemTableViewCell: UITableViewCell {

    @IBOutlet weak var noteItemTitle: UILabel!
    @IBOutlet weak var noteItemSubTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
