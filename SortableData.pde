class SortableData {
  int[] data;
  private int len, speed;
  private int comparing, comparisons, next;
  private boolean isDoneSorting;
  private color normal, accessing, inPlace;
  
  public SortableData(int len) {
    data = new int[len];
    this.len = len;
    sort();
    shuffle();
    normal = color(255);
    accessing = color(255, 0, 0);
    inPlace = color(0, 200, 250);
    textFont(createFont("Helvetica", height / 60 + 4, true));
    
    comparing = 1;
    next = 1;
    comparisons = 0;
    
    isDoneSorting = false;
  }
  
  //// Draws elements as vertical bars, adapted to screen size.
  ////   All elements are colored white, with 2 exceptions:
  ////   - An element that is in its correct index is colored blue
  ////   - An element that is being compared to another is colored red
  void drawData() {
    for (int i = 0; i < len; i++) {
      float x = float(i) * width / len;
      float y = height;
      float w = width / len;
      float h = -data[i] * (height - 25) / len + 1;
      
      if (i == comparing && !isDoneSorting) {
        fill(accessing);
      } else if (i + 1 == data[i]) {
        fill(inPlace);
      } else {
        fill(normal);
      }
      rect(x, y, w, h);
    }
    
    drawLabels();
  }
  
  void drawLabels() {
    pushStyle();
    
    fill(255);
    text("Data size: " + len, 20, 20);
    text("Comparisons: " + (comparisons - 1), 120, 20);
    
    popStyle();
  }

  // Randomizes the order of the data
  void shuffle() {
    for (int i = 0; i < len; i++) {
      int random = int(random(len - i - 1)); // random num of decreasing range
      int temp = data[random];
      data[random] = data[len - i - 1];
      data[len - i - 1] = temp;
    }
  }
  
  // Resets the data's order
  void sort() {
    for (int i = 0; i < len; i++) {
      data[i] = i + 1;
    }
  }
  
  // Sets the data to be reversed
  void reverse() {
    for (int i = 0; i < len; i++) {
      data[i] = len - i;
    }
  }
  
  void setSpeed(int speed) {
    this.speed = speed;
  }
  
  void setLength(int len) {
    this.len = len;
  }
  
  
  // Implements a single step (comparison/swap) of bubble sort
  void bubbleSort() {
    if (comparing >= len) {
      comparing = 1;
    }
    if (data[comparing] < data[comparing - 1]) {
      int temp = data[comparing];
      data[comparing] = data[comparing - 1];
      data[comparing - 1] = temp;
    }
    comparing++;
    comparisons++;
    for(int i = 1; i < len; i++) {
      if (data[i] < data[i - 1]) {
        return;
      }
    }
    isDoneSorting = true;
    comparing = 1;
    next = 1;
  }
  
  // Implements a single step (comparison/swap) of insertion sort
  void insertionSort() {
    if (next > len) {
      isDoneSorting = true;
      comparing = 1;
      next = 1;
      return;
    }
    
    if (comparing > 0) {
      if (data[comparing] < data[comparing - 1]) {
        int temp = data[comparing];
        data[comparing] = data[comparing - 1];
        data[comparing - 1] = temp;
        comparing--;
      } else {
        comparing = next;
        next++;
      }
      comparisons++;
      return;
    }
    
    comparing = next;
    next++;
  }
  
  public boolean isDoneSorting() {
    return isDoneSorting;
  }
}