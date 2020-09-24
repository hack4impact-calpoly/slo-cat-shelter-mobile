//
//  EventViewModel.swift
//  Cal Poly Cat Program App
//
//  Created by Jillian Quinn on 7/12/20.
//  Copyright © 2020 Hack4Impact. All rights reserved.
//

import Foundation
import Combine
import SwiftUI
import CoreData
import Alamofire
import UIKit
import SwiftUI

class EventViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBSegueAction func embedSwift(_ coder: NSCoder) -> UIViewController? {
        return UIHostingController(coder: coder, rootView: EventList())
    }
    
}


class EventViewModel: ObservableObject {
    @Published var events : Events = []
    @Published var eventloading = false
    
    
    
    
    //    let refresh = "refresh"
    let eservice: EventServiceProtocol
    init(eservice: EventServiceProtocol = EventNetworkManager()) {
        self.eservice = eservice
        
    }
    
    func loadData() {
        self.eventloading = true
        eservice.fetchEvents { events in
            self.eventloading = false
            guard let events = events else { return }
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let date_now = dateFormatter.string(from: Date())
            self.events = events.filter{ $0.date >= date_now }
        }
    }
}

struct EventList : View {
    @ObservedObject var eviewmodel = EventViewModel()
    
    @ObservedObject var viewmodel = CatViewModel()
    
    @State var refreshnow: String = "Refresh"
    
    func timeToRefresh()
    {
        if (refreshnow == "END")
        {
            refreshnow = "START"
        }
        else{
            refreshnow = "END"
        }
        self.eviewmodel.loadData()
        self.viewmodel.loadData()
    }
    
    var body: some View {
        
        VStack (alignment: .center){
            HStack(alignment: .center) {
                Spacer()
                Button(action:timeToRefresh) {
                    Text("Refresh")
                        .font(.custom("Euphemia UCAS", size: 14.0))
                        .padding(6)
                        .background(Color(red: 0.7215686, green: 0.917647, blue: 0.6888888))
                        .foregroundColor(Color.black)
                }
                .cornerRadius(5)
                .background(Color(red: 0.7215686, green: 0.917647, blue: 0.6888888))
            }.padding(.top, -15)
                .padding(.bottom, -5)
            if eviewmodel.eventloading {
                Text("Loading ...").font(.custom("Euphemia UCAS", size: 20.0))
            } else {
                if (eviewmodel.events.count > 0) {
                    List() {
                        ForEach (eviewmodel.events.sorted(by: { $0.date < $1.date }), id: \.self) { event in
                            EventRow(event: event)
                        }
                        Spacer()
                    }
                    
                }
                else {
                    VStack(alignment: .center) {
                        Text("You don't have any events scheduled. \n Schedule one below:").multilineTextAlignment(.center).font(.custom("Euphemia UCAS", size: 14.0))
                    }
                }
            }
        }
        .onAppear {
            self.eviewmodel.loadData()
        }
        
        
    }
}

struct EventRow : View {
    var event: Event
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Text(event.title)
                    .foregroundColor(Color(red: 0.53725, green: 0.7725490, blue: 0.46666666666))
                    .lineLimit(nil)
                    
                    .font(.custom("Euphemia UCAS", size: 14.0))
                Spacer()
            }
            HStack {
                Group {
                    Text("Time: \(event.time)")
                        .font(.custom("Euphemia UCAS", size: 14.0))
                        .foregroundColor(.black)
                        .lineLimit(nil)
                    Spacer()
                    Text("Date: \(event.date)")
                        .font(.custom("Euphemia UCAS", size: 14.0))
                        .foregroundColor(.black)
                        .lineLimit(nil)
                    //                Spacer()
                }
            }
            HStack {
                Text("Cat: \(event.name ?? "")")
                    .foregroundColor(.black)
                    .lineLimit(nil)
                    .font(.custom("Euphemia UCAS", size: 14.0))
                Spacer()
                Text("Type: \(event.eventType)")
                    .font(.custom("Euphemia UCAS", size: 14.0))
                    .foregroundColor(.black)
                    .lineLimit(nil)
                //                Spacer()
            }
            HStack {
                Text("Notes: \(event.notes!)")
                    .font(.custom("Euphemia UCAS", size: 14.0))
                    .foregroundColor(.gray)
                    .lineLimit(nil)
                Spacer()
            }
        }
    }
}

protocol EventServiceProtocol {
    func fetchEvents(completion: @escaping ([Event]?) -> Void)
}

class EventNetworkManager : EventServiceProtocol {
    //    @ObservedObject var eviewmodel = EventViewModel()
    func fetchEvents(completion: @escaping ([Event]?) -> Void) {
        eloadDataByAlamofire(completion)
    }
    
    private func eloadDataByAlamofire(_ completion: @escaping ([Event]?) -> Void) {
        
        let headers : HTTPHeaders = [
            "Authorization": "token \(User.current.token)"
        ]
        AF.request("https://cpcp-cats.herokuapp.com/api/events/",method: .get, headers: headers).responseJSON{ response in
            guard let data = response.data else {
                completion(nil)
                return
            }
            // var datadict = ["results": data]
            guard let events = try? JSONDecoder().decode(Events.self, from: data) else {
                completion(nil)
                return
            }
            DispatchQueue.main.async {
                completion(events)
            }
            //                self.eviewmodel.refreshPage = true
        }
    }
}


