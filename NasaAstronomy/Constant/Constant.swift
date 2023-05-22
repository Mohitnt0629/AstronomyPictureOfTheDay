//
//  Constant.swift
//  NasaAstronomy
//
//  Created by Mohit on 21/05/23.
//

import Foundation

//MARK: CORE DATA TABLE KEYS
enum AstronomyTablesKeys {
    static let copyright = "copyright"
    static let date = "date"
    static let explanation = "explanation"
    static let hdUrl = "hdurl"
    static let mediaType = "media_type"
    static let serviceVersion = "service_version"
    static let title = "title"
    static let url = "url"
    static let favourite = "favourite"
}
//MARK: - CORE DATA TABLES NAME
enum CoreDataTables {
    static let astronomyList = "AstronomyList"
}
//MARK: - CORE DATA NAME
enum CoreDataName {
    static let astronomyData = "AstronomyDataModel"
}

//MARK: - DATE FORMATE
enum DateFormate {
    static let yyyyMmmDd = "YYYY MMM dd"
    static let ddMmYyyy = "dd-MM-yyyy"
    static let yymmdd = "YYYY-MM-dd"
}
//MARK: - APP INFO
enum AppInfo {
    static let alertTitle = "NASA Astronomy"
    static let ok = "Ok"
    static let noData = "No data received"
    static let invalidUrl = "Invalid URL"
    static let noInternet = "No internet connection."
}
//MARK: - NASA API KEY
enum NasaApiKey {
    static let apiKey = "aLhA7gLRKHAPr7dYzorefb3iw7l53fSngSWZJFkP"
}
