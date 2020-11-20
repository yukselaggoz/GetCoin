//
//  CoinResponseModel.swift
//  GetCoin
//
//  Created by Yüksel Ağgöz on 16.11.2020.
//

import Foundation

struct CoinResponseModel: Codable {
    let status: String
    let data: PurpleData
}

struct PurpleData: Codable {
    let stats: Stats
    let base: Base
    let coins: [Coin]
}

struct Base: Codable {
    let symbol, sign: String
}

struct Coin: Codable {
    let id: Int
    let uuid, slug, symbol, name: String
    let description, color: String?
    let iconType: IconType
    let iconURL: String
    let websiteURL: String?
    let socials, links: [Link]
    let confirmedSupply: Bool
    let numberOfMarkets, numberOfExchanges: Int
    let type: CoinType
    let volume, marketCap: Int
    let price: String
    let circulatingSupply, totalSupply: Double?
    let approvedSupply: Bool
    let firstSeen, listedAt: Int
    let change: Double
    let rank: Int
    let history: [String]
    let allTimeHigh: AllTimeHigh
    let penalty: Bool

    enum CodingKeys: String, CodingKey {
        case id, uuid, slug, symbol, name, description, color, iconType
        case iconURL = "iconUrl"
        case websiteURL = "websiteUrl"
        case socials, links, confirmedSupply, numberOfMarkets, numberOfExchanges, type, volume, marketCap, price, circulatingSupply, totalSupply, approvedSupply, firstSeen, listedAt, change, rank, history, allTimeHigh, penalty
    }
}

struct AllTimeHigh: Codable {
    let price: String
    let timestamp: Int
}

enum IconType: String, Codable {
    case pixel = "pixel"
    case vector = "vector"
}

struct Link: Codable {
    let name: String
    let type: LinkType
    let url: String
}

enum LinkType: String, Codable {
    case bitcointalk = "bitcointalk"
    case discord = "discord"
    case explorer = "explorer"
    case facebook = "facebook"
    case github = "github"
    case instagram = "instagram"
    case linkedin = "linkedin"
    case medium = "medium"
    case reddit = "reddit"
    case telegram = "telegram"
    case twitter = "twitter"
    case website = "website"
    case wechat = "wechat"
    case youtube = "youtube"
}

enum CoinType: String, Codable {
    case coin = "coin"
}

struct Stats: Codable {
    let total, offset, limit: Int
    let order, base: String
    let totalMarkets, totalExchanges: Int
    let totalMarketCap, total24HVolume: Double

    enum CodingKeys: String, CodingKey {
        case total, offset, limit, order, base, totalMarkets, totalExchanges, totalMarketCap
        case total24HVolume = "total24hVolume"
    }
}

// MARK: Convenience initializers

extension CoinResponseModel {
    init?(data: Data) {
        guard let me = try? JSONDecoder().decode(CoinResponseModel.self, from: data) else { return nil }
        self = me
    }

    init?(_ json: String, using encoding: String.Encoding = .utf8) {
        guard let data = json.data(using: encoding) else { return nil }
        self.init(data: data)
    }

    init?(fromURL url: String) {
        guard let url = URL(string: url) else { return nil }
        guard let data = try? Data(contentsOf: url) else { return nil }
        self.init(data: data)
    }

    var jsonData: Data? {
        return try? JSONEncoder().encode(self)
    }

    var json: String? {
        guard let data = self.jsonData else { return nil }
        return String(data: data, encoding: .utf8)
    }
}

extension PurpleData {
    init?(data: Data) {
        guard let me = try? JSONDecoder().decode(PurpleData.self, from: data) else { return nil }
        self = me
    }

    init?(_ json: String, using encoding: String.Encoding = .utf8) {
        guard let data = json.data(using: encoding) else { return nil }
        self.init(data: data)
    }

