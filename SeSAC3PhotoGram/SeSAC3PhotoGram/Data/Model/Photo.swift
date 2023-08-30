//
//  Photo.swift
//  SeSAC3PhotoGram
//
//  Created by 김규철 on 2023/08/31.
//

import Foundation

struct PhotoURLPage: Decodable {
    let total: Int?
    let totalPages: Int?
    let results: [SearchResult]?

    enum CodingKeys: String, CodingKey {
        case total
        case totalPages = "total_pages"
        case results
    }
}

struct SearchResult: Decodable {
    let id, slug: String?
    let createdAt, updatedAt: String?
    let promotedAt: String?
    let width, height: Int?
    let color, blurHash: String?
    let description: String?
    let altDescription: String?
    let urls: Urls?
    let links: ResultLinks?
    let likes: Int?
    let likedByUser: Bool?
    let user: User?
    let tags: [Tag]?

    enum CodingKeys: String, CodingKey {
        case id, slug
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case promotedAt = "promoted_at"
        case width, height, color
        case blurHash = "blur_hash"
        case description
        case altDescription = "alt_description"
        case urls, links, likes
        case likedByUser = "liked_by_user"
        case user, tags
    }
}

struct ResultLinks: Decodable {
    let linksSelf, html, download, downloadLocation: String?

    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
        case html, download
        case downloadLocation = "download_location"
    }
}

// MARK: - Tag
struct Tag: Decodable {
    let title: String?
    let source: Source?
}

// MARK: - Source
struct Source: Decodable {
    let ancestry: Ancestry?
    let title, subtitle, description, metaTitle: String?
    let metaDescription: String?
    let coverPhoto: CoverPhoto?

    enum CodingKeys: String, CodingKey {
        case ancestry, title, subtitle, description
        case metaTitle = "meta_title"
        case metaDescription = "meta_description"
        case coverPhoto = "cover_photo"
    }
}

// MARK: - Ancestry
struct Ancestry: Decodable {
    let type, category, subcategory: Category?
}

// MARK: - Category
struct Category: Decodable {
    let slug, prettySlug: String?

    enum CodingKeys: String, CodingKey {
        case slug
        case prettySlug = "pretty_slug"
    }
}

// MARK: - CoverPhoto
struct CoverPhoto: Decodable {
    let id, slug: String?
    let promotedAt: String?
    let width, height: Int?
    let color, blurHash: String?
    let description: String?
    let altDescription: String?
    let urls: Urls?
    let links: ResultLinks?
    let likes: Int?
    let likedByUser: Bool?
    let topicSubmissions: CoverPhotoTopicSubmissions?
    let premium, plus: Bool?
    let user: User?

    enum CodingKeys: String, CodingKey {
        case id, slug
        case promotedAt = "promoted_at"
        case width, height, color
        case blurHash = "blur_hash"
        case description
        case altDescription = "alt_description"
        case urls, links, likes
        case likedByUser = "liked_by_user"
        case topicSubmissions = "topic_submissions"
        case premium, plus, user
    }
}

// MARK: - CoverPhotoTopicSubmissions
struct CoverPhotoTopicSubmissions: Decodable {
    let colorOfWater, texturesPatterns, spirituality, fashionBeauty: ColorOfWater?
    let experimental, nature, artsCulture, wallpapers: ColorOfWater?

    enum CodingKeys: String, CodingKey {
        case colorOfWater = "color-of-water"
        case texturesPatterns = "textures-patterns"
        case spirituality
        case fashionBeauty = "fashion-beauty"
        case experimental, nature
        case artsCulture = "arts-culture"
        case wallpapers
    }
}

// MARK: - ColorOfWater
struct ColorOfWater: Decodable {
    let status: Status?

    enum CodingKeys: String, CodingKey {
        case status
    }
}

enum Status: String, Decodable {
    case approved = "approved"
}

// MARK: - Urls
struct Urls: Decodable {
    let raw, full, regular, small: String?
    let thumb, smallS3: String?

    enum CodingKeys: String, CodingKey {
        case raw, full, regular, small, thumb
        case smallS3 = "small_s3"
    }
}

// MARK: - User
struct User: Decodable {
    let id: String?
    let updatedAt: String?
    let username, name, firstName: String?
    let lastName, twitterUsername: String?
    let portfolioURL: String?
    let bio, location: String?
    let links: UserLinks?
    let profileImage: ProfileImage?
    let instagramUsername: String?
    let totalCollections, totalLikes, totalPhotos: Int?
    let acceptedTos, forHire: Bool?

    enum CodingKeys: String, CodingKey {
        case id
        case updatedAt = "updated_at"
        case username, name
        case firstName = "first_name"
        case lastName = "last_name"
        case twitterUsername = "twitter_username"
        case portfolioURL = "portfolio_url"
        case bio, location, links
        case profileImage = "profile_image"
        case instagramUsername = "instagram_username"
        case totalCollections = "total_collections"
        case totalLikes = "total_likes"
        case totalPhotos = "total_photos"
        case acceptedTos = "accepted_tos"
        case forHire = "for_hire"
    }
}

// MARK: - UserLinks
struct UserLinks: Decodable {
    let linksSelf, html, photos, likes: String?
    let portfolio, following, followers: String?

    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
        case html, photos, likes, portfolio, following, followers
    }
}

// MARK: - ProfileImage
struct ProfileImage: Decodable {
    let small, medium, large: String?
}
