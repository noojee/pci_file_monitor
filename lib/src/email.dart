import 'package:dcli/dcli.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:pci_file_monitor/src/log.dart';
import 'package:pci_file_monitor/src/rules.dart';

// yes I know this is duplicated from node, but it needs to be here for the backup_service build to work

void main() {
  log('you cant run this!');
}

class Email {
  static void sendEmail(
      String subject, String body, String emailToAddress) async {
    final rules = Rules.load();

    final emailServer = rules.emailServer;
    final emailPort = rules.emailPort;
    final emailFromAddress = rules.emailFromAddress;

    if (emailFromAddress.isEmpty) {
      throw EmailException(
          'You must configure the emailFromaddress in rules.yaml');
    }

    final smtpServer = SmtpServer(emailServer,
        port: emailPort, allowInsecure: true, ignoreBadCertificate: true);

    // Create our message.
    final message = Message()
      ..from = Address(emailFromAddress)
      ..recipients.add(emailToAddress)
      ..subject = subject
      ..text = body;
    //..html = "<h1>Test</h1>\n<p>Hey! Here's some HTML content</p>";

    try {
      final sendReport = waitForEx(send(message, smtpServer));
      log('Message sent: ' + sendReport.toString());
    } on MailerException catch (e) {
      log('Message not sent. $e');
      for (var p in e.problems) {
        log('Problem: ${p.code}: ${p.msg}');
      }
    }
  }
}

class EmailException implements Exception {
  EmailException(this.message);
  String message;
}
