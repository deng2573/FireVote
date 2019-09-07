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
//    setupJPush(launchOptions: launchOptions)
    setupIQKeyboard()
    setupVoteList()
    setupMainViewController()
    return true
  }
  
//  func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
//    //注册 DeviceToken
//    JPUSHService.registerDeviceToken(deviceToken)
//  }
  
//  func applicationDidBecomeActive(_ application: UIApplication) {
//    JPUSHService.resetBadge()
//    application.applicationIconBadgeNumber = 0
//  }
  
//  func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
//    JPUSHService.handleRemoteNotification(userInfo)
//    completionHandler(UIBackgroundFetchResult.newData)
//  }
}

extension AppDelegate {
  
  private func setupVoteList() {
    if VoteManager.readVoteListList().count > 0 {
      return
    }
    
    func addVoteItem1() -> VoteListInfo {
      let voteListInfo = VoteListInfo()
      voteListInfo.avatar = "avatar1"
      voteListInfo.nickname = "Serena"
      
      let voteInfo = VoteInfo()
      voteInfo.title = "Pregunta a todos cuál es tu fiesta favorita, jajaja"
      voteInfo.content = "Tengo unas maravillosas vacaciones en mi corazón.Qué vacaciones tan maravillosas.\n Trajo alegría sin fin a nuestra infancia! !\n¿Qué hay en tu corazón?"
      voteInfo.endTime = "08-01 12:01"
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
      return voteListInfo
    }
    
    func addVoteItem2() -> VoteListInfo {
      let voteListInfo = VoteListInfo()
      voteListInfo.avatar = "avatar2"
      voteListInfo.nickname = "Carmen"
      
      let voteInfo = VoteInfo()
      voteInfo.title = "Habla sobre cómo es el paisaje"
      voteInfo.content = "Como el paisaje de las hojas de otoño, eres mi más bella.\nUna persona siempre tiene que tomar un camino extraño, mirar paisajes extraños, escuchar canciones extrañas, y al final encontrará cosas que se han olvidado antes de que se olviden los pensamientos."
      voteInfo.endTime = "08-29 12:01"
      voteInfo.cover = "cover2"
      
      let option1 = VoteOptionItem()
      option1.content = "Puesta de sol"
      let option2 = VoteOptionItem()
      option2.content = "Paisaje natural"
      let option3 = VoteOptionItem()
      option3.content = "Oyama"
      let option4 = VoteOptionItem()
      option4.content = "Lugar historico"
      voteInfo.voteOptions = [option1, option2, option3, option4]
      voteListInfo.vote = voteInfo
      return voteListInfo
    }
    
    func addVoteItem3() -> VoteListInfo {
      let voteListInfo = VoteListInfo()
      voteListInfo.avatar = "avatar3"
      voteListInfo.nickname = "Alba"
      
      let voteInfo = VoteInfo()
      voteInfo.title = "Impresionado por lo que pinta"
      voteInfo.content = "Miró fijamente el pincel en la mano y bajó la cabeza ligeramente, mirando el trabajo inacabado, en silencio, y de repente, sus ojos se iluminaron, y el bolígrafo se fue como si estuviera volando, observando su preocupación. A medida que el pincel oscila continuamente, las líneas negras cambian de oscuro a grueso, y la pintura es instantáneamente tridimensional, cobra vida."
      voteInfo.endTime = "08-29 12:30"
      voteInfo.cover = "cover3"
      
      let option1 = VoteOptionItem()
      option1.content = "LAS MENINAS(1656),VELAZQUEZ"
      let option2 = VoteOptionItem()
      option2.content = "AUTORRETRATO BLANDO CON BEICON FRITO(1941), DALÍ"
      let option3 = VoteOptionItem()
      option3.content = "PASEO A ORILLAS DEL MAR (1909), SOROLLA"
      let option4 = VoteOptionItem()
      option4.content = "GUERNICA(1937),PICASSO"
      voteInfo.voteOptions = [option1, option2, option3, option4]
      voteListInfo.vote = voteInfo
      return voteListInfo
    }
    
    func addVoteItem4() -> VoteListInfo {
      let voteListInfo = VoteListInfo()
      voteListInfo.avatar = "avatar4"
      voteListInfo.nickname = "Bella"
      
      let voteInfo = VoteInfo()
      voteInfo.title = "¿Qué deporte te mantiene feliz?"
      voteInfo.content = "Firme, persistente, resistencia y esperanza, ¡se condensa en la pista blanca extendida! ¡La fuerza, la fe, el trabajo duro y la lucha, se iluminan gradualmente en la línea final! La fuerte voz de los tiempos suena a tus pies."
      voteInfo.endTime = "08-20 1:30"
      voteInfo.cover = "cover4"
      
      let option1 = VoteOptionItem()
      option1.content = "Fútbol"
      let option2 = VoteOptionItem()
      option2.content = "Baloncesto"
      let option3 = VoteOptionItem()
      option3.content = "Esgrima"
      let option4 = VoteOptionItem()
      option4.content = "La calabaza"
      voteInfo.voteOptions = [option1, option2, option3, option4]
      voteListInfo.vote = voteInfo
      return voteListInfo
    }
    
    func addVoteItem5() -> VoteListInfo {
      let voteListInfo = VoteListInfo()
      voteListInfo.avatar = "avatar5"
      voteListInfo.nickname = "Olivia"
      
      let voteInfo = VoteInfo()
      voteInfo.title = "Esa frase te da sentimientos diferentes"
      voteInfo.content = "Mantén tus pensamientos internos y lo que realmente quieres hacer. Las personas que realmente trabajan duro son muy discretas. No en el mundo de los accidentes, no te quejes del status quo de la vida, incluso si no hay halo, sigo trabajando duro todos los días."
      voteInfo.endTime = "09-05 12:35"
      voteInfo.cover = "cover5"
      
      let option1 = VoteOptionItem()
      option1.content = "Siempre hay una calidez y una esperanza infinita en la vida."
      let option2 = VoteOptionItem()
      option2.content = "El reino de la vida, en el análisis final, es el reino del alma."
      let option3 = VoteOptionItem()
      option3.content = "Solo la quietud del alma puede crear la elegancia de la humanidad."
      let option4 = VoteOptionItem()
      option4.content = "Corazón, siempre en silencio."
      voteInfo.voteOptions = [option1, option2, option3, option4]
      voteListInfo.vote = voteInfo
      return voteListInfo
    }
    
    VoteManager.writeVoteInfo(voteInfo: addVoteItem1())
    VoteManager.writeVoteInfo(voteInfo: addVoteItem2())
    VoteManager.writeVoteInfo(voteInfo: addVoteItem3())
    VoteManager.writeVoteInfo(voteInfo: addVoteItem4())
    VoteManager.writeVoteInfo(voteInfo: addVoteItem5())
  }
  
