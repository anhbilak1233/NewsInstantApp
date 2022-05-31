//
//  DataService.swift
//  News
//
//  Created by Trần Tiên on 5/26/22.
//  Copyright © 2022 cntt. All rights reserved.
//


class DataService {
    //khoi tao bie static cua moi doi tuong du lieu
    static var sharedataObject = DataService()
    
    //propreties
    //khai bao thuoc tinh cua mang cua categories va gan hinh anh theo cho tung loai category
    private var catagoryArr = [Category(titleimgname: "Health.png", backgroundimagename: "Health_run.png"),
    Category(titleimgname: "Science.png", backgroundimagename: "microscope.png"),
    Category(titleimgname: "Entertainment.png", backgroundimagename: "party.png"),
    Category(titleimgname: "Technology.png", backgroundimagename: "tech.png")]
    func getCategoryarray() -> [Category]
    {
        return catagoryArr
    }
}
