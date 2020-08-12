//
//  AddressCell.swift
//  AutoData
//
//  Created by 聂飞安 on 2020/5/2.
//

import UIKit
import SwiftProjects
class AddressCell: CusAutoTableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func initializePage() {
      addAutoView([(.label, 2)])
      super.initializePage()
    }
    
    override func initLayoutSubviews() {
        getSubview(autoViewClass: .label, index: 1)?.snp.makeConstraints({ (make) in
            make.left.equalTo(15)
            make.top.equalTo(10)
            make.bottom.equalTo(-10)
            make.height.equalTo(25)
        })
        
        getSubview(autoViewClass: .label, index: 2)?.snp.makeConstraints({ (make) in
            make.left.equalTo(35)
            make.top.equalTo(10)
            make.bottom.equalTo(-10)
            make.height.equalTo(25)
        })
    }
    
    override func initializeDraw() {
        if let label = getSubview(autoViewClass: .label, index: 1) as? UILabel{
            label.textColor = .initString("999999")
        }
        
        if let label = getSubview(autoViewClass: .label, index: 2) as? UILabel{
            label.textColor = .black
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
