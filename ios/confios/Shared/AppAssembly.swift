//
// Created by Ryan Harter on 2019-04-30.
// Copyright (c) 2019 Chicago Roboto. All rights reserved.
//

import Foundation
import Swinject
import common

class AppAssembly: Assembly {
    func assemble(container: Container) {
        container.register(SessionListViewControllerFactory.self) { r in
            return SessionListViewControllerFactory(sessionProvider: r.resolve(SessionProvider.self)!)
        }

        container.register(SpeakerListViewController.self) { _ in SpeakerListViewController() }
        container.register(VenueViewController.self) { _ in VenueViewController() }

        container.register([UIViewController].self, name: "MainViewControllers") { r in
            let factory = r.resolve(SessionListViewControllerFactory.self)!
            let c1 = factory.create(date: "2019-04-25")
            c1.tabBarItem = UITabBarItem(title: "Sessions", image: UIImage.init(named: "ic_schedule_black_18pt"), tag: 0)

            let c2 = r.resolve(SpeakerListViewController.self)!
            c2.tabBarItem = UITabBarItem(title: "Speakers", image: UIImage.init(named: "ic_speakers_black_18pt"), tag: 1)

            let c3 = r.resolve(VenueViewController.self)!
            c3.tabBarItem = UITabBarItem(title: "Venue", image: UIImage.init(named: "ic_venue_black_18pt"), tag: 2)

            return [c1, c2, c3]
        }

        container.register(HomeViewController.self) { r in
            return HomeViewController(viewControllers: r.resolve([UIViewController].self, name: "MainViewControllers")!)
        }
    }
}
