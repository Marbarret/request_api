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
        self.service = NetworkService(apiManager: APIManager.endPointRequest)
        self.viewModel = ViewModel(networkService: service)
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }
    }
}
