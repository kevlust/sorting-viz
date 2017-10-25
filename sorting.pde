SortableData data;

void setup() {
  // Display
  size(800, 600);
  pixelDensity(displayDensity());
  surface.setResizable(true);
  
  data = new SortableData(100);
}

void draw() {
  if (!data.isDoneSorting())
      data.selectionSort();
  background(0);
  data.drawData();
}