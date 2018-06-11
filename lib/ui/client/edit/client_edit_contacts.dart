import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:invoiceninja/data/models/models.dart';
import 'package:invoiceninja/ui/app/keyboard_aware_padding.dart';
import 'package:invoiceninja/ui/client/edit/client_edit.dart';
import 'package:invoiceninja/utils/localization.dart';

class ClientEditContacts extends EntityEditor {
  ClientEditContacts(this.client);

  final ClientEntity client;

  static final firstNameKey = (int id) => Key('__contact_${id}_first_name__');
  
  static final GlobalKey<FormFieldState<String>> address1Key =
  GlobalKey<FormFieldState<String>>();

  onSaveClicked(ClientEntity client) {
    if (address1Key.currentState == null) {
      return client;
    }

    if (client == null) {
      return null;
    }

    return client;
    /*
    return client.rebuild((b) => b
      ..postalCode = postalCodeKey.currentState.value.trim());
      */
  }


  @override
  _ClientEditContactsState createState() => new _ClientEditContactsState();
}

class _ClientEditContactsState extends State<ClientEditContacts> with AutomaticKeepAliveClientMixin{

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    var localization = AppLocalization.of(context);
    var client = widget.client;

    return KeyboardAwarePadding(
      child: Card(
        elevation: 2.0,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: ListView(
            children: <Widget>[
              ContactSettings(client.contacts[0]),
            ],
          ),
        ),
      ),
    );
  }
}


class ContactSettings extends StatelessWidget {

  static final GlobalKey<FormFieldState<String>> firstNameKey =
  GlobalKey<FormFieldState<String>>();

  ContactSettings(this.contact);
  ContactEntity contact;

  @override
  Widget build(BuildContext context) {
    var localization = AppLocalization.of(context);

    return Card(
      child: Column(
        children: <Widget>[
               TextFormField(
                autocorrect: false,
                key: ContactSettings.firstNameKey,
                initialValue: contact.firstName,
                decoration: InputDecoration(
                  labelText: localization.website,
                ),
              ),
       ],
      ),
    );
  }
}