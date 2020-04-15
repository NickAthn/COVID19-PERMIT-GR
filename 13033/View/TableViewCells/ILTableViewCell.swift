//
//  ILTableViewCell.swift
//  13033
//
//  Created by Nikolaos Athanasiou on 15/4/20.
//  Copyright © 2020 Nikolaos Athanasiou. All rights reserved.
//

import UIKit
import EasyPeasy

class ILTableViewCell: UITableViewCell {
    var shouldUpdateConstraints = true
    
    var id: String!
    var titleLabel: UILabel!
    var iconImageView: UIImageView!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        updateConstraints()
    }
    

    func setupView() {
        titleLabel = UILabel(frame: .zero)
        titleLabel.textAlignment = .left
        
        iconImageView = UIImageView(frame: .zero)
        iconImageView.roundCorners(.allCorners, radius: 15)
    }

    override func updateConstraints() {
        if shouldUpdateConstraints {
            shouldUpdateConstraints.toggle()
            
            iconImageView.easy.layout(
                Size(24),
                Top(5),
                Left(5),
                Bottom(5)
            )
            
            titleLabel.easy.layout(
                Left(5).to(iconImageView, .right),
                Right(5)
            )
        }
        super.updateConstraints()
    }
}
