import momo_vn




override func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        MoMoPayment.handleOpenUrl(url: url, sourceApp: sourceApplication!)
        return true
    }

override func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any]) -> Bool {
        MoMoPayment.handleOpenUrl(url: url, sourceApp: "MOMO UAT")
        return true
    }

//import Firebase
//
//
//FirebaseApp.configure() //add this before the code below
//GeneratedPluginRegistrant.register(with: self)


