/* import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:sindicatometalurgicos_app/app/core/helpers/shared-preferences.dart';

class DynamicLinkService {
  Future handleDynamicLinks() async {
    final PendingDynamicLinkData data =
        await FirebaseDynamicLinks.instance.getInitialLink();
    _handleDeepLink(data);

    FirebaseDynamicLinks.instance.onLink.listen(
      (PendingDynamicLinkData dynamicLinkData) {
        _handleDeepLink(dynamicLinkData);
      },
      cancelOnError: false,
    ).onError((error) {
      print("Dynamic link failure: ${error.message}");
    });
  }

  void _handleDeepLink(PendingDynamicLinkData data) {
    final Uri deepLink = data?.link;
    print("Handle deeplink $deepLink");
  }

  Future<void> retrieveDynamicLink() async {
    try {
      final PendingDynamicLinkData data =
          await FirebaseDynamicLinks.instance.getInitialLink();
      final Uri deepLink = data?.link;

      if (deepLink.queryParameters.containsKey('id')) {
        String id = deepLink.queryParameters['id'];
        print(id);
        await SharedPreferencesHelper.setClienteIndicacaoId(id);
        return;
      }

      FirebaseDynamicLinks.instance.onLink.listen((dynamicLinkData) async {
        if (dynamicLinkData.link != null) {
          if (dynamicLinkData.link.queryParameters.containsKey('id')) {
            String id = dynamicLinkData.link.queryParameters['id'];
            print(id);
            await SharedPreferencesHelper.setClienteIndicacaoId(id);
          }
        }
      }).onError((error) {
        print(error.message);
      });
    } catch (e) {
      print(e.toString());
    }
  }
}
 */
