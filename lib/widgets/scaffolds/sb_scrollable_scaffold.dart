import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mobileapp/theme.dart';

class MBScrollableScaffold extends StatelessWidget {
  const MBScrollableScaffold({
    this.appBar,
    this.header,
    this.defaultPadding = 20,
    this.body,
    this.backgroundImageUrl,
    this.backgroundImage,
    required this.bottomSheet,
  });

  final PreferredSizeWidget? appBar;
  final String? header;
  final Widget? body;
  final Widget? bottomSheet;
  final String? backgroundImageUrl;
  final File? backgroundImage;
  final double defaultPadding;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context),
      child: Container(
        child: Scaffold(
          backgroundColor: Theme.of(context).primaryColor,
          appBar: appBar ?? null,
          body: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minWidth: constraints.maxWidth, minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        if (body != null) ...[
                          body!,
                        ] else ...[
                          if (backgroundImageUrl != null || backgroundImage != null) ...[
                            Container(
                              width: double.infinity,
                              child: backgroundImageUrl != null
                                  ? Image.network(
                                      backgroundImageUrl!,
                                      fit: BoxFit.fill,
                                      loadingBuilder: (_, child, progress) {
                                        if (progress == null) return child;
                                        return Container();
                                      },
                                    )
                                  : Image.file(
                                      backgroundImage!,
                                      fit: BoxFit.fill,
                                    ),
                            ),
                          ] else ...[
                            Expanded(child: Container()),
                          ]
                        ],
                        Container(
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                if (body == null && header != null) ...[
                                  Container(
                                    margin: EdgeInsets.symmetric(
                                      horizontal: XemoTransferTheme.heightScalingPercent(defaultPadding),
                                    ),
                                    child: Text(
                                      header!,
                                      textAlign: TextAlign.left,
                                      maxLines: 5,
                                    ),
                                  ),
                                  SizedBox(
                                    height: XemoTransferTheme.heightScalingPercent(40),
                                  ),
                                ] else
                                  Container(),
                                Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).colorScheme.secondary,
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(16),
                                      topLeft: Radius.circular(16),
                                    ),
                                  ),
                                  child: bottomSheet,
                                  /* TODO: Remove
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      top: verticalPadding,
                                      bottom: verticalPadding,
                                      left: horizontalPadding,
                                      right: horizontalPadding,
                                    ),
                                    child: this.bottomSheet,
                                  ),
                                  */
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
