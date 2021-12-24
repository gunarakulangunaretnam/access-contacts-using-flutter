import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

Map<String, Color> contactsColorMap = new Map();
TextEditingController contactSearchController = new TextEditingController();
bool isGetAllContactsExecuted = false;

List<Contact> contacts = [];
List<Contact> contactsFiltered = [];
final Color fontColor = Color(0xff07B1A1);
final Color buttonColor =
Color(0xff04D3A8); // Define a color for button gradient
final Color primaryColor =
Color(0xff04D3A8); // Define a color for button gradient
final Color secondaryColor =
Color(0xff00B7B2); // Define a color for button gradient



class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {

    return contactScreen();

  }

  Widget contactScreen() {

    bool isSearching = contactSearchController.text.isNotEmpty;
    bool listItemsExist = (contactsFiltered.length > 0 || contacts.length > 0);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Color(0xffF3F0E6),
        elevation: 0,
      ),
      //Scaffold widget will expand or occupy the whole device screen.
      body: Container(
        //Add gradient to background
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xffF3F0E6), Color(0xffFFFFFF)])),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.025,
            ),
            Container(
              height: MediaQuery.of(context).size.height -
                  kToolbarHeight -
                  MediaQuery.of(context).size.height * 0.25,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.05),
                      child: Row(
                        children: [

                        ],
                      ),
                    ),

                    SizedBox(
                        height: MediaQuery.of(context).size.height * 0.0125),
                    listItemsExist == true
                        ? isSearching == true && contactsFiltered.length == 0
                        ? Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.width *
                              0.10),
                    )
                        : ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: isSearching == true
                          ? contactsFiltered.length
                          : contacts.length,
                      itemBuilder: (context, index) {
                        Contact contact = isSearching == true
                            ? contactsFiltered[index]
                            : contacts[index];

                        var baseColor =
                        contactsColorMap[contact.displayName]
                        as dynamic;

                        Color color1 = baseColor;
                        Color color2 = baseColor;
                        return ListTile(
                          visualDensity: VisualDensity(
                              horizontal: 0, vertical: -4),
                          title: Text(contact.displayName.toString()),
                          subtitle: Text(contact.phones!.length > 0
                              ? contact.phones!
                              .elementAt(0)
                              .value
                              .toString()
                              : ''),
                          leading: Container(
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: LinearGradient(
                                      colors: [
                                        color1,
                                        color2,
                                      ],
                                      begin: Alignment.bottomLeft,
                                      end: Alignment.topRight)),
                              child: CircleAvatar(
                                  child: Text(contact.initials(),
                                      style: TextStyle(
                                          color: Colors.white)),
                                  backgroundColor:
                                  Colors.transparent)),
                          trailing: const Text("Hai")
                        );
                      },
                    )
                        : isGetAllContactsExecuted == false
                        ? Center(
                      child: Padding(
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.width *
                                  0.10),
                          child: const Text("Loading...")),
                    )
                        : Center(
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.width *
                                0.10),
                        child: Column(
                          children: [
                            Text('No contacts found',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6),
                            Icon(
                              Icons.warning_amber,
                              size:
                              MediaQuery.of(context).size.width *
                                  0.30,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      bottomSheet: Padding(
          padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).size.height * 0.05)),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
