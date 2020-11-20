//
//  HomeViewController.swift
//  GetCoin
//
//  Created by Yüksel Ağgöz on 16.11.2020.
//

import UIKit
import Alamofire
import SDWebImageSVGCoder

class HomeViewController: UIViewController {
    
    @IBOutlet weak var mainTableView: UITableView!
    var coinList = [Coin]()
    var pageOffset = 0
    let paginationLimit = 10
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getCoins()
    }
    
    func getCoins() -> Void {
        let params: [String: Any] = [
            "base": Locale.current.currencyCode!,
            "limit": paginationLimit,
            "offset": pageOffset
        ]
        
        NetworkManager.instance.fetchGetRequest(endpoint: "coins", parameters: params, model: CoinResponseModel.self) { (response) in
            switch response{
            case .success(let model):
                let responseModel = model as! CoinResponseModel
                self.coinList = self.coinList + responseModel.data.coins
                self.mainTableView.reloadData()
                self.pageOffset = self.pageOffset + self.paginationLimit
            case .failure(_):
                break
            }
        }
    }
    
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.coinList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CoinCell")!
        let coinIcon = cell.viewWithTag(1) as! UIImageView
        let coinName = cell.viewWithTag(2) as! UILabel
        let coinValue = cell.viewWithTag(3) as! UILabel
        
        let coin: Coin = coinList[indexPath.row]
        
        coinIcon.sd_setImage(with: URL(string: coin.iconURL), placeholderImage: nil)
        coinName.text = coin.name
        coinName.textColor = hexStringToUIColor(hex: coin.color ?? "#888888")
        let price = Double(coin.price)
        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        formatter.numberStyle = .currency
        if let formattedTipAmount = formatter.string(from: price! as NSNumber) {
            coinValue.text = "\(formattedTipAmount)"
        }
        coinValue.textColor = hexStringToUIColor(hex: coin.color ?? "#888888")
        
        if indexPath.row == coinList.count - 1 {
            if pageOffset >= coinList.count && pageOffset < 40 {
                getCoins()
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = self.storyboard?.instantiateViewController(identifier: "DetailViewController") as! DetailViewController
        detailVC.coin = coinList[indexPath.row]
        self.navigationController?.pushViewController(detailVC, animated: true)
        
    }
    
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) != 6) {
            return UIColor.gray
        }

        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
}