    init?(fromURL url: String) {
        guard let url = URL(string: url) else { return nil }
        guard let data = try? Data(contentsOf: url) else { return nil }
        self.init(data: data)
    }

    var jsonData: Data? {
        return try? JSONEncoder().encode(self)
    }

    var json: String? {
        guard let data = self.jsonData else { return nil }
        return String(data: data, encoding: .utf8)
    }
}

extension Base {
    init?(data: Data) {
        guard let me = try? JSONDecoder().decode(Base.self, from: data) else { return nil }
        self = me
    }

    init?(_ json: String, using encoding: String.Encoding = .utf8) {
        guard let data = json.data(using: encoding) else { return nil }
        self.init(data: data)
    }

    init?(fromURL url: String) {
        guard let url = URL(string: url) else { return nil }
        guard let data = try? Data(contentsOf: url) else { return nil }
        self.init(data: data)
    }

    var jsonData: Data? {
        return try? JSONEncoder().encode(self)
    }

    var json: String? {
        guard let data = self.jsonData else { return nil }
        return String(data: data, encoding: .utf8)
    }
}

extension Coin {
    init?(data: Data) {
        guard let me = try? JSONDecoder().decode(Coin.self, from: data) else { return nil }
        self = me
    }

    init?(_ json: String, using encoding: String.Encoding = .utf8) {
        guard let data = json.data(using: encoding) else { return nil }
        self.init(data: data)
    }

    init?(fromURL url: String) {
        guard let url = URL(string: url) else { return nil }
        guard let data = try? Data(contentsOf: url) else { return nil }
        self.init(data: data)
    }

    var jsonData: Data? {
        return try? JSONEncoder().encode(self)
    }

    var json: String? {
        guard let data = self.jsonData else { return nil }
        return String(data: data, encoding: .utf8)
    }
}

extension AllTimeHigh {
    init?(data: Data) {
        guard let me = try? JSONDecoder().decode(AllTimeHigh.self, from: data) else { return nil }
        self = me
    }

    init?(_ json: String, using encoding: String.Encoding = .utf8) {
        guard let data = json.data(using: encoding) else { return nil }
        self.init(data: data)
    }

    init?(fromURL url: String) {
        guard let url = URL(string: url) else { return nil }
        guard let data = try? Data(contentsOf: url) else { return nil }
        self.init(data: data)
    }

    var jsonData: Data? {
        return try? JSONEncoder().encode(self)
    }

    var json: String? {
        guard let data = self.jsonData else { return nil }
        return String(data: data, encoding: .utf8)
    }
}

extension Link {
    init?(data: Data) {
        guard let me = try? JSONDecoder().decode(Link.self, from: data) else { return nil }
        self = me
    }

    init?(_ json: String, using encoding: String.Encoding = .utf8) {
        guard let data = json.data(using: encoding) else { return nil }
        self.init(data: data)
    }

    init?(fromURL url: String) {
        guard let url = URL(string: url) else { return nil }
        guard let data = try? Data(contentsOf: url) else { return nil }
        self.init(data: data)
    }

    var jsonData: Data? {
        return try? JSONEncoder().encode(self)
    }

    var json: String? {
        guard let data = self.jsonData else { return nil }
        return String(data: data, encoding: .utf8)
    }
}

extension Stats {
    init?(data: Data) {
        guard let me = try? JSONDecoder().decode(Stats.self, from: data) else { return nil }
        self = me
    }

    init?(_ json: String, using encoding: String.Encoding = .utf8) {
        guard let data = json.data(using: encoding) else { return nil }
        self.init(data: data)
    }

    init?(fromURL url: String) {
        guard let url = URL(string: url) else { return nil }
        guard let data = try? Data(contentsOf: url) else { return nil }
        self.init(data: data)
    }

    var jsonData: Data? {
        return try? JSONEncoder().encode(self)
    }

    var json: String? {
        guard let data = self.jsonData else { return nil }
        return String(data: data, encoding: .utf8)
    }
}
