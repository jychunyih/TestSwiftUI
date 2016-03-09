//
//  CardTableViewCell.swift
//  TestSwiftUI
//
//  Created by chunyih on 16/3/9.
//  Copyright © 2016年 chunyih. All rights reserved.
//

import UIKit

class CardTableViewCell: UITableViewCell {
    
    @IBOutlet weak var contentImageView: UIImageView!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    var testLabel: UILabel!;
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
        testLabel = UILabel();
        addSubview(testLabel);
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setCellContent(model: Card) {
        self.captionLabel.text = model.Caption;
        self.contentLabel.text = model.MediaContent;
    }
    
    override func layoutSubviews() {
        testLabel.frame = CGRect(x: 10, y: 10, width: 100, height: 50)
    }

}