  private func setupMainViewController() {
    window?.rootViewController = TabBarController()
  }
  
//  private func setupJPush(launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
//    JPUSHService.setup(withOption: launchOptions, appKey: AppKey.JPushAPP.key, channel: "App Store", apsForProduction: !AppConfig.isDebug)
//    let entity = JPUSHRegisterEntity()
//    entity.types = 1 << 0 | 1 << 1 | 1 << 2
//    JPUSHService.register(forRemoteNotificationConfig: entity, delegate: self)
//  }
  
  private func setupIQKeyboard() {
    IQKeyboardManager.shared.enable = true
  }
}

//extension AppDelegate: JPUSHRegisterDelegate {
//  @available(iOS 10.0, *)
//  func jpushNotificationCenter(_ center: UNUserNotificationCenter!, openSettingsFor notification: UNNotification?) {
//
//  }
//
//  @available(iOS 10.0, *)
//  func jpushNotificationCenter(_ center: UNUserNotificationCenter!, willPresent notification: UNNotification!, withCompletionHandler completionHandler: ((Int) -> Void)!) {
//    let userInfo = notification.request.content.userInfo
//    if notification.request.trigger is UNPushNotificationTrigger {
//      JPUSHService.handleRemoteNotification(userInfo)
//    }else {
//      //本地通知
//    }
//    print("=======\(userInfo)")
//
//    completionHandler(Int(UNNotificationPresentationOptions.alert.rawValue))
//  }
//
//  @available(iOS 10.0, *)
//  func jpushNotificationCenter(_ center: UNUserNotificationCenter!, didReceive response: UNNotificationResponse!, withCompletionHandler completionHandler: (() -> Void)!) {
//    let userInfo = response.notification.request.content.userInfo
//    if response.notification.request.trigger is UNPushNotificationTrigger {
//      JPUSHService.handleRemoteNotification(userInfo)
//    }else {
//      //本地通知
//    }
//    //处理通知 跳到指定界面等等
//    print("=======\(userInfo)")
//    completionHandler()
//  }
//}
