import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';

void main() => runApp(const MyApp());

DateTime initialReferenceDate = DateTime(2023, 6, 24, 9, 05);
DateTime _currentReferenceDate = initialReferenceDate;

DateTime getCurrentReferenceDate(Duration duration) {
  _currentReferenceDate = _currentReferenceDate.subtract(duration);
  return _currentReferenceDate;
}

String remoteUserName = 'Michael Jackson';
Color remoteUserColor = Colors.blueAccent;
//Colors.primaries[Random().nextInt(Colors.primaries.length)];

Duration _scrollDelay = const Duration(seconds: 0);

List<Message> get getOlderMessages => [
      for (int position = 0; position < 3; position++)
        ...[
          Message(
              username: remoteUserName,
              userColor: remoteUserColor,
              date:
                  getCurrentReferenceDate(const Duration(days: 3, seconds: 40)),
              message: 'Yeah sure I have send them per mail',
              isLocalUser: true),
          Message(
            username: remoteUserName,
            userColor: remoteUserColor,
            date: getCurrentReferenceDate(const Duration(seconds: 8)),
            message: 'I dont understand the math questions :(',
          ),
          Message(
              username: remoteUserName,
              userColor: remoteUserColor,
              date: getCurrentReferenceDate(const Duration(minutes: 2)),
              message: 'Can you send me the homework for tomorrow please?'),
          Message(
              username: remoteUserName,
              userColor: remoteUserColor,
              date: getCurrentReferenceDate(const Duration(minutes: 1)),
              message: 'Of course what do you need?',
              isLocalUser: true),
          Message(
              username: remoteUserName,
              userColor: remoteUserColor,
              date: getCurrentReferenceDate(const Duration(minutes: 10)),
              message: 'Hey whats up? Can you help me real quick?'),
          Message(
              username: remoteUserName,
              userColor: remoteUserColor,
              date:
                  getCurrentReferenceDate(const Duration(days: 5, minutes: 2)),
              message: 'Okay see you then :)'),
          Message(
              username: remoteUserName,
              userColor: remoteUserColor,
              date: getCurrentReferenceDate(const Duration(minutes: 6)),
              message: 'Lets meet at 8 o clock',
              isLocalUser: true),
          Message(
              username: remoteUserName,
              userColor: remoteUserColor,
              date: getCurrentReferenceDate(const Duration(minutes: 2)),
              message: 'Yes of course when do we want to meet'),
          Message(
              username: remoteUserName,
              userColor: remoteUserColor,
              date: getCurrentReferenceDate(const Duration(minutes: 3)),
              message: 'Hey you do you wanna go to the cinema?',
              isLocalUser: true),
          Message(
              username: remoteUserName,
              userColor: remoteUserColor,
              date: getCurrentReferenceDate(const Duration(minutes: 10)),
              message: 'I am fine too'),
          Message(
              username: remoteUserName,
              userColor: remoteUserColor,
              date: getCurrentReferenceDate(const Duration(minutes: 10)),
              message: 'Fine and what about you?',
              isLocalUser: true),
          Message(
              username: remoteUserName,
              userColor: remoteUserColor,
              date: getCurrentReferenceDate(const Duration(minutes: 10)),
              message: 'Hello how are you?'),
        ]..sort((a, b) => a.compareTo(b))
    ];

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final List<Message> _messages = getOlderMessages;

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    super.initState();
  }

  void _removeInputTextFocus() {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  Future<bool> _onPageTopScrollFunction() async {
    debugPrint('Fetching new data...');
    await Future.delayed(_scrollDelay);
    setState(() {
      _messages.addAll(getOlderMessages);
    });
    debugPrint('New data fetched!');
    return true;
  }

  @override
  Widget build(BuildContext context) {
    ThemeData currentTheme = Theme.of(context);
    ThemeData remoteUserTheme = currentTheme;
    ThemeData localUserTheme = currentTheme.copyWith(
        textTheme: currentTheme.textTheme.apply(
          bodyColor: Colors.white,
          displayColor: Colors.white60,
        ),
        cardTheme: currentTheme.cardTheme.copyWith(
          color: Colors.blue,
        ));

    const BoxDecoration chatBackgroundDecoration = BoxDecoration(
        gradient:
            LinearGradient(colors: [Color(0xFFe3edff), Color(0xFFcad8fd)]));

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Grouped List Chat Example',
      theme: ThemeData(
          primarySwatch: Colors.blue, canvasColor: Colors.transparent),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Grouped List Chat Example'),
        ),
        body: Builder(
          builder: (context) => Container(
            decoration: chatBackgroundDecoration,
            child: Column(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: _removeInputTextFocus,
                    child: ChatTimeline(
                      messages: _messages,
                      localUserTheme: localUserTheme,
                      remoteUserTheme: remoteUserTheme,
                      onPageTopScrollFunction: _onPageTopScrollFunction,
                    ),
                  ),
                ),
                const FakeMessageTextField()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ChatTimeline extends StatefulWidget {
  const ChatTimeline({
    super.key,
    required this.messages,
    required this.localUserTheme,
    required this.remoteUserTheme,
    this.onPageTopScrollFunction,
  });

  final List<Message> messages;
  final Future<bool> Function()? onPageTopScrollFunction;
  final ThemeData localUserTheme;
  final ThemeData remoteUserTheme;

  @override
  State<ChatTimeline> createState() => _ChatTimelineState();
}

class _ChatTimelineState extends State<ChatTimeline> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _scrollController.addListener(onUserScrolls);
    super.initState();
  }

  bool keepFetchingData = true;
  Completer<bool>? _scrollCompleter;
  Future<void> onUserScrolls() async {
    if (!keepFetchingData) return;
    if (widget.onPageTopScrollFunction == null) return;
    if (!(_scrollCompleter?.isCompleted ?? true)) return;

    double screenSize = MediaQuery.of(context).size.height,
        scrollLimit = _scrollController.position.maxScrollExtent,
        missingScroll = scrollLimit - screenSize,
        scrollLimitActivation = scrollLimit - missingScroll * 0.05;

    if (_scrollController.position.pixels < scrollLimitActivation) return;
    if (!(_scrollCompleter?.isCompleted ?? true)) return;

    _scrollCompleter = Completer();
    keepFetchingData = await widget.onPageTopScrollFunction!();
    _scrollCompleter!.complete(keepFetchingData);
  }

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      controller: _scrollController,
      thumbVisibility: true,
      radius: const Radius.circular(15),
      child: GroupedListView<Message, DateTime>(
        controller: _scrollController,
        elements: widget.messages,
        order: GroupedListOrder.DESC,
        sort: true,
        reverse: true,
        floatingHeader: true,
        useStickyGroupSeparators: true,
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
        groupBy: (Message element) => DateTime(
          element.date.year,
          element.date.month,
          element.date.day,
        ),
        groupHeaderBuilder: (element) => GroupHeaderDate(date: element.date),
        interdependentItemBuilder: (
          context,
          Message? previousElement,
          Message currentElement,
          Message? nextElement,
        ) =>
            Theme(
          data: currentElement.isLocalUser
              ? widget.localUserTheme
              : widget.remoteUserTheme,
          child: MessageBox(
              context: context,
              previousElement: previousElement,
              currentElement: currentElement,
              nextElement: nextElement),
        ),
      ),
    );
  }
}

