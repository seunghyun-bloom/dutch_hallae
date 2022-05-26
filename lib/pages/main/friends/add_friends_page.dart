import 'package:contacts_service/contacts_service.dart';
import 'package:dutch_hallae/pages/main/friends/modal_fit.dart';
import 'package:dutch_hallae/utilities/no_data.dart';
import 'package:dutch_hallae/utilities/styles.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

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
                      onPressed: () => openAppSettings(),
                    ),
                  ),
                )
              : contactsFiltered.isNotEmpty
                  ? Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: contactsFiltered.length,
                        itemBuilder: (context, index) {
                          Contact contact = contactsFiltered[index];
                          return ListTile(
                            title: Text(
                              contact.displayName ?? '',
                              style: const TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 18,
                              ),
                            ),
                            subtitle: Text(
                              contact.phones?.elementAt(0).value ?? '',
                              style: const TextStyle(
                                fontSize: 12,
                              ),
                            ),
                            onTap: () {
                              showCupertinoModalBottomSheet(
                                context: context,
                                builder: (context) => ModalFit(
                                  friend: contact.displayName!,
                                  phone:
                                      contact.phones!.elementAt(0).value ?? '',
                                ),
                              );
                            },
                          );
                        },
                      ),
                    )
                  : _searchController.value.text.isEmpty
                      ? const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Center(
                            child: Text(
                              '친구 이름을 검색해주세요',
                              style: TextStyle(color: Pantone.veryPeri),
                            ),
                          ),
                        )
                      : NoDataSquare(
                          titleString: '연락처 목록에 없어요',
                          contentString:
                              ' ${_searchController.value.text}님을 직접 추가하시겠습니까?',
                          onTap: () {
                            showCupertinoModalBottomSheet(
                              context: context,
                              builder: (context) => ModalFit(
                                friend: _searchController.value.text,
                                phone: '',
                              ),
                            );
                          },
                        ),
        ],
      ),
    );
  }
}
