import 'package:flutter/material.dart';
import 'package:x_before_x/theme.dart';

class CheckBoxItem extends StatefulWidget {
  final String? text;
  final bool isChecked;
  final Function(String) onTaskUpdated;
  final Function(bool) onIsChecked;
  const CheckBoxItem({
    super.key,
    this.text = '...',
    required this.onTaskUpdated,
    required this.onIsChecked,
    required this.isChecked,
  });

  @override
  State<CheckBoxItem> createState() => _CheckBoxItemState();
}

class _CheckBoxItemState extends State<CheckBoxItem> {
  late bool isChecked;
  String newTask = '';

  @override
  void initState() {
    super.initState();
    isChecked = widget.isChecked;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CheckboxListTile(
            value: isChecked,
            title: Text(
              widget.text ?? '....',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.titleColor,
                  ),
            ),
            onChanged: (bool? value) {
              setState(() {
                isChecked = value!;
                widget.onIsChecked(isChecked);
              });
            },
          ),
        ),
        PopUpBox(
          style: IconButton.styleFrom(
            backgroundColor: AppColors.appBarColor,
            foregroundColor: AppColors.titleColor,
            shape: CircleBorder(),
            fixedSize: Size(45, 45),
          ),
          title: 'Edit Task',
          buttonText: Icon(Icons.edit),
          hintText: 'Enter task...',
          onSubmit: (value) {
            setState(() {
              newTask = value;
            });
            widget.onTaskUpdated(value);
          },
        ),
      ],
    );
  }
}

class PopUpBox extends StatefulWidget {
  final String title;
  final Widget buttonText;
  final String hintText;
  final Function(String) onSubmit;
  final ButtonStyle? style;
  const PopUpBox({
    super.key,
    required this.title,
    required this.buttonText,
    required this.hintText,
    required this.onSubmit,
    this.style,
  });

  @override
  State<PopUpBox> createState() => _PopUpBoxState();
}

class _PopUpBoxState extends State<PopUpBox> {
  late TextEditingController controller;
  String name = '';

  @override
  void initState() {
    super.initState();

    controller = TextEditingController();
  }

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: widget.style,
      onPressed: () async {
        final name = await openDialog();
        if (name == null || name.isEmpty) return;
        widget.onSubmit(name);
        setState(() {
          this.name = name;
        });
      },
      child: widget.buttonText,
    );
  }

  Future<String?> openDialog() => showDialog<String>(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(widget.title),
          content: TextField(
            autofocus: true,
            decoration: InputDecoration(
              hintText: widget.hintText,
            ),
            controller: controller,
            onSubmitted: (_) => submit(),
          ),
          actions: [
            TextButton(
              onPressed: submit,
              child: Text('SAVE'),
            ),
          ],
        ),
      );

  void submit() {
    Navigator.of(context).pop(controller.text);
    controller.clear();
  }
}

class NavigationButton extends StatelessWidget {
  const NavigationButton({
    super.key,
    required this.text,
    required this.page,
    this.clearStack = false,
  });

  final String text;
  final Widget page;
  final bool clearStack;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 5),
      child: TextButton(
        onPressed: () {
          if (!clearStack) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => page),
            );
          } else {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => page),
                (route) => false);
          }
        },
        child: Text(
          text.toUpperCase(),
        ),
      ),
    );
  }
}

class RoundButton extends StatelessWidget {
  const RoundButton({
    super.key,
    required this.icon,
    required this.page,
  });

  final Icon icon;
  final Widget page;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      style: IconButton.styleFrom(
        backgroundColor: AppColors.appBarColor,
        foregroundColor: AppColors.titleColor,
        shape: CircleBorder(),
        fixedSize: Size(45, 45),
      ),
      icon: icon,
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      },
    );
  }
}

class RippleAnimation extends StatelessWidget {
  final AnimationController controller;
  const RippleAnimation({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return CustomPaint(
          painter: RipplePainter(animationValue: controller.value),
          size: Size(300, 300),
        );
      },
    );
  }
}

class RipplePainter extends CustomPainter {
  final double animationValue;

  RipplePainter({required this.animationValue});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final maxRadius = 100.0;

    for (int i = 0; i < 3; i++) {
      final radius = (animationValue * maxRadius) - (i * 30);
      if (radius > 0) {
        final paint = Paint()
          ..color = AppColors.mainColor
              .withAlpha((255 * (1 - animationValue)).toInt())
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2;
        canvas.drawCircle(center, radius, paint);
      }
    }

    final centerDot = Paint()
      ..color = AppColors.mainColor
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, 15, centerDot);
  }

  @override
  bool shouldRepaint(RipplePainter oldDelegate) => true;
}
