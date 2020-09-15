//
//  FormCell.swift
//  Instagram-Demo
//
//  Created by Cristian Sedano Arenas on 14/09/2020.
//  Copyright © 2020 Cristian Sedano Arenas. All rights reserved.
//

import UIKit

protocol FormCellDelegate: AnyObject {
    
    func formTableViewCell(_ cell: FormCell, didUpdatetextField updateModel: EditProfileModel)
}

class FormCell: UITableViewCell {
    
    public weak var delegate: FormCellDelegate?
    private var model: EditProfileModel?
    
    private let formLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 1
        
        return label
    }()
    
    private let textField: UITextField = {
        let textField = UITextField()
        textField.returnKeyType = .done
        return textField
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        clipsToBounds = true
        contentView.addSubview(formLabel)
        contentView.addSubview(textField)
        
        textField.delegate = self
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Assign frames
        formLabel.frame = CGRect(x: 5,
                                 y: 0,
                                 width: contentView.width/3,
                                 height: contentView.height)
        
        textField.frame = CGRect(x: formLabel.right + 5,
                                 y: 0,
                                 width: contentView.width-10-formLabel.width,
                                 height: contentView.height)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        formLabel.text = nil
        textField.placeholder = nil
        textField.text = nil
    }
    
    public func configureCell(with model: EditProfileModel) {
        
        self.model = model
        formLabel.text = model.label
        textField.placeholder = model.placeholder
        textField.text = model.value
    }
}

extension FormCell: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        model?.value = textField.text
        
        guard let model = model else { return true }
        
        delegate?.formTableViewCell(self, didUpdatetextField: model)
        
        textField.resignFirstResponder()
        
        return true
    }
}
