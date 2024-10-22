//
//  Onboarding.swift
//  MoonXClone
//
//  Created by Fatih Özen on 21.10.2024.
//

import UIKit
import NeonSDK

final class OnboardingVC: UIViewController {
    
    private var pages: [UIViewController] = []
    
    private var nextButton: UIButton!
    private var pageControl: NeonPageControlV2!
    private var pageViewController: UIPageViewController!
    
    private var currentPage = 0 {
        didSet {
            if currentPage == pages.count - 1 {
                nextButton.setTitle("Finish", for: .normal)
            } else {
                nextButton.setTitle("Next", for: .normal)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        setupPages()
        setupPageViewController()
        setupNextButton()
        setupPageControl()
        
    }
    
    private func setupPages() {
        let page1 = OnboardingPageNoInteraction()
        page1.titleText = "Welcome"
        page1.descriptionText = "Discover new features and learn how to use the app effectively."
        page1.imageName = ImageNames.fullMoon.rawValue
        
        let page2 = OnboardingPageWithInteraction()
        page2.titleText = "Stay Connected"
        page2.descriptionText = "Stay in touch with friends and family through our easy-to-use messaging feature."
        page2.imageName = ImageNames.crescentMoon.rawValue
        
        pages = [page1, page2]
    }
    
    private func setupPageViewController() {
        pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
        
        pageViewController.dataSource = self
        pageViewController.delegate = self
        
        if let firstPage = pages.first {
            pageViewController.setViewControllers([firstPage], direction: .forward, animated: true, completion: nil)
        }
        
        addChild(pageViewController)
        view.addSubview(pageViewController.view)
        pageViewController.didMove(toParent: self)
        
        pageViewController.view.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    private func setupNextButton() {
        nextButton = UIButton(type: .system)
        nextButton.setTitleColor(.white, for: .normal)
        nextButton.backgroundColor = UIColor(hex: "#535FD8")
        nextButton.layer.cornerRadius = 20
        nextButton.clipsToBounds = true
        nextButton.setTitle("Next", for: .normal)
        nextButton.titleLabel?.font = Font.custom(size: 18, fontWeight: .Bold)
        
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        
        pageViewController.view.addSubview(nextButton)
        
        nextButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-40)
            make.width.equalToSuperview().offset(-60)
            make.height.equalTo(50)
        }
    }
    
    private func setupPageControl() {
        pageControl = NeonPageControlV2()
        pageControl.numberOfPages = 2
        pageControl.currentPageTintColor = UIColor(hex: "#535FD8")
        pageControl.tintColor = UIColor(hex: "#535FD8")
        pageControl.radius = 5
        pageControl.padding = 8
        pageControl.delegate = self
        pageControl.enableTouchEvents = true
        
        pageViewController.view.addSubview(pageControl)
        
        pageControl.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(nextButton.snp.top).offset(-20)
            make.width.equalToSuperview()
            make.height.equalTo(50)
        }
    }
    
    
    // MARK: - objc funcs
    
    @objc
    private func nextButtonTapped() {
        let nextPage = currentPage + 1
        if nextPage < pages.count {
            let nextViewController = pages[nextPage]
            pageViewController.setViewControllers([nextViewController], direction: .forward, animated: true, completion: nil)
            currentPage = nextPage
            pageControl.set(progress: currentPage, animated: true)
        } else {
            //            Neon.onboardingCompleted()
            
            let paywallVC = PaywallVC()
            paywallVC.modalPresentationStyle = .fullScreen
            present(paywallVC, animated: false, completion: nil)
        }
    }
    
}

// MARK: - extension for UIPageViewController

extension OnboardingVC: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController), index > 0 else {
            return nil
        }
        return pages[index - 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController), index < pages.count - 1 else {
            return nil
        }
        return pages[index + 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard let viewControllerIndex = pageViewController.viewControllers?.first.flatMap({ pages.firstIndex(of: $0) }) else { return }
        
        currentPage = viewControllerIndex
        pageControl.set(progress: currentPage, animated: true)
    }
    
}

// MARK: - extension for NeonPageControl

extension OnboardingVC: NeonBasePageControlDelegate {
    func didTouch(pager: NeonSDK.NeonBasePageControl, index: Int) {
        pageControl.set(progress: index, animated: true)
        
        let nextViewController = pages[index]
        pageViewController.setViewControllers([nextViewController], direction: index < currentPage ? .reverse : .forward, animated: true, completion: nil)
        currentPage = index
        pageControl.set(progress: currentPage, animated: true)
    }
}


