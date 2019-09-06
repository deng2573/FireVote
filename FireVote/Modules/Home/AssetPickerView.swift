//
//  AssetSelectorView.swift
//  PointWorld_tea
//
//  Created by Deng on 2019/7/16.
//  Copyright © 2019 LPzee. All rights reserved.
//

import UIKit
import YBImageBrowser

class AssetPickerView: UIView {
  
  private var refresh: ((CGFloat, [PWPickerItem]) -> Void)?
  
  private lazy var collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    let itemW = (screenWidth - 32 - CGFloat(rowNumber - 1) * interitemSpacing) / CGFloat(rowNumber)
    layout.itemSize = CGSize(width: itemW, height: itemW)
    layout.minimumLineSpacing = lineSpacing
    layout.minimumInteritemSpacing = interitemSpacing
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.backgroundColor = .white
    collectionView.showsVerticalScrollIndicator = false
    collectionView.showsHorizontalScrollIndicator = false
    collectionView.isScrollEnabled = false
    collectionView.delegate = self
    collectionView.dataSource = self
    return collectionView
  }()
  
  private var itemList: [PWPickerItem] = []
  
  private var maxCount: Int = 9
  
  private var lineSpacing: CGFloat = 30
  
  private var interitemSpacing: CGFloat = 30
  
  private var rowNumber: Int = 3
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  init(frame: CGRect, maxCount: Int = 9, lineSpacing: CGFloat = 10, interitemSpacing: CGFloat = 30, rowNumber: Int = 3) {
    self.maxCount = maxCount
    self.lineSpacing = lineSpacing
    self.interitemSpacing = interitemSpacing
    self.rowNumber = rowNumber
    super.init(frame: frame)
    setUpView()
  }
  
  private func setUpView() {
    addSubview(collectionView)
    collectionView.snp.makeConstraints { (make) in
      make.edges.equalToSuperview()
    }
    collectionView.register(cellType: AssetPickerCell.self)
    collectionView.register(cellType: AssetAddCell.self)
    reloadView()
  }
  
  func update(list: [PWPickerItem] = [], refresh: @escaping (_ height: CGFloat, _ list: [PWPickerItem]) -> ()) {
    self.itemList = list
    self.refresh = refresh
    collectionView.reloadData()
  }
  
  private func reloadView() {
    let itemCount = itemList.count == maxCount ? itemList.count : itemList.count + 1
    let itemH = (screenWidth - 32 - CGFloat(rowNumber - 1) * interitemSpacing) / CGFloat(rowNumber)
    let rowCount = itemCount % rowNumber == 0 ? itemCount / rowNumber : itemCount / rowNumber + 1
    
    var viewH = itemH * CGFloat(rowCount) + lineSpacing * CGFloat(rowCount - 1)
    if viewH <= 0 { viewH = itemH }
    collectionView.reloadData()
    refresh?(viewH, itemList)
  }
  
  func presentPickerController() {
    let imagePickerViewController = TZImagePickerController(maxImagesCount: 9, columnNumber: 4, delegate: nil, pushPhotoPickerVc: true)
    var localAssets: [PHAsset] = []
    for info in itemList {
      if let asset = info.asset {
        localAssets.append(asset)
      }
    }
    imagePickerViewController?.selectedAssets = NSMutableArray(array: localAssets)
    imagePickerViewController?.allowTakePicture = true
    imagePickerViewController?.sortAscendingByModificationDate = true

    imagePickerViewController?.allowPickingGif = true
    imagePickerViewController?.allowPickingVideo = true
    imagePickerViewController?.allowPickingImage = true
    imagePickerViewController?.allowPickingOriginalPhoto = true
    imagePickerViewController?.allowPickingMultipleVideo = true
    imagePickerViewController?.showSelectBtn = false
    
    imagePickerViewController?.didFinishPickingPhotosHandle = { (photos, assets, isSelect) in
      self.didFinishPicking(assets: NSMutableArray(array: assets!) as! [PHAsset])
    }
    
    VCManager.currentViewController.present(imagePickerViewController!, animated: true, completion: nil)
  }
  
  func didFinishPicking(assets: [PHAsset]) {
    var newAssets: [PHAsset] = []
    var localAssets: [PHAsset] = []
    let manager = TZImageManager.default()
    
    for item in itemList {
      if let asset = item.asset {
       localAssets.append(asset)
      }
    }
    
    for asset in assets {
      if !localAssets.contains(asset) {
        newAssets.append(asset)
      }
    }
  
    
    for (index, asset) in newAssets.enumerated() {
      
      let newItem = PWPickerItem()
      newItem.asset = asset
      let assetType = manager?.getAssetType(asset)
      
      switch assetType {
      case TZAssetModelMediaTypePhoto, TZAssetModelMediaTypePhotoGif:
         PHImageManager.default().requestImageData(for: asset, options: nil) { data, file, orientation, info in
          if let data = data {
            if assetType == TZAssetModelMediaTypePhoto {
              
            } else {
              newItem.file = PWFileInfo(type: "GIF", data: data)
            }
          }
          self.itemList.append(newItem)
          if index == newAssets.count - 1 {
            DispatchQueue.main.async(execute: {
              self.reloadView()
            })
          }
        }
        
      case TZAssetModelMediaTypeVideo:
        PHImageManager.default().requestAVAsset(forVideo: asset, options: nil) { (asset, mix, info) in
          do {
            let avAsset = asset as? AVURLAsset
            let data = try Data(contentsOf: avAsset!.url)
            newItem.file = PWFileInfo(type: avAsset!.url.pathExtension, data: data)
            
            self.itemList.append(newItem)
            if index == newAssets.count - 1 {
              DispatchQueue.main.async(execute: {
                self.reloadView()
              })
            }
          } catch  {
          }
        }
      default: break
        
      }
    }
  }
  
}

extension AssetPickerView: UICollectionViewDelegate {
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let cell = collectionView.cellForItem(at: indexPath)
    if let _ = cell as? AssetAddCell {
      presentPickerController()
      return
    }
  }
}

extension AssetPickerView: UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return itemList.count == maxCount ? itemList.count : itemList.count + 1
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    if indexPath.row == itemList.count {
      let cell: AssetAddCell = collectionView.dequeueReusableCell(for: indexPath, cellType: AssetAddCell.self)
      return cell
    }
    let info = itemList[indexPath.row]
    let cell: AssetPickerCell = collectionView.dequeueReusableCell(for: indexPath, cellType: AssetPickerCell.self)
    cell.deleteAction = {
      self.itemList.remove(at: indexPath.row)
      self.reloadView()
    }
    cell.update(info: info)
    return cell
  }
}
