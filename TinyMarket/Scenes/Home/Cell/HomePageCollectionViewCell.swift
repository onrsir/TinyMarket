//
//  HomePageCollectionViewCell.swift
//  TinyMarket
//
//  Created by Onur Sır on 08.04.2023.
//

import UIKit
import Kingfisher
protocol HomePageCollectionViewDelegate: AnyObject {
    func refreshBasket()
}

class HomePageCollectionViewCell: UICollectionViewCell {
    var delegate: HomePageCollectionViewDelegate?
    var currentItem : ItemListModel?
    @IBOutlet weak var imageView: UIImageView! {
        didSet {
            imageView.contentMode = .scaleAspectFit
        }
    }
    
    @IBOutlet weak var labelPrice: UILabel! {
        didSet {
            labelPrice.textColor = .blue
        }
    }
    
    @IBOutlet weak var stackView: UIStackView! {
        didSet {
            stackView.layer.borderColor = UIColor.gray.cgColor
            stackView.layer.borderWidth = 1
        }
    }
    @IBOutlet weak var buttonMinusOutlet: UIButton! {
        didSet {
            buttonMinusOutlet.isHidden = true
        }
    }
    @IBOutlet weak var buttonPlusOutlet: UIButton!
    @IBOutlet weak var labelCount: UILabel! {
        didSet {
            labelCount.isHidden = true
        }
    }
    @IBOutlet weak var labelProductName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    @IBAction func buttonPlusAction(_ sender: UIButton) {
        buttonMinusOutlet.isHidden = false
        buttonMinusOutlet.isEnabled = true
        labelCount.isHidden = false
        guard let currentItem = currentItem else {
            return
        }
        if !TotalConfig.shared.itemList.isEmpty {
            if let index = TotalConfig.shared.itemList.firstIndex(of: currentItem) {
                TotalConfig.shared.itemList[index].amount += 1
                }
            else {
                TotalConfig.shared.itemList.append(currentItem)
                currentItem.amount += 1
            }
        } else {
            TotalConfig.shared.itemList.append(currentItem)
            TotalConfig.shared.itemList.first?.amount += 1
        }

        refresh()
    }
    
    @IBAction func buttonMinusAction(_ sender: UIButton) {
        guard let currentItem = currentItem else {
            return
        }
        for item in TotalConfig.shared.itemList {
            if currentItem.id == item.id {
                if let index = TotalConfig.shared.itemList.firstIndex(of: currentItem) {
                    TotalConfig.shared.itemList[index].amount -= 1
                    }
               
            }
        }
        refresh()
        if currentItem.amount == 0  {
            if let index = TotalConfig.shared.itemList.firstIndex(of: currentItem) {
                TotalConfig.shared.itemList.remove(at: index)
                }
         
            buttonMinusOutlet.isHidden = true
            labelCount.isHidden = true
        }
        refresh()
    }
    func resetLabelCount() {
            labelCount.text = "0"
        }
    
    func configure(item:ItemListModel) {
        self.currentItem = item
        imageView.kf.setImage(with: URL(string: item.imageUrl ?? ""), placeholder: UIImage(named: "placeholder"))

        labelPrice.text = "\(item.currency ?? "")\(item.price ?? 0.0)"
        labelProductName.text = item.name
        
        // Reset label count when configuring the cell with a new item
        resetLabelCount()

        if currentItem?.amount != 0 {
            labelCount.text = "\(currentItem?.amount ?? 0)"
            buttonPlusOutlet.isEnabled = true
            buttonPlusOutlet.isHidden = false
            buttonMinusOutlet.isHidden = false
            labelCount.isHidden = false
            buttonMinusOutlet.isEnabled = true
        } else {
            buttonPlusOutlet.isEnabled = true
            buttonPlusOutlet.isHidden = false
            buttonMinusOutlet.isHidden = true
            labelCount.isHidden = true
            buttonMinusOutlet.isEnabled = false
        }
        refresh()
    }
    
    func refresh() {
        self.delegate?.refreshBasket()
        if currentItem?.amount == currentItem?.stock ?? 0 {
            buttonPlusOutlet.isEnabled = false
        } else {
            buttonPlusOutlet.isEnabled = true
        }
        guard let currentItem = currentItem else {
            return
        }
        self.labelCount.text = "\(currentItem.amount )"
    }

}


