/*
 * Deeply Music
 * Created by Fireduck Technologies as an alias of Bouncyloop Technologies
 * https://bouncyloop.com
 * 
 * Copyright (c) 2020 Bouncyloop Technologies srl. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import 'package:flutter/material.dart';

class NoGlowScrollBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
