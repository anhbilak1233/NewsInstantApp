//
//  NetworkService.swift
//  News
//
//  Created by Trần Tiên on 5/26/22.
//  Copyright © 2022 cntt. All rights reserved.
//

import Foundation

class NetworkService{
  //Properties
    
    
  static let  sharedobj = NetworkService()
  let session = URLSession.shared
  //lay du lieu va khai bao get API theo danh muc
    //data API duoc lay tu trang newsAPI.org + category su dung postman de truy cap du lieu chi tiet
    private let HEALTH_URL = "https://newsapi.org/v2/top-headlines?country=in&category=health&apiKey=f70120c8fa7c48b58328c92a0aecb0fb"
    private let HEADLINES_URL = "https://newsapi.org/v2/top-headlines?country=in&apiKey=f70120c8fa7c48b58328c92a0aecb0fb"
    private let TECH_URL = "http://newsapi.org/v2/top-headlines?country=in&category=technology&apiKey=f70120c8fa7c48b58328c92a0aecb0fb"
    private let ENTERTAINMENT_URL = "http://newsapi.org/v2/top-headlines?country=in&category=entertainment&apiKey=f70120c8fa7c48b58328c92a0aecb0fb"
     private let SCIENCE_URL = "http://newsapi.org/v2/top-headlines?country=in&category=science&apiKey=f70120c8fa7c48b58328c92a0aecb0fb"
     //
  
    

 // tien hanh xu ly cac API Json  voi cac truong du lieu duoc dua vao nhu
    // Headlines, Technology, Entertainment, Science, Health
    //HeadLines
  //Ham xu ly json trang chu
  public func getHeadLines(onSuccess: @escaping ([Articles]) -> Void)
  {
      let datatask = session.dataTask(with: URL(string: HEADLINES_URL)!, completionHandler: { (data, response, error) in
          if response == nil
          {
              return
          }
          DispatchQueue.main.async {
              do
              {
                  let decoder = try JSONDecoder().decode(Welcome.self, from: data!)
                  onSuccess(decoder.articles!)
              }
              catch
              {
                  print(error.localizedDescription)
              }
          }
      })
      datatask.resume()
  }
  func getHealthNews(onSuccess: @escaping([Articles]) -> Void)
  {
      let datatask = session.dataTask(with: URL(string: HEALTH_URL)!, completionHandler: { (data, response, error) in
          if response == nil
          {
              return
          }
          DispatchQueue.main.async {
              do
              {
                  let decoder = try JSONDecoder().decode(Welcome.self, from: data!)
                  onSuccess(decoder.articles!)
              }
              
              catch
              {
                  print(error.localizedDescription)
              }
          }
      })
      datatask.resume()
  }
  func getTechNews(onsucess: @escaping([Articles]) ->Void)
  {
      let dataTask = session.dataTask(with: URL(string: TECH_URL)!) { (data, response, error) in
          if response == nil
          {
              
              return
          }
          do
          {
              let decoder = try  JSONDecoder().decode(Welcome.self, from: data!)
              onsucess(decoder.articles!)
          }
          catch
          {
              print(error.localizedDescription)
          }
      }
      dataTask.resume()
  }
  func getEntertainmentNews(onSuccess: @escaping([Articles]) -> Void)
  {
      let dataTask = session.dataTask(with: URL(string: ENTERTAINMENT_URL)!) { (data, response, error) in
          if response == nil
          {
              return
          }
          DispatchQueue.main.async {
              do
              {
              let decoder = try JSONDecoder().decode(Welcome.self, from: data!)
                  onSuccess(decoder.articles!)
              }
              catch
              {
                  print(error.localizedDescription)
              }
          }
      }
      dataTask.resume()
  }
  func getScienceNews(onSuccess: @escaping([Articles]) -> Void)
  {
      let dataTask = session.dataTask(with: URL(string: SCIENCE_URL)!) { (data, response, error) in
          if response == nil
          {
              return
          }
          DispatchQueue.main.async {
              do
              {
                  let decoder = try JSONDecoder().decode(Welcome.self, from: data!)
                  onSuccess(decoder.articles!)
              }
              
              catch
              {
                  print(error.localizedDescription)
              }

          }
      }
      dataTask.resume()
  }
}
