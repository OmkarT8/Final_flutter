// ignore_for_file: depend_on_referenced_packages, prefer_interpolation_to_compose_strings, avoid_print, use_key_in_widget_constructors, library_private_types_in_public_api, prefer_const_constructors, unused_element, unnecessary_this

//import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:clevertap_plugin/clevertap_plugin.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CleverTap Flutter',
      home: TextFieldDemo(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class TextFieldDemo extends StatefulWidget {
  @override
  _TextFieldDemoState createState() => _TextFieldDemoState();
}

class _TextFieldDemoState extends State<TextFieldDemo> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController identityController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController dob = TextEditingController();

  @override
  void initState() {
    super.initState();
    activateCleverTapFlutterPluginHandlers();
    CleverTapPlugin.setDebugLevel(3);
    CleverTapPlugin.enableDeviceNetworkInfoReporting(true);
    // CleverTapPlugin.initializeInbox();
    var pushPrimerJSON = {
      'inAppType': 'alert',
      'titleText': 'Get Notified',
      'messageText': 'Enable Notification permission',
      'followDeviceOrientation': true,
      'positiveBtnText': 'Allow',
      'negativeBtnText': 'Cancel',
      'fallbackToSettings': true
    };
    CleverTapPlugin.promptPushPrimer(pushPrimerJSON);
    CleverTapPlugin.createNotificationChannel(
        "TAM-RO", "TAM-RO", "TAM-RO", 5, true);
  }

  void activateCleverTapFlutterPluginHandlers() {
    // ignore: no_leading_underscores_for_local_identifiers
    late CleverTapPlugin _clevertapPlugin;
    _clevertapPlugin = CleverTapPlugin();
    _clevertapPlugin.setCleverTapPushClickedPayloadReceivedHandler(
        pushClickedPayloadReceived);
    _clevertapPlugin.setCleverTapInAppNotificationButtonClickedHandler(
        inAppNotificationButtonClicked);
    _clevertapPlugin.setCleverTapInboxDidInitializeHandler(inboxDidInitialize);

    _clevertapPlugin.setCleverTapPushClickedPayloadReceivedHandler(
        pushClickedPayloadReceived);
    _clevertapPlugin.setCleverTapInAppNotificationDismissedHandler(
        inAppNotificationDismissed);
    _clevertapPlugin
        .setCleverTapProfileDidInitializeHandler(profileDidInitialize);
    _clevertapPlugin.setCleverTapProfileSyncHandler(profileDidUpdate);
    _clevertapPlugin.setCleverTapInboxDidInitializeHandler(inboxDidInitialize);
    _clevertapPlugin
        .setCleverTapInboxMessagesDidUpdateHandler(inboxMessagesDidUpdate);

    _clevertapPlugin.setCleverTapInAppNotificationButtonClickedHandler(
        inAppNotificationButtonClicked);
    _clevertapPlugin.setCleverTapInboxNotificationButtonClickedHandler(
        inboxNotificationButtonClicked);
    _clevertapPlugin
        .setCleverTapDisplayUnitsLoadedHandler(onDisplayUnitsLoaded);
  }

  void pushClickedPayloadReceived(Map<String, dynamic> notificationPayload) {
    print("pushClickedPayloadReceived called" + notificationPayload.toString());
  }

  // void inAppNotificationButtonClicked(Map<String, dynamic>? map) {
  //   print("inAppNotificationButtonClicked called = ${map.toString()}");
  // }

  void inboxDidInitialize() {
    this.setState(() {
      print("inboxDidInitialize called");
      var styleConfig = {
        'noMessageTextColor': '#ff6600',
        'noMessageText': 'No message(s) to show.',
        'navBarTitle': 'App Inbox'
      };
      CleverTapPlugin.showInbox(styleConfig);
    });
  }

  void inAppNotificationDismissed(Map<String, dynamic> map) {
    this.setState(() {
      print("inAppNotificationDismissed called");
    });
  }

  void inAppNotificationButtonClicked(Map<String, dynamic>? map) {
    this.setState(() {
      print("inAppNotificationButtonClicked called = ${map.toString()}");
    });
  }

  void inboxNotificationButtonClicked(Map<String, dynamic>? map) {
    this.setState(() {
      print("inboxNotificationButtonClicked called = ${map.toString()}");
    });
  }

  void profileDidInitialize() {
    this.setState(() {
      print("profileDidInitialize called");
    });
  }

  void profileDidUpdate(Map<String, dynamic>? map) {
    this.setState(() {
      print("profileDidUpdate called");
    });
  }

  void inboxMessagesDidUpdate() {
    this.setState(() async {
      print("inboxMessagesDidUpdate called");
      int? unread = await CleverTapPlugin.getInboxMessageUnreadCount();
      int? total = await CleverTapPlugin.getInboxMessageCount();
      print("Unread count = " + unread.toString());
      print("Total count = " + total.toString());
    });
  }

  var nativeTitle = '';
  var nativeSubtitle = '';
  var nativeUrl = '';

  void onDisplayUnitsLoaded(List<dynamic>? displayUnits) {
    this.setState(() async {
      List? displayUnits = await CleverTapPlugin.getAllDisplayUnits();
      print("Display Units Payload = " + displayUnits.toString());

      displayUnits?.forEach((element) {
        var customExtras = element["custom_kv"];
        if (customExtras != null) {
          nativeTitle = customExtras['title'].toString();
          nativeSubtitle = customExtras['subtitle'].toString();
          nativeUrl = customExtras['url'].toString();
          print("Title: " + nativeTitle);
          print("SubTitle: " + nativeSubtitle);
          print("URL: " + nativeUrl);
        }
      });
    });
  }

  // void getAdUnits() {
  //   this.setState(() async {
  //     List? displayUnits = await CleverTapPlugin.getAllDisplayUnits();
  //     print("Display Units Payload = " + displayUnits.toString());
  //     displayUnits?.forEach((element) {
  //       var customExtras = element["title"];
  //       if (customExtras != null) {
  //         print("Display Units CustomExtras: " + customExtras.toString());
  //       }
  //     });
  //   });
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('CleverTap Flutter'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Name',
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: phoneController,
              decoration: const InputDecoration(
                labelText: 'Phone',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Access the entered values
                String name = nameController.text;
                String email = emailController.text;
                String identity = identityController.text;
                String phone = phoneController.text;

                var profile = {
                  'Name': name,
                  'Identity': identity,
                  'Email': email,
                  'Phone': phone,
                  'MSG-push': true,
                };
                CleverTapPlugin.onUserLogin(profile);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
              ),
              child: const Text('Submit'),
            ),
            TextField(
              controller: identityController,
              decoration: const InputDecoration(
                labelText: 'Identity',
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: dob,
              decoration: const InputDecoration(
                labelText: 'Date of Birth(yyyy-mm-dd)',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
                onPressed: () {
                  String identity = identityController.text;
                  String dateofb = dob.text;

                  var profile = {
                    'Identity': identity,
                    // Key always has to be "dob" and format should always be yyyy-MM-dd
                    'dob': CleverTapPlugin.getCleverTapDate(
                        DateTime.parse(dateofb)),
                    'Language': 'English'
                  };
                  CleverTapPlugin.profileSet(profile);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                ),
                child: const Text("Profile Push")),
            ElevatedButton(
                onPressed: () {
                  var values = ["English", "Hindi", "Marathi"];
                  CleverTapPlugin.profileSetMultiValues("Language", values);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                ),
                child: const Text("Set Multi Value")),
            ElevatedButton(
                onPressed: () {
                  var values = ["Marathi"];
                  CleverTapPlugin.profileRemoveMultiValues("Language", values);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                ),
                child: const Text("Remove Multi Value")),
            ElevatedButton(
                onPressed: () {
                  var sports = ["Football", "Cricket"];
                  CleverTapPlugin.profileAddMultiValues("Sports", sports);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                ),
                child: const Text("Add Multi Value")),
            // ElevatedButton(
            //     onPressed: () {
            //       var pushPrimerJSON = {
            //         'inAppType': 'alert',
            //         'titleText': 'Get Notified',
            //         'messageText': 'Enable Notification permission',
            //         'followDeviceOrientation': true,
            //         'positiveBtnText': 'Allow',
            //         'negativeBtnText': 'Cancel',
            //         'fallbackToSettings': true
            //       };
            //       CleverTapPlugin.promptPushPrimer(pushPrimerJSON);
            //     },
            //     style: ElevatedButton.styleFrom(
            //       backgroundColor: Colors.blue,
            //       foregroundColor: Colors.white,
            //     ),
            //     child: const Text("Enable Push")),
            ElevatedButton(
                onPressed: () {
                  CleverTapPlugin.recordEvent("FlutterPush", {});
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                ),
                child: const Text("Flutter Push")),
            ElevatedButton(
                onPressed: () {
                  CleverTapPlugin.recordEvent("FlutterInApp", {});
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                ),
                child: const Text("Flutter In-App")),
            ElevatedButton(
                onPressed: () {
                  CleverTapPlugin.initializeInbox();
                  inboxDidInitialize();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                ),
                child: const Text("App Inbox")),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const EventPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                ),
                child: const Text("Event Page")),
            Container(
                width: double.infinity, // Set width to match the screen width
                padding: EdgeInsets.all(16.0),
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                    Text(
                      'Title: $nativeTitle \nSubtitle: $nativeSubtitle',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    SizedBox(height: 10),
                    Image.network(
                      '$nativeUrl', // Replace with your image URL
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        }
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        );
                      }, // Add some space between text and image
                    )
                  ],
                )),
          ],
        ),
      ),
    );
  }
}

class EventPage extends StatelessWidget {
  const EventPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Event Page'),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(children: <Widget>[
            ElevatedButton(
                onPressed: () {
                  CleverTapPlugin.recordEvent("Product Viewed", {});
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                ),
                child: const Text("Product Viewed")),
            ElevatedButton(
                onPressed: () {
                  var item1 = {
                    // Key:    Value
                    'name': 'Football',
                    'amount': '4000'
                  };
                  var item2 = {
                    // Key:    Value
                    'name': 'Shinpad',
                    'amount': '1900'
                  };
                  var items = [item1, item2];
                  var chargeDetails = {
                    // Key:    Value
                    'total': '5900',
                    'payment': 'card'
                  };
                  CleverTapPlugin.recordChargedEvent(chargeDetails, items);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                ),
                child: const Text("Charged")),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
              ),
              child: const Text('Back to HomePage'),
            ),
          ]),
        ));
  }
}
