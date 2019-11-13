# Airdrop Crazy
> App to display the status of the nearby Apple devices and extract info with Airdrop hack

[![Swift Version][swift-image]][swift-url]
[![License][license-image]][license-url]
[![Platform](https://img.shields.io/cocoapods/p/LFAlertController.svg?style=flat)](http://cocoapods.org/pods/LFAlertController)

This is the companion app of the [Airdrop Crazy Server](https://github.com/ElevenPaths/Airdrop-Crazy) for displaying the information in your phone remotely.

## Features

- [x] Connect to your local server through QR Code
- [x] Display the info of the nearby apple devices in a list of cards
- [x] Display the info gathered by the Airdrop Hack such as phone number, name, carrier...

## Todo

- [] Filter devices
- [] Group devices by owner

## Requirements

- iOS 13.0+
- Xcode 11+

## Configuring the Project

Configuring the Xcode project requires a few steps in Xcode to get up and running with iCloud capabilities. 

1) Configure each Mac and iOS device you plan to test with an iCloud account. Create or use an existing Apple ID account that supports iCloud.

2) Configure the Team for each target within the project.

Open the project in the Project navigator within Xcode and select each of the targets. Set the Team on the General tab to the team associated with your developer account.

3) Change the Bundle Identifier.

With the project's General tab still open, update the Bundle Identifier value. The project's Lister target ships with the value:

com.example.apple-samplecode.Lister

You should modify the reverse DNS portion to match the format that you use:

com.yourdomain.Lister

4) Ensure Automatic is chosen for the Provisioning Profile setting in the Code Signing section of Target > Build Settings

5) Ensure iOS Developer is chosen for the Code Signing Identity setting in the Code Signing section of Target > Build Settings

## Contribute

We would love you for the contribution to **Airdrop Crazy**, check the ``LICENSE`` file for more info.

## Meta

Lucas Fernandez – [@lucferbux](https://twitter.com/lucferbux) – lucas.fernandezaragon@telefonica.com

Distributed under the MIT license. See ``LICENSE`` for more information.

[https://github.com/lucferbux](https://github.com/lucferbux/)

[swift-image]:https://img.shields.io/badge/swift-5.0-orange.svg
[swift-url]: https://swift.org/
[license-image]: https://img.shields.io/badge/License-MIT-blue.svg
[license-url]: LICENSE
