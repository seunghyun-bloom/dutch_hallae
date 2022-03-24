import 'package:contacts_service/contacts_service.dart';
import 'package:dutch_hallae/utilities/appbar_button.dart';
import 'package:dutch_hallae/utilities/modal_fit.dart';
import 'package:dutch_hallae/utilities/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

//TODO: 1. 이름 터치하면 bottom up popup 으로 프로필 완성 창 띄우기 (0k)
//TODO: 2. 프로필 완성창에는 이름, 전화번호, 프로필사진 제작 나오게끔  (0k)
//TODO: 검색창에 '누나' 라고 치면 에러가 뜨는 문제 해결 (OK)
//TODO: 3. 프로필 완성창에 imagePicker 로드
//TODO: 4. cloudFirestore 에 data 저장 (getxController 사용)
//TODO: 5. 검색했는데 아무것도 안나오면 직접 추가하기 버튼 나오기
//TODO: 6. FriendsPage에 firestore에 있는 친구 정보 띄우기

class AddFriendsPage extends StatefulWidget {
  const AddFriendsPage({Key? key}) : super(key: key);

  @override
  State<AddFriendsPage> createState() => _AddFriendsPageState();
}

class _AddFriendsPageState extends State<AddFriendsPage> {
  bool contactsPermission = false;
  List<Contact> contacts = [];
  List<Contact> contactsFiltered = [];
  final TextEditingController _searchController = TextEditingController();
  int? selectedIndex;

  @override
  void initState() {
    super.initState();
    _askPermissions();
  }

  Future<void> _askPermissions() async {
    PermissionStatus permissionStatus = await _getContactPermission();
    if (permissionStatus == PermissionStatus.granted) {
      setState(() {
        contactsPermission = true;
      });
      getAllContacts();
    } else {
      setState(() {
        contactsPermission = false;
      });
    }
  }

  Future<PermissionStatus> _getContactPermission() async {
    PermissionStatus permission = await Permission.contacts.status;
    if (permission != PermissionStatus.granted) {
      PermissionStatus permissionStatus = await Permission.contacts.request();
      return permissionStatus;
    } else {
      return permission;
    }
  }

  getAllContacts() async {
    List<Contact> _contacts =
        await ContactsService.getContacts(withThumbnails: false);
    setState(() {
      contacts = _contacts;
    });

    _searchController.addListener(() => filterContacts());
  }

  filterContacts() {
    List<Contact> _contacts = [];
    _contacts.addAll(contacts);
    if (_searchController.text.isNotEmpty) {
      _contacts.retainWhere((contact) {
        String searchTerm = _searchController.text.toLowerCase();
        String contactName = contact.displayName.toString().toLowerCase();
        return contactName.contains(searchTerm);
      });
      setState(() {
        contactsFiltered = _contacts;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('친구추가'),
        actions: [
          AppBarButton(
            title: '추가',
            onTap: () {
              print(contactsFiltered.length);
              print(selectedIndex);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: _searchController,
              decoration: kTextFieldStyle,
            ),
          ),
          !contactsPermission
              ? Expanded(
                  child: Center(
                    child: TextButton(
                      child: const Text('주소록 접근 권한을 활성화해주세요'),
                      onPressed: () => print(contactsPermission),
                    ),
                  ),
                )
              : Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: contactsFiltered.length,
                    itemBuilder: (context, index) {
                      Contact contact = contactsFiltered[index];
                      return ListTile(
                        title: Text(
                          contact.displayName ?? '',
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 18,
                          ),
                        ),
                        subtitle: Text(
                          contact.phones?.elementAt(0).value ?? '',
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                        onTap: () {
                          showCupertinoModalBottomSheet(
                            context: context,
                            builder: (context) => ModalFit(
                              friend: contact.displayName!,
                              number: contact.phones!.elementAt(0).value ?? '',
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
        ],
      ),
    );
  }
}
