//
//  resquest_apiApp.swift
//  resquest_api
//
//  Created by Marcy Barreto on 15/05/24.
//

import SwiftUI

@main
struct resquest_apiApp: App {
    private var viewModel: ViewModel
    private var service: NetworkService
    
    init() {
        self.service = NetworkService(apiManager: APIManager())
        self.viewModel = ViewModel(movieService: service)
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }
    }
}
