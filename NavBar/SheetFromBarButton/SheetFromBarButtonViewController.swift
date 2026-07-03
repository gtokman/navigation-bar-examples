/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
Demonstrates presenting a sheet with a zoom transition from a bar button item.
*/

import UIKit

class SheetFromBarButtonViewController: UIViewController {

    private var infoBarButton: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()

        infoBarButton = UIBarButtonItem(image: UIImage(systemName: "info"),
                                        primaryAction: UIAction { [unowned self] _ in
            presentInfoSheet()
        })
        navigationItem.rightBarButtonItem = infoBarButton
    }

    func presentInfoSheet() {
        let infoViewController = SheetFromBarButtonInfoViewController()
        let navigationController = UINavigationController(rootViewController: infoViewController)

        /** A zoom transition with a bar button item source morphs the bar button
            into the sheet during presentation, and back into the button on dismissal.
        */
        navigationController.preferredTransition = .zoom(sourceBarButtonItemProvider: { [weak self] _ in
            self?.infoBarButton
        })

        present(navigationController, animated: true)
    }
}

/// The content of the presented sheet.
class SheetFromBarButtonInfoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        title = NSLocalizedString("Info", comment: "")
        view.backgroundColor = .systemBackground

        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"),
                                                            primaryAction: UIAction { [unowned self] _ in
            dismiss(animated: true)
        })

        let label = UILabel()
        label.text = NSLocalizedString("This sheet zooms out of the info bar button item.", comment: "")
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            label.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor)
        ])
    }
}
