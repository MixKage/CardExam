import 'package:flutter/material.dart';

class CreateCardDialog extends StatefulWidget {
  const CreateCardDialog({Key? key}) : super(key: key);

  @override
  State<CreateCardDialog> createState() => _CreateCardDialogState();
}

class _CreateCardDialogState extends State<CreateCardDialog> {
  late TextEditingController _nameCardController;
  String _textError = '';
  @override
  void initState() {
    _nameCardController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _nameCardController.dispose();
    super.dispose();
  }

  void createCard() {
    if (_nameCardController.text.replaceAll(' ', '') == '') {
      _textError = 'Название карточки пустое';
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) => Container(
        height: 400,
        child: Stack(
          children: [
            Row(
              children: [
                Flexible(
                  child: TextField(
                    controller: _nameCardController,
                    onSubmitted: (value) {
                      createCard();
                    },
                    autofocus: true,
                    decoration: const InputDecoration(
                      hintText: 'Название карточки',
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                      filled: true,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    FocusManager.instance.primaryFocus?.unfocus();
                    createCard();
                  },
                  icon: const Icon(Icons.send),
                )
              ],
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  _textError,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
}
