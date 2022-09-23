# T1PSDK-iOS

T1PSDK-iOS for our partners

## Install the T1P SDK with CocoaPods

- Open your Podfile and add the following lines
```
  platform :ios, '11.0'
  target 'T1PSDK-Demo'  do
     use_frameworks!
     pod 'T1PSDK', :git => 'https://github.com/The1Central/T1PSDK-iOS.git', :tag => '1.2.7'
  end
  ```

- Pod install
## Initialize the T1P SDK
```
let t1p = T1P()
let environment: T1PEnvironment = T1PEnvironment.uat
let redirectURL: String = "" 
let clientId: String = "ClientId"
let language: SDKLanguage = SDKLanguage.English
t1p.shared.initialT1P(environment: environment, redirectUrl: redirectURL, clientId: clientId, language: language)
```

## Integrate the T1P SDK

### Sign-up
```
let signUpVC: UIViewController = t1p.shared.signUp()
present(signUpVC, animated: true, completion: nil)
```

### Sign-in
```
let signInVC: UIViewController = t1p.shared.signIn()
present(signInVC, animated: true, completion: nil)
```

### Sign-out
```
t1p.shared.signOut { _ in
   // Successful
} onFailure: { error in
   // Failure wtih error
}
```

### Account Recovery
```
let accountRecoveryVC: UIViewController = t1p.shared.accountRecovery()
present(accountRecoveryVC, animated: true, completion: nil)
```

### Get Access Token
```
t1p.shared.getAccessToken { token in
   // Successful with token value
} onFailure: { error in
   // Failure wtih error
}
```