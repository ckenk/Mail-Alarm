import 'package:flutter/foundation.dart';
import 'package:gmail_alarm/model/google_auth_client.dart';
import 'package:gmail_alarm/utils/locator.dart';

import 'package:http/src/client.dart';
import 'package:googleapis/gmail/v1.dart';
import 'package:mockito/annotations.dart';

import 'google_auth_client.dart';


abstract class GmailApiWrapperIF {
  Future<List<Label>> labels();
  Future<Message> messageById(String id);
  Future<List<Message>> messagesByLabels(String labels);
  static const int numResult = 10;
}


class GmailApiWrapper implements GmailApiWrapperIF {
  late GmailApi gmailApi;

  GmailApiWrapper({Client? client})  {
    if(client == null) {
      GoogleAuthClient googleAuthClient = locator<GoogleAuthClient>();
      gmailApi = GmailApi(googleAuthClient);
    } else {
      gmailApi = GmailApi(client);
    }
  }

  Future<List<Label>> labels() async {
    var labels = <Label>[];
    ListLabelsResponse labelsResponse = await gmailApi.users.labels.list('me');
    for (Label label in labelsResponse.labels!) {
      //debugPrint('[gmail_api_wrapper] label: ${label.toJson()}');
      labels.add(label);
    }
    return Future.value(labels);
  }

  Future<List<Message>> messagesByLabels(String labels) async {
    var messages = <Message>[];
    ListMessagesResponse msgs;
    try {
      msgs = await gmailApi.users.messages.list('me', maxResults: GmailApiWrapperIF.numResult, q: '{$labels} is:unread');
      int numMsg = -1;
      if(msgs.messages != null) {
        numMsg = msgs.messages!.length;
        debugPrint('[messagesByLabels]: # ms $numMsg');
        for (Message m in msgs.messages!) {
          messages.add(m);
        }
      }
    } on DetailedApiRequestError catch(e) {
      // DetailedApiRequestError(status: 403, message: Metadata scope does not support 'q' parameter)
      debugPrint('[messagesByLabels]: Error while getting messages by labels. status:${e.status}, message:${e.message}');
      throw e;
    }
    return Future.value(messages);
  }

  Future<Message> messageById(String id) async {
    return gmailApi.users.messages.get('me', id);
  }
}