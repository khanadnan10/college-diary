import 'package:college_diary/core/common/widgets/custom_elevated_button.dart';
import 'package:college_diary/core/utils.dart';
import 'package:college_diary/features/auth/controller/auth_controller.dart';
import 'package:college_diary/theme/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';

class InvitationVerification extends ConsumerStatefulWidget {
  const InvitationVerification({super.key});

  @override
  ConsumerState<InvitationVerification> createState() =>
      _InvitationVerificationState();
}

class _InvitationVerificationState
    extends ConsumerState<InvitationVerification> {
  final _invitationCode = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _invitationCode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Routemaster.of(context).pop(false),
          child: const Icon(
            Icons.arrow_back,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Text(
              "Verification Code",
              style: TextStyle(fontSize: 24),
            ),
            Text(
              "Are you invited? You must have been provided with an Invitation code.",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Pallete.greyColor.withOpacity(0.5),
              ),
              softWrap: true,
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _invitationCode,
              decoration: const InputDecoration(
                isDense: true,
                hintText: '-   -   -   -   -   -',
                hintStyle: TextStyle(fontSize: 24),
              ),
              maxLength: 6,
              keyboardType: TextInputType.number,
            ),
            const Spacer(),
            CElevatedButton(
              text: 'Verify',
              onPressed: () {
                if (_invitationCode.text.isNotEmpty) {
                  ref
                      .watch(authControllerProvider.notifier)
                      .verifyInvitationCode(
                          invitationCode: _invitationCode.text.trim(),
                          context: context);
                } else {
                  showSnackBar(context, 'Provide a valid invitation code.');
                }
              }, //! Replace push to replace later
            ),
          ],
        ),
      ),
    );
  }
}
