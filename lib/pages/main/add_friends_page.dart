import 'package:contacts_service/contacts_service.dart';
import 'package:dutch_hallae/utilities/appbar_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

//TODO: 1. contacts 가 가나다 순으로 보이도록 수정
//TODO: 2. listTile 에서 onTap으로 data 선택해서
//TODO: 3. 완료 버튼 누르면 프로필사진 설정 popup 등장
//TODO: 4. cloudFirestore 에 data 저장 (getxController 사용)

class AddFriendsPage extends StatefulWidget {
  const AddFriendsPage({Key? key}) : super(key: key);

  @override
  State<AddFriendsPage> createState() => _AddFriendsPageState();
}

class _AddFriendsPageState extends State<AddFriendsPage> {
  bool contactsPermission = false;
  List<Contact> contacts = [];
  List<Contact> contactsFiltered = [];
  TextEditingController _searchController = TextEditingController();
  bool _isChecked = false;
  int? selectedIndex;

  @override
  void initState() {
    super.initState();
    _askPermissions();
    getAllContacts();
    _searchController.addListener(() {
      filterContacts();
    });
  }

  Future<void> _askPermissions() async {
    PermissionStatus permissionStatus = await _getContactPermission();
    if (permissionStatus == PermissionStatus.granted) {
      setState(() {
        contactsPermission = true;
      });
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
    bool isSearching = _searchController.text.isNotEmpty;

    return Scaffold(
      appBar: AppBar(
        title: const Text('친구추가'),
        actions: [AppBarButton(title: '완료', onTap: () {})],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: '검색 / 직접 입력',
              ),
            ),
          ),
          !contactsPermission
              ? const Center(
                  child: Text('주소록 접근 권한을 활성화해주세요'),
                )
              : Expanded(
                  child: ListView.builder(
                    itemCount:
                        isSearching ? contactsFiltered.length : contacts.length,
                    itemBuilder: (context, index) {
                      Contact contact = isSearching
                          ? contactsFiltered[index]
                          : contacts[index];
                      return ListTile(
                        title: Text(contact.displayName ?? ''),
                        subtitle:
                            Text(contact.phones?.elementAt(0).value ?? ''),
                        trailing: Checkbox(
                            value: selectedIndex == index ? true : false,
                            onChanged: (value) {
                              setState(() {
                                _isChecked = value!;
                              });
                            }),
                        onTap: () {
                          setState(() {
                            selectedIndex = index;
                          });
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
