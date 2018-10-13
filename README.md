# iosdeviceidentifier


## How to identify an iOS device uniquely with identifierForVendor

``Early iOS releases gave every device a unique identifier, but this was soon abused by developers to identify individual users uniquely – something that Apple really dislikes. So, Apple removed the truly unique identifier and instead introduced an identifier for each vendor: a UUID that's the same for all apps for a given developer for each user, but varies between developers and between devices.``

``That is, if a user has five of your apps installed and five of mine, your five will all share the same vendor identifier, and my five will all share the same vendor identifier, but our two identifiers will be different.``

#Here's how to use it:

``if let uuid = UIDevice.current.identifierForVendor?.uuidString {
    print(uuid)
}``


## What different approaches, we are aware and using it in our implementation?
1. Get a unique device ID and store that on the server. Since UDIDs are no longer allowed, that’s out.
    [[UIDevice currentDevice] uniqueIdentifier]
    
2. Use something like the advertising ID. Trouble is, user can reset that and get a new one. Used only for serving advertisement.if you dont have advertising enabled - then cant use it otherwise apple reject it

3. Use something like vendor identifier. Uniquely identifies the device to the app’s vendor. The value changes when user deletes all the vendor’s apps from the device and reinstalls one or more of them.

4. Write a unique ID into the keychain or user preferences. User can delete app, reinstall, and redeem item again.

NSUUID *UUID = [NSUUID UUID];
NSString* stringUUID = [UUID UUIDString];

5. Rely on user login. But then the user can create a dummy account and keep redeeming multiple times.

To get more information you can check http://nshipster.com/uuid-udid-unique-identifier/

## Whats New?

Apple has come up with the DeviceCheck framework in iOS 11.

Access per-device, per-developer data that your associated server can use in its business logic.

Using DeviceCheck API’s, in combination with a server-to-server APIs, developer can set and query two bits of data per device. It will also maintain the user privacy, by not disclosing any user or device information, which is the priority point for every Apple user and most point of concern of every mobile user.

NOTE: Developer are still responsible for keeping track of whether users has already redeemed offers that you have provided.


Link - https://developer.apple.com/documentation/devicecheck?language=objc
