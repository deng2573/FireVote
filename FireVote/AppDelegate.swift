//
//  AppDelegate.swift
//  AirOcr
//
//  Created by Deng on 2019/8/13.
//  Copyright © 2019 Deng. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    window = UIWindow(frame: UIScreen.main.bounds)
    window?.backgroundColor = UIColor.themeColor
    window?.makeKeyAndVisible()
    setupJPush(launchOptions: launchOptions)
    setupIQKeyboard()
    setupVoteList()
    setupMainViewController()
    return true
  }
  
  func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
    //注册 DeviceToken
    JPUSHService.registerDeviceToken(deviceToken)
  }
  
  func applicationDidBecomeActive(_ application: UIApplication) {
    JPUSHService.resetBadge()
    application.applicationIconBadgeNumber = 0
  }
  
  func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
    JPUSHService.handleRemoteNotification(userInfo)
    completionHandler(UIBackgroundFetchResult.newData)
  }
}

extension AppDelegate {
  
  private func setupVoteList() {
    if VoteManager.readVoteListList().count > 0 {
      return
    }
    let voteListInfo = VoteListInfo()
    voteListInfo.avatar = "avatar1"
    voteListInfo.nickname = "Serena"
    
    let voteInfo = VoteInfo()
    voteInfo.title = "Pregunta a todos cuál es tu fiesta favorita, jajaja"
    voteInfo.content = "Tengo unas maravillosas vacaciones en mi corazón.Qué vacaciones tan maravillosas.\n Trajo alegría sin fin a nuestra infancia! !\n¿Qué hay en tu corazón?"
    voteInfo.endTime = "04-29 12:01"
    voteInfo.cover = "cover1"
    
    let option1 = VoteOptionItem()
    option1.content = "Año Nuevo"
    let option2 = VoteOptionItem()
    option2.content = "Día de Reyes"
    let option3 = VoteOptionItem()
    option3.content = "Día de la Pascua"
    let option4 = VoteOptionItem()
    option4.content = "Día del trabajo"
    voteInfo.voteOptions = [option1, option2, option3, option4]
    voteListInfo.vote = voteInfo
    
    VoteManager.writeVoteInfo(voteInfo: voteListInfo)
    
  }
  
  private func setupMainViewController() {
    window?.rootViewController = TabBarController()
  }
  
  private func setupJPush(launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
    JPUSHService.setup(withOption: launchOptions, appKey: AppKey.JPushAPP.key, channel: "App Store", apsForProduction: !AppConfig.isDebug)
    let entity = JPUSHRegisterEntity()
    entity.types = 1 << 0 | 1 << 1 | 1 << 2
    JPUSHService.register(forRemoteNotificationConfig: entity, delegate: self)
  }
  
  private func setupIQKeyboard() {
    IQKeyboardManager.shared.enable = true
  }
}

extension AppDelegate: JPUSHRegisterDelegate {
  @available(iOS 10.0, *)
  func jpushNotificationCenter(_ center: UNUserNotificationCenter!, openSettingsFor notification: UNNotification?) {
    
  }
  
  @available(iOS 10.0, *)
  func jpushNotificationCenter(_ center: UNUserNotificationCenter!, willPresent notification: UNNotification!, withCompletionHandler completionHandler: ((Int) -> Void)!) {
    let userInfo = notification.request.content.userInfo
    if notification.request.trigger is UNPushNotificationTrigger {
      JPUSHService.handleRemoteNotification(userInfo)
    }else {
      //本地通知
    }
    print("=======\(userInfo)")
    
    completionHandler(Int(UNNotificationPresentationOptions.alert.rawValue))
  }
  
  @available(iOS 10.0, *)
  func jpushNotificationCenter(_ center: UNUserNotificationCenter!, didReceive response: UNNotificationResponse!, withCompletionHandler completionHandler: (() -> Void)!) {
    let userInfo = response.notification.request.content.userInfo
    if response.notification.request.trigger is UNPushNotificationTrigger {
      JPUSHService.handleRemoteNotification(userInfo)
    }else {
      //本地通知
    }
    //处理通知 跳到指定界面等等
    print("=======\(userInfo)")
    completionHandler()
  }
}