class FakeMessageTextField extends StatelessWidget {
  const FakeMessageTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ConstrainedBox(
        constraints:
            BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.9),
        child: Theme(
          data: Theme.of(context).copyWith(
              inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: Colors.white,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(24.0),
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(24.0)),
                borderSide: BorderSide(
                    color: Theme.of(context).primaryColor, width: 2)),
            errorBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(24.0)),
                borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.error, width: 2)),
          )),
          child: TextField(
            minLines: 1,
            maxLines: 8,
            decoration: InputDecoration(
              prefixIcon: IconButton(
                onPressed: () {},
                icon: Icon(Icons.camera_alt_outlined,
                    color: Theme.of(context).primaryColor),
              ),
              suffixIcon: IconButton(
                onPressed: () {},
                icon: Icon(Icons.send, color: Theme.of(context).primaryColor),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class GroupHeaderDate extends StatelessWidget {
  final DateTime date;

  const GroupHeaderDate({required this.date, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Align(
        alignment: Alignment.topCenter,
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.blueGrey,
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
          ),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
            child: Text(
              DateFormat.yMMMd().format(date),
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}

class MessageBox extends StatelessWidget {
  const MessageBox({
    super.key,
    required this.context,
    required this.previousElement,
    required this.currentElement,
    required this.nextElement,
  });

  final BuildContext context;
  final Message? previousElement;
  final Message currentElement;
  final Message? nextElement;

  @override
  Widget build(BuildContext context) {
    bool displayUserName = true, displayAvatar = true;

    if (currentElement.isLocalUser) {
      displayUserName = false;
    } else if (nextElement == null) {
      displayUserName = true;
    } else if (DateUtils.dateOnly(currentElement.date) !=
        DateUtils.dateOnly(nextElement!.date)) {
      displayUserName = true;
    } else if (!nextElement!.isLocalUser) {
      displayUserName = false;
    }

    displayAvatar = displayUserName;
    //displayUserName = false;

    return Row(
      mainAxisAlignment: currentElement.isLocalUser
          ? MainAxisAlignment.end
          : MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (displayAvatar)
          Padding(
            padding: const EdgeInsets.only(top: 12.0, left: 8.0),
            child: CircleAvatar(
              radius: 16,
              backgroundColor: currentElement.userColor,
              child: const Icon(Icons.person, color: Colors.white),
            ),
          ),
        if (!displayAvatar) const SizedBox(width: 40),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: currentElement.isLocalUser
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: [
            if (displayUserName)
              Padding(
                padding: const EdgeInsets.only(left: 10.0, top: 10),
                child: Text(
                  '${currentElement.username}:',
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall
                      ?.copyWith(color: currentElement.userColor),
                ),
              ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.76,
              child: Align(
                alignment: currentElement.isLocalUser
                    ? Alignment.centerRight
                    : Alignment.centerLeft,
                child: Card(
                  elevation: 4.0,
                  shadowColor: Colors.black45,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                    bottomLeft: const Radius.circular(18.0),
                    topRight: const Radius.circular(18.0),
                    topLeft:
                        Radius.circular(currentElement.isLocalUser ? 18.0 : 0),
                    bottomRight:
                        Radius.circular(currentElement.isLocalUser ? 0 : 18.0),
                  )),
                  margin: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 4.0),
                  child: Stack(
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 24.0),
                        child: Text(currentElement.message),
                      ),
                      Positioned(
                          bottom: 4,
                          right: 8,
                          child: Text(
                            DateFormat.Hm().format(currentElement.date),
                            style: Theme.of(context).textTheme.bodySmall,
                          ))
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class Message implements Comparable {
  DateTime date;
  Color userColor;
  String username;
  String message;
  bool isLocalUser;

  Message(
      {required this.username,
      required this.userColor,
      required this.date,
      required this.message,
      this.isLocalUser = false});

  @override
  int compareTo(other) {
    return date.compareTo(other.date);
  }
}
