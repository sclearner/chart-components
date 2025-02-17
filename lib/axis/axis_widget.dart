import 'package:chart_components/axis/axis_typedef.dart';
import 'package:chart_components/helper/list_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

enum AxisWidgetSlot { line, tick, tickLabel }

class AxisWidget extends RenderObjectWidget {
  final Widget line;
  final List<Widget> ticks;
  final List<Widget> tickLabels;
  const AxisWidget({super.key, required this.line, required this.ticks, required this.tickLabels});
  
  @override
  RenderObjectElement createElement() {
    return AxisElement(this);
  }

    @override
  RenderObject createRenderObject(BuildContext context) {
    // TODO: implement createRenderObject
    throw UnimplementedError();
  }
}

class AxisElement extends RenderObjectElement {
  Element? _line;
  List<Element> _ticks = [];
  List<Element> _tickLabels = [];

  @override
  AxisWidget widget;

  AxisElement(this.widget) : super(widget);

  @override
  void mount(Element? parent, Object? newSlot) {
    super.mount(parent, newSlot);

    _line = inflateWidget(widget.line, AxisWidgetSlot.line);
    _ticks = widget.ticks.mapNotNull((Widget e) => inflateWidget(e, AxisWidgetSlot.tick));
    _tickLabels = widget.tickLabels.mapNotNull((Widget e) => inflateWidget(e, AxisWidgetSlot.tickLabel));
  }

  @override
  void update(AxisWidget newWidget) {
    super.update(newWidget);

    _line = updateChild(_line, newWidget.line, AxisWidgetSlot.line);
    _ticks = updateChildren(_ticks, newWidget.ticks, slots: newWidget.ticks.mapNotNull((e) => AxisWidgetSlot.tick));
    _tickLabels = updateChildren(_tickLabels, newWidget.tickLabels, slots: newWidget.tickLabels.mapNotNull((e) => AxisWidgetSlot.tickLabel));
  }

  @override
  void unmount() {
    super.unmount();

    _line = null;
    _ticks = [];
    _tickLabels = [];
  }

  @override
  AxisRenderBox get renderObject => super.renderObject as AxisRenderBox;
  
  @override
  void insertRenderObjectChild(RenderBox child, AxisWidgetSlot slot) {
    renderObject.insertRenderObjectChild(child, slot);
  }
  
  @override
  void moveRenderObjectChild(RenderBox child, AxisWidgetSlot oldSlot, AxisWidgetSlot newSlot) {
    renderObject.moveRenderObjectChild(child, oldSlot, newSlot);
  }
  
  @override
  void removeRenderObjectChild(RenderBox child, AxisWidgetSlot slot) {
    renderObject.removeRenderObjectChild(child, slot);
  }
}

class AxisRenderBox extends RenderBox {
  RenderBox? _line;
  List<RenderBox> _ticks = [];
  List<RenderBox> _tickLabels = [];

  void insertRenderObjectChild(RenderBox child, AxisWidgetSlot slot) {
    switch (slot) {
      case AxisWidgetSlot.line:
        _line = child;
      case AxisWidgetSlot.tick:
        _ticks.add(child);
      case AxisWidgetSlot.tickLabel:
        _tickLabels.add(child);
    }
    adoptChild(child);
  }

  void moveRenderObjectChild(RenderBox child, AxisWidgetSlot oldSlot, AxisWidgetSlot newSlot) {
    if (oldSlot == newSlot) return;

    switch (oldSlot) {
      case AxisWidgetSlot.line:
        _line = null;
      case AxisWidgetSlot.tick:
        _ticks.remove(child);
      case AxisWidgetSlot.tickLabel:
        _tickLabels.remove(child);
    }

    switch (newSlot) {
      case AxisWidgetSlot.line:
        _line = child;
      case AxisWidgetSlot.tick:
        _ticks.add(child);
      case AxisWidgetSlot.tickLabel:
        _tickLabels.add(child);
    }
  }

  void removeRenderObjectChild(RenderBox child, AxisWidgetSlot slot) {
    switch (slot) {
      case AxisWidgetSlot.line:
        _line = null;
      case AxisWidgetSlot.tick:
        _ticks.remove(child);
      case AxisWidgetSlot.tickLabel:
        _tickLabels.remove(child);
    }
    dropChild(child);
  }
}