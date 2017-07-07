//
//  SubcriberCell.swift
//  DemoApp
//
//  Created by DUONG VANHOP on 2017/06/14.
//  Copyright © 2017年 DUONG VANHOP. All rights reserved.
//

import UIKit
import Kingfisher

class SubcriberCell: UITableViewCell {

    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var url: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }

    private func configureUI() {
        thumbnail.contentMode = .scaleAspectFit
        name.font = UIFont.systemFont(ofSize: 20)
        name.textColor = UIColor.darkGray
        url.font = UIFont.systemFont(ofSize: 12)
        url.textColor = UIColor.gray
    }

    func configure(subcriber: Subcriber) {
        name.text = subcriber.name
        url.text = subcriber.generation
        thumbnail.setImageKf(with: URL(string: subcriber.imageUrl)!)
    }

}
