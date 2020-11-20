//
//  DetailViewController.swift
//  GetCoin
//
//  Created by Yüksel Ağgöz on 16.11.2020.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var coinIcon: UIImageView!
    @IBOutlet weak var coinName: UILabel!
    @IBOutlet weak var coinPrice: UILabel!
    @IBOutlet weak var coinDesc: UITextView!
    var coin: Coin!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        coinIcon.sd_setImage(with: URL(string: coin.iconURL), placeholderImage: nil)
        coinName.text = coin.name
        let price = Double(coin.price)
        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        formatter.numberStyle = .currency
        if let formattedTipAmount = formatter.string(from: price! as NSNumber) {
            coinPrice.text = "\(formattedTipAmount)"
        }
        coinDesc.attributedText = coin.description?.htmlToAttributedString
    }

}

extension String {
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return nil
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
}
