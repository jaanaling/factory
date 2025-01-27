class BoxCell {
  final int x;
  final int y;
  bool isBooster;
  String? balloonId;

  BoxCell({
    required this.x,
    required this.y,
    this.isBooster = false,
    this.balloonId,
  });
}

/// Сетка коробки
class BoxGrid {
  final int width;
  final int height;
  late List<BoxCell> cells;

  BoxGrid({required this.width, required this.height}) {
    cells = List.generate(
      width * height,
      (i) => BoxCell(x: i % width, y: i ~/ width),
    );
  }

  BoxCell? cellAt(int x, int y) {
    if (x < 0 || x >= width || y < 0 || y >= height) return null;
    return cells[y * width + x];
  }

  bool canPlace(String balloonId, int startX, int startY, int w, int h) {
    for (int dy = 0; dy < h; dy++) {
      for (int dx = 0; dx < w; dx++) {
        final c = cellAt(startX + dx, startY + dy);
        if (c == null) return false;
        if (c.balloonId != null && c.balloonId != balloonId) return false;
      }
    }
    return true;
  }

  bool place(String balloonId, int startX, int startY, int w, int h) {
    if (!canPlace(balloonId, startX, startY, w, h)) return false;
    for (int dy = 0; dy < h; dy++) {
      for (int dx = 0; dx < w; dx++) {
        cellAt(startX + dx, startY + dy)!.balloonId = balloonId;
      }
    }
    return true;
  }

  void remove(String balloonId) {
    for (final c in cells) {
      if (c.balloonId == balloonId) {
        c.balloonId = null;
      }
    }
  }

  int get filledCellsCount => cells.where((c) => c.balloonId != null).length;
  int get totalCells => width * height;
}