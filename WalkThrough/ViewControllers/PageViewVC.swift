//
//  PageViewVC.swift
//  WalkThrough
//
//  Created by Luis Genaro Arvizu Vega on 15/11/17.
//  Copyright © 2017 Luis Genaro Arvizu Vega. All rights reserved.
//

import UIKit

class PageViewVC: UIViewController {

    //MARK: VARIABLES
    var screenSize: CGSize!
    var arrViews:[UIView]!
    var currentPage: Int!
    //MARK: OUTLETS
    var vwBackgroundRed: UIView!
    var vwBackgroundGreen: UIView!
    var svContainer: UIScrollView!
    var pcViewIndicator: UIPageControl!
    
    //MARK: APP LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        
        arrViews = [UIView]()
        
        screenSize = UIScreen.main.bounds.size
        //VIEW ROJO - VIEW RED
        vwBackgroundRed = UIView(frame: CGRect(x: 0,
                                               y: 0,
                                               width: screenSize.width,
                                               height: screenSize.height))
        vwBackgroundRed.backgroundColor = UIColor.red
        arrViews.append(vwBackgroundRed)
        //VIEW VERDE - VIEW GREEN
        vwBackgroundGreen = UIView(frame: CGRect(x: 0,
                                                 y: 0,
                                                 width: screenSize.width,
                                                 height: screenSize.height))
        vwBackgroundGreen.backgroundColor = UIColor.green
        arrViews.append(vwBackgroundGreen)
        //SCROLLVIEW
        svContainer = UIScrollView(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height))
        //ESTA MULTIPLICANDO POR 2 EL TAMAÑO DEL SCROLLVIEW PARA DUPLICAR EL TAMAÑAN Y QUEPAN 2 VISTAS
        //HERE WE ARE MULTIPLYING THE SIZE OF THE SCROLLVIEW
        svContainer.contentSize = CGSize(width: screenSize.width * 2, height: screenSize.height)
        
        for viewCounter in 0...(arrViews.count-1)
        {
            //SE GUARDA EL FRAME PARA SABER DONDE SE COLOCARA LA VISTA EN EL SCROLL VIEW
            //SAVING FRAME TO SET VIEWS INTO THE SCROLLVIEW
            let frame = CGRect(x: (CGFloat(viewCounter)*screenSize.width), y: 0, width: screenSize.width, height: screenSize.height)
            //AQUI SE LE ESTA ASIGNANDO LA POSICION A CADA VIEW DEL ARRAY Y POSTERIORMENTE SE MUESTRA EN EL SCROLLVIEW
            //SET POSITION FOR EACH VIEW OF THE ARRAY, THEN WE ADDED TO THE SUBVIEW
            let page = arrViews[viewCounter]
            page.frame = frame
            self.svContainer.addSubview(page)
        }
        svContainer.isScrollEnabled = true
        svContainer.isPagingEnabled = true
        svContainer.contentMode = UIViewContentMode.scaleToFill
        svContainer.showsVerticalScrollIndicator = false
        svContainer.showsHorizontalScrollIndicator = false
        svContainer.bounces = false
        svContainer.delegate = self
        self.view.addSubview(svContainer)
        
        //PAGECONTROL
        pcViewIndicator = UIPageControl(frame: CGRect(x: (screenSize.width / 2) - 20,
                                                      y: screenSize.height - 30,
                                                      width: 40,
                                                      height: 37))
        pcViewIndicator.numberOfPages = 2
        pcViewIndicator.currentPage = 0
        pcViewIndicator.currentPageIndicatorTintColor = UIColor.black
        pcViewIndicator.tintColor = UIColor.darkGray
        pcViewIndicator.pageIndicatorTintColor = UIColor.darkGray
        pcViewIndicator.isEnabled = true
        self.view.addSubview(pcViewIndicator)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension PageViewVC : UIScrollViewDelegate
{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageWidth = self.svContainer.frame.size.width
        let page = floor((self.svContainer.contentOffset.x - pageWidth / 2) / pageWidth) + 1
        currentPage = Int(page)
        self.pcViewIndicator.currentPage = currentPage
    }
}
