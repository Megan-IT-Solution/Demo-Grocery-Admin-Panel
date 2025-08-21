import 'package:googleapis_auth/auth_io.dart';

class FcmAccessToken {
  static String firebaseMessagingScope =
      "https://www.googleapis.com/auth/firebase.messaging";

  Future<String> getAccessToken() async {
    final client = await clientViaServiceAccount(
      ServiceAccountCredentials.fromJson({
        "type": "service_account",
        "project_id": "grocery-6c200",
        "private_key_id": "b47851159ea2555902b4420a603062ffe7160116",
        "private_key":
            "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQCVlsfzNkX33Bey\nunCXc6qgw5ZfsRQ6W5g/Pw2bo6xSPkob7u/8oClKzR5sS+ZNtP8HF8W0aSNDbgST\nO8pc4kSJRbgi2a2tO3un2Czeia5X9EfaA8UGmiv0w2mcSBtlyDAkSl11grz7iC/X\n/8ZRMSf9hjnoWsl7cthPcl29Pfpi57Izhzm/SEvTCUhMYULXvYkIrPILUz93G9A7\nfUL3AY+xtkqxVNhpNCh//xsnCIZXrgiQM0BKWBlgN4ff8RBzA5QuAwGwDT0RoVQg\n/oqTmAR7/FLhE6P3jGQrxVKvkLHHnTonxRdXYUy0OZXwi6E8rJlXhRXXuMiigKml\nbITnzP7hAgMBAAECggEAGEF0hx6iDkyJKDE8kAZQoNROJhKV29ed0oWUHIxX5RcW\nF7zw+5bx0x/7Aqb0/10trDYB2BzjO6wTgFdF2zVSVSrxrm77Dzext5fhQK11EGx7\nGSIa2NT3cy8biRyVGrYw/jVzvZn3MFcXIPBntSMiH6Ub7y4HdSW8Zvd9tTGfT9mQ\nD1eca11daW9viJdkRcoqrMLe23adUuFc2hX5OM4UWMLjM3mXVA+SGsMpNtJYyxhy\n/7QHqxWDA/de5Oc+G3gsXUvptqcfgM3KhWQdU9LU8S24z8U2lIqFeL6L/NuFriq0\n/HhGyIlMYPqc8p7VvlIYuLzuFLkIYnOCu+l86PTHxQKBgQDF+bufcwH05Tmr/ZUQ\naWBr/EFgkvK0uR1MTN8xAVOd7iIhZ1muEz6eMBYH7J8vfako2aH32QO0zcTrivs9\nZ+FVmawZQzGokCTAKa5AmHB6mUPSCHVo3mjRhMjV1otI3aMBNPgL+yddT3+gkU6f\nFI+ECStk41fqAlsRkxN9McXadQKBgQDBbpETTzNtm85GOh44oUSGOMmBQvU4LegR\n3dGcEV0kco1KXK+kN1rju5fR0VvgSY5+G7WVevF9BKAuOKOUkpeJkRlEWgXuzzsC\nQiiQqb50/kIBDFCgxs70tfthRdkgDHu3IminlVeS9wUiMTBvx/xX/E06m6nnANjk\nflasb1ANPQKBgAwW3fA0s6/it4zbJVklNjAh7VQaZRvIGhPotdBmRlbkjc0AZKeO\noUpDoXTGbEoYIFZQQ+XAqMtHrXi8ue7cAxSZF7tLMSMb+kKJyQxEwsmZxlxzC8hl\nnHz+4My+Fy9R6XxPYb5JjfPSwPZrKSPpu4HSlYXJpDqz/h+qnYwNmAlpAoGAVUoM\nW+hDM+RMSrjblHq/PTOS3hUJDRFoz1/wSZF6cVS1KgG+THk/8URJB/H5QecNFlvf\ncB66ljZQ7rB4qE0O1lCNRI8xKIBlc3R6cHb4DJwDvHSSpKGkpVAMnHJw72mxrylT\n3fjCmYGj2NS5l8AlayJLZzk17C56dB2k1/lo4b0CgYAT2tO/iVmNPF3qJbKKDOoj\nPLnMNOoi2176S0eo2bWtNPDTJt6+In22fCw7nASHnKMpaiz53b8lgq3JtOnF5b8s\ngy2mrcp+pu7sO+5T3N5M1gqQq1PNMaBHEdLqx0GTwQ0QaMgmArL53/7JdlkZXudZ\n/1RyDok8RG3cKeg3QgPCng==\n-----END PRIVATE KEY-----\n",
        "client_email":
            "firebase-adminsdk-fbsvc@grocery-6c200.iam.gserviceaccount.com",
        "client_id": "106012031366600242026",
        "auth_uri": "https://accounts.google.com/o/oauth2/auth",
        "token_uri": "https://oauth2.googleapis.com/token",
        "auth_provider_x509_cert_url":
            "https://www.googleapis.com/oauth2/v1/certs",
        "client_x509_cert_url":
            "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-fbsvc%40grocery-6c200.iam.gserviceaccount.com",
        "universe_domain": "googleapis.com",
      }),
      [firebaseMessagingScope],
    );
    final accessToken = client.credentials.accessToken.data;
    return accessToken;
  }
}
