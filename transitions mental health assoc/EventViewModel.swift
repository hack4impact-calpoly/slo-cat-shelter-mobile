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
    
    //@State var switchpage = false
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
    var body: some View {
            VStack (alignment: .center){
                if eviewmodel.eventloading {
                    Text("Loading ...")
                } else {
                    if (eviewmodel.events.count > 0) {
                        List() {
                            ForEach (eviewmodel.events.sorted(by: { $0.date < $1.date }), id: \.self) { event in
                                EventRow(event: event)
                            }
                        }
                    }
                    else {
                        VStack(alignment: .center) {
                            Text("You don't have any events scheduled. \n Schedule one below:").multilineTextAlignment(.center)
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
                    .foregroundColor(Color(red: 0.7215686, green: 0.917647, blue: 0.6888888))
                    .lineLimit(nil)
                Spacer()
            }
            HStack {
                Group {
                    Text("Time: \(event.time)")
                    .foregroundColor(.black)
                    .lineLimit(nil)
                    Spacer()
                    Text("Date: \(event.date)")
                        .foregroundColor(.black)
                        .lineLimit(nil)
                    Text("Cat: \(event.name)")
                    .foregroundColor(.black)
                    .lineLimit(nil)
                Spacer()
                }
            }
            HStack {
                Text("Type: \(event.eventType)")
                    .foregroundColor(.black)
                    .lineLimit(nil)
                Spacer()
            }
            HStack {
                Text("Notes: \(event.notes!)")
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
            }
        }
    }


