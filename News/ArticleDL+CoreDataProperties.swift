//
//  ArticleDL+CoreDataProperties.swift
//  News
//
//  Created by Trần Tiên on 5/27/22.
//  Copyright © 2022 cntt. All rights reserved.
//

import CoreData

extension ArticleDL {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ArticleDL> {
        return NSFetchRequest<ArticleDL>(entityName: "ArticleDL")
    }

    @NSManaged public var title: String?
    @NSManaged public var content: String?
    @NSManaged public var url: String?

}
