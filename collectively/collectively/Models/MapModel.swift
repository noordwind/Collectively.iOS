//
//  MapModel.swift
//  
//
//  Created by Łukasz Bożek on 03/10/2017.
//

import Foundation
import ObjectMapper

class MapModel: Mappable {
    
    var location: LocationModel!
    var group: RemarkGroup?
    var desc: String!
    
    func mapping(map: Map) {
        
    }
    
    required init?(map: Map) {
        location <- map["location"]
        desc <- map["description"]
        group <- map["group"]
    }
//    author =         {
//        name = puchacz;
//        userId = 8502d3b3a1e1418a8ce20fb8f454a501;
//    };
//    category =         {
//        id = "afdba6e4-15ec-4c6f-bf07-b6cfc40415f4";
//        name = issue;
//    };
//    commentsCount = 0;
//    createdAt = "2017-10-03T18:35:42.565Z";
//    description = "Wraz z oddaniem do u\U017cytku ICE powsta\U0142a zatoka postojowa w rejonie ul. Wygranej. Jednak pomimo istniej\U0105cych zakaz&#243;w i interwencji Stra\U017cy Miejskiej, kierowcy dalej parkuj\U0105 zar&#243;wno na chodnikach jak i na ziele\U0144cach. Prosz\U0119 o zrekultywowanie terenu i zabezpieczenie go przed nieprawid\U0142owym parkowaniem (np. drewniane s\U0142upki lub niski \U017cywop\U0142ot jak par\U0119 metr&#243;w obok przy ul. Wierzbowej lub Bu\U0142haka).";
//    distance = "<null>";
//    group =         {
//        criteria = "<null>";
//        id = "46eb46df-329a-46e3-bdf3-4b433ec8e3af";
//        memberCriteria = "<null>";
//        memberRole = "<null>";
//        members = "<null>";
//        name = "ZZM Krak\U00f3w";
//    };
//    id = "04579217-c8cc-482d-b979-463377351a9d";
//    location =         {
//        address = "Wygrana 6, 30-311 Krak\U00f3w, Poland";
//        coordinates =             (
//        "19.93089020000002",
//        "50.046785"
//        );
//        latitude = "50.046785";
//        longitude = "19.93089020000002";
//        type = Point;
//    };
//    negativeVotesCount = 0;
//    offering = "<null>";
//    offeringProposalsCount = 0;
//    participantsCount = 0;
//    photo =         {
//        big = "https://becollectively.s3.eu-central-1.amazonaws.com/remark_04579217c8cc482db979463377351a9d_636426525516140039.jpg";
//        medium = "https://becollectively.s3.eu-central-1.amazonaws.com/600x600/remark_04579217c8cc482db979463377351a9d_636426525516140039.jpg";
//        small = "https://becollectively.s3.eu-central-1.amazonaws.com/200x200/remark_04579217c8cc482db979463377351a9d_636426525516140039.jpg";
//    };
//    positiveVotesCount = 0;
//    rating = 0;
//    reportsCount = 0;
//    resolved = 0;
//    smallPhotoUrl = "https://becollectively.s3.eu-central-1.amazonaws.com/200x200/remark_04579217c8cc482db979463377351a9d_636426525516140039.jpg";
//    state =         {
//    createdAt = "2017-10-03T18:35:42.565Z";
//    description = "Wraz z oddaniem do u\U017cytku ICE powsta\U0142a zatoka postojowa w rejonie ul. Wygranej. Jednak pomimo istniej\U0105cych zakaz&#243;w i interwencji Stra\U017cy Miejskiej, kierowcy dalej parkuj\U0105 zar&#243;wno na chodnikach jak i na ziele\U0144cach. Prosz\U0119 o zrekultywowanie terenu i zabezpieczenie go przed nieprawid\U0142owym parkowaniem (np. drewniane s\U0142upki lub niski \U017cywop\U0142ot jak par\U0119 metr&#243;w obok przy ul. Wierzbowej lub Bu\U0142haka).";
//    id = "ae13a0b0-582c-4a16-b0da-cc2949cf4512";
//    location =             {
//        address = "Wygrana 6, 30-311 Krak\U00f3w, Poland";
//        coordinates =                 (
//        "19.93089020000002",
//        "50.046785"
//    );
//    latitude = "50.046785";
//    longitude = "19.93089020000002";
//    type = Point;
//    };
//    photo = "<null>";
//    removed = 0;
//    reportsCount = 0;
//    state = new;
//    user =             {
//        name = puchacz;
//        userId = 8502d3b3a1e1418a8ce20fb8f454a501;
//    };
//    };
//    status = "<null>";
//    updatedAt = "2017-10-03T18:35:55.115Z";
//    },
}
