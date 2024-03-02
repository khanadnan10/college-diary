import 'package:college_diary/core/common/widgets/custom_elevated_button.dart';
import 'package:college_diary/core/route_name.dart';
import 'package:college_diary/theme/pallete.dart';
import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';

class InvitationVerification extends StatefulWidget {
  const InvitationVerification({super.key});

  @override
  State<InvitationVerification> createState() => _InvitationVerificationState();
}

class _InvitationVerificationState extends State<InvitationVerification> {
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
          onTap: () => Routemaster.of(context).pop(),
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
              onPressed: () =>
                  Routemaster.of(context).push(RouteName.homeScreen), //! Replace push to replace later
            ),
          ],
        ),
      ),
    );
  }
}
