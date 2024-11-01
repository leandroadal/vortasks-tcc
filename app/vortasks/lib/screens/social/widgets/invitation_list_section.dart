import 'package:flutter/material.dart';

class InvitationListSection extends StatelessWidget {
  final String title;
  final List<dynamic> invites;
  final Widget Function(dynamic invite) itemBuilder;
  final VoidCallback seeMoreAction;

  const InvitationListSection({
    super.key,
    required this.title,
    required this.invites,
    required this.itemBuilder,
    required this.seeMoreAction,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            TextButton(onPressed: seeMoreAction, child: const Text('Ver Mais')),
          ],
        ),
        const SizedBox(height: 8),
        if (invites.isEmpty)
          const Center(child: Text('Nenhum convite.'))
        else
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: invites.length > 3 ? 3 : invites.length,
            itemBuilder: (context, index) => itemBuilder(invites[index]),
          ),
      ],
    );
  }
}
