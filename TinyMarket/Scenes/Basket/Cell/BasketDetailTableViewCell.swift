//
//  BasketDetailTableViewCell.swift
//  TinyMarket
//
//  Created by Onur Sır on 08.04.2023.
//

import UIKit
import Kingfisher
protocol BasketDetailTVCDelegate: AnyObject {
    func refreshTable(currentItem:ItemListModel)
}
class BasketDetailTableViewCell: UITableViewCell {
    var delegate: BasketDetailTVCDelegate?
    var currentItem : ItemListModel?
    @IBOutlet weak var imageViewProduct: UIImageView!
    
    @IBOutlet weak var labelProductName: UILabel! {
        didSet {
            labelProductName.numberOfLines  = 0
        }
    }
    @IBOutlet weak var buttonMinusOutlet: UIButton!
    
    @IBOutlet weak var labelProductCount: UILabel!
    @IBOutlet weak var buttonPlusOutlet: UIButton!
    @IBOutlet weak var labelProductPrice: UILabel! {
        didSet {
            labelProductPrice.numberOfLines  = 1
            labelProductPrice.textColor = .blue
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBAction func buttonMinusAction(_ sender: UIButton) {
        guard let currentItem = currentItem else {
            return
        }
        buttonPlusOutlet.isEnabled = true
        if let index = TotalConfig.shared.itemList.firstIndex(of: currentItem) {
            TotalConfig.shared.itemList[index].amount -= 1
            labelProductCount.text = "\(TotalConfig.shared.itemList[index].amount)"
            if currentItem.amount == currentItem.stock {
                buttonPlusOutlet.isEnabled = false
            } else if currentItem.amount == 0 {
                TotalConfig.shared.itemList.remove(at: index)
            }
            else {
                buttonPlusOutlet.isEnabled = true
            }
           
        }
        delegate?.refreshTable(currentItem:currentItem)
    }
    @IBAction func buttonPlusAction(_ sender: UIButton) {
        guard let currentItem = currentItem else {
            return
        }
        if let index = TotalConfig.shared.itemList.firstIndex(of: currentItem) {
            if currentItem.amount == currentItem.stock {
                buttonPlusOutlet.isEnabled = false
            } else {
                TotalConfig.shared.itemList[index].amount += 1
                buttonPlusOutlet.isEnabled = true
            }
            labelProductCount.text = "\(TotalConfig.shared.itemList[index].amount)"
        }
        delegate?.refreshTable(currentItem:currentItem)
    }
    
    func configure(item:ItemListModel) {
        currentItem = item
        if currentItem?.amount ?? 0 >= currentItem?.stock ?? 0 {
            buttonPlusOutlet.isEnabled = false
        } else {
            buttonMinusOutlet.isEnabled = true
        }
        imageViewProduct.kf.setImage(with: URL(string: item.imageUrl ?? ""), placeholder: UIImage(named: "placeholder"))

        labelProductPrice.text = "\(item.currency ?? "")\(item.price ?? 0.0)"
        labelProductName.text = item.name
        labelProductCount.text = "\(item.amount)"
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
