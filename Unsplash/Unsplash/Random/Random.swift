//
//  Random.swift
//  Unsplash
//
//  Created by 김규철 on 2023/09/18.
//

import Foundation

struct ImageInfo: Codable, Hashable {
    let id: String
    let slug: String
    let createdAt: String
    let updatedAt: String
    let promotedAt: String?
    let width: Int
    let height: Int
    let color: String
    let blurHash: String?
    let altDescription: String?
    let urls: ImageURLs
    let links: ImageLinks
    let likes: Int
    let likedByUser: Bool
    let currentUserCollections: [String]?

    private enum CodingKeys: String, CodingKey {
        case id, slug, createdAt = "created_at", updatedAt = "updated_at", promotedAt = "promoted_at",
             width, height, color, blurHash, altDescription = "alt_description", urls, links, likes, likedByUser = "liked_by_user", currentUserCollections
    }
}

struct ImageURLs: Codable, Hashable {
    let raw: String
    let full: String
    let regular: String
    let small: String
    let thumb: String
    let smallS3: String

    private enum CodingKeys: String, CodingKey {
        case raw, full, regular, small, thumb, smallS3 = "small_s3"
    }
}

struct ImageLinks: Codable, Hashable {
    let selfLink: URL
    let html: URL
    let download: URL
    let downloadLocation: URL

    private enum CodingKeys: String, CodingKey {
        case selfLink = "self", html, download, downloadLocation = "download_location"
    }
}

struct UserInfo: Codable, Hashable {
    let id: String
    let updatedAt: Date
    let username: String
    let name: String
    let firstName: String
    let lastName: String
    let portfolioURL: URL?
    let bio: String?
    let location: String?
    let links: UserLinks
    let profileImage: UserProfileImage
    let instagramUsername: String?
    let totalCollections: Int
    let totalLikes: Int
    let totalPhotos: Int
    let acceptedTOS: Bool
    let forHire: Bool
    let social: UserSocialInfo

    private enum CodingKeys: String, CodingKey {
        case id, updatedAt = "updated_at", username, name, firstName = "first_name", lastName = "last_name",
             portfolioURL = "portfolio_url", bio, location, links, profileImage = "profile_image", instagramUsername = "instagram_username",
             totalCollections, totalLikes, totalPhotos, acceptedTOS = "accepted_tos", forHire, social
    }
}

struct UserLinks: Codable, Hashable {
    let selfLink: URL
    let html: URL
    let photos: URL
    let likes: URL
    let portfolio: URL
    let following: URL
    let followers: URL

    private enum CodingKeys: String, CodingKey {
        case selfLink = "self", html, photos, likes, portfolio, following, followers
    }
}

struct UserProfileImage: Codable, Hashable {
    let small: URL
    let medium: URL
    let large: URL
}

// 사용자 소셜 정보를 담는 구조체
struct UserSocialInfo: Codable, Hashable {
    let instagramUsername: String
    let portfolioURL: URL?
    let twitterUsername: String?
    let paypalEmail: String?

    private enum CodingKeys: String, CodingKey {
        case instagramUsername = "instagram_username", portfolioURL = "portfolio_url", twitterUsername = "twitter_username", paypalEmail = "paypal_email"
    }
}
