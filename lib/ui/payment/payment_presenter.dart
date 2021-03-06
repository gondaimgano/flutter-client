import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/app/presenters/entity_presenter.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class PaymentPresenter extends EntityPresenter {
  static List<String> getDefaultTableFields(UserCompanyEntity userCompany) {
    return [
      PaymentFields.paymentNumber,
      PaymentFields.client,
      PaymentFields.amount,
      PaymentFields.invoiceNumber,
      PaymentFields.paymentDate,
      PaymentFields.transactionReference,
      PaymentFields.paymentStatus,
    ];
  }

  static List<String> getAllTableFields(UserCompanyEntity userCompany) {
    return [
      ...getDefaultTableFields(userCompany),
      ...EntityPresenter.getBaseFields(),
      PaymentFields.refunded,
      PaymentFields.privateNotes,
      PaymentFields.exchangeRate,
      PaymentFields.customValue1,
      PaymentFields.customValue2,
      PaymentFields.customValue3,
      PaymentFields.customValue4,
    ];
  }

  @override
  Widget getField({String field, BuildContext context}) {
    //final localization = AppLocalization.of(context);
    final state = StoreProvider.of<AppState>(context).state;
    final payment = entity as PaymentEntity;

    switch (field) {
      case PaymentFields.paymentNumber:
        return Text(payment.number);
      case PaymentFields.invoiceNumber:
        return Text(payment.paymentables
            .map((paymentable) =>
                state.invoiceState.map[paymentable.invoiceId]?.number ?? '')
            .toList()
            .join(', '));
      case PaymentFields.client:
        return Text(
            state.clientState.map[payment.clientId]?.listDisplayName ?? '');
      case PaymentFields.transactionReference:
        return Text(payment.transactionReference);
      case PaymentFields.paymentDate:
        return Text(formatDate(payment.date, context));
      case PaymentFields.amount:
        return Align(
            alignment: Alignment.centerRight,
            child: Text(formatNumber(payment.amount, context,
                clientId: payment.clientId)));
      case PaymentFields.paymentStatus:
        return Text(AppLocalization.of(context)
            .lookup('payment_status_${payment.statusId}'));
      case PaymentFields.customValue1:
        return Text(payment.customValue1);
      case PaymentFields.customValue2:
        return Text(payment.customValue2);
      case PaymentFields.customValue3:
        return Text(payment.customValue3);
      case PaymentFields.customValue4:
        return Text(payment.customValue4);
      case PaymentFields.refunded:
        return Text(formatNumber(payment.refunded, context,
            clientId: payment.clientId));
      case PaymentFields.privateNotes:
        return Text(payment.privateNotes);
      case PaymentFields.exchangeRate:
        return Text(formatNumber(payment.exchangeRate, context,
            formatNumberType: FormatNumberType.percent));
    }

    return super.getField(field: field, context: context);
  }
}
