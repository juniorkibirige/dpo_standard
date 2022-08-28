
<p align="center">  
   <img title="Flutterwave" height="200" src="https://portal.dpopay.com/system/new-design/images/dpoaf.svg" width="50%"/>
</p>  

# DPO Flutter SDK (Standard)

The Flutter library helps you create seamless payment experiences in your dart mobile app. By connecting to the DPO modal, you can start collecting payment in no time.


Available features include:

- Collections: Card, Mobile money.
- Split payments


## Table of Contents

1. [Requirements](#requirements)
2. [Installation](#installation)
3. [Usage](#usage)
4. [Support](#support)
5. [Contribution guidelines](#contribution-guidelines)
6. [License](#license)


## Requirements

1. [Sign Up](https://dpogroup.com/instant-signup/)
2. Supported Flutter version >= 1.17.0


## Installation

1. Add the dependency to your project. In your `pubspec.yaml` file add: `dpo_standard: 1.0.0`
2. Run `flutter pub get`


## Usage

### Initializing a Flutterwave instance

To create an instance, you should call the DPO constructor. This constructor accepts a mandatory instance of the following:

- The calling `Context`
- `paymentUrl`

It returns an instance of Flutterwave which we then call the async method `.charge()` on.

    _handlePaymentInitialization() async { 
    final style = DPOStyle(
     appBarText: "DPO Pay", 
     buttonColor: Color(0xffd0ebff), 
     appBarIcon: Icon(Icons.message, color: Color(0xffd0ebff)),
     buttonTextStyle: TextStyle( 
	     color: Colors.black, 
	     fontWeight: FontWeight.bold, 
	     fontSize: 18), 
    appBarColor: Color(0xffd0ebff), 
    dialogCancelTextStyle: TextStyle(
	    color: Colors.redAccent, 
	    fontSize: 18
	    ),
    dialogContinueTextStyle: TextStyle(
		    color: Colors.blue, 
		    fontSize: 18
		    ) 
		  );  
		    
    final DPO dpo = DPO(
      context: context,
      style: style,
      isTestMode: false,
      paymentUrl: this.urlController.text,
    ); 
		} 

### Handling the response

Calling the `.charge()` method returns a Future of `ChargeResponse` which we await for the actual response as seen above.



     final ChargeResponse response = await flutterwave.charge(); 
     if (response != null) { 
	     print(response.toJson()); 
		 if(response.success) { 
		 Call the verify transaction endpoint with the transactionID returned in `response.TransID` to verify transaction before offering value to customer 
		 } else { 
		  // Transaction not successful 
		} 
	 } else {
	  // User cancelled 
	 }

#### Note

 1. `ChargeResponse` can be null if a user cancels the transaction by pressing back.
 2. You need to confirm the transaction is succesful. Ensure that the txRef, amount, and status are correct and successful. Be sure to verify the transaction details before providing value.


## Support

For additional assistance using this library, contact the developer experience (DX) team via [email](mailto:lkibirige@asanty.africa).


## Contribution guidelines

Read more about our community contribution guidelines [here](/CONTRIBUTING).


## License

By contributing to the Flutter library, you agree that your contributions will be licensed under its [MIT license](/LICENSE).

Copyright (c) Junior Lawrence Kibirige Inc.


## Built Using

- [flutter](https://flutter.dev/)
- [http](https://pub.dev/packages/http)
- [flutter_inappwebview](https://pub.dev/packages/flutter_inappwebview)
- [fluttertoast](https://pub.dev/packages/fluttertoast)
