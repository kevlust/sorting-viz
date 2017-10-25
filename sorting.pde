int[] data;
int length = 100;
int comparing, comparisons;
int speed = 10;
int next;
boolean almostSorted = true;
boolean doneSorting = false;
float deviation = 1.00; // keep between 0 (sorted) and 1 (random)

void setup() {
  data = new int[length];
  
  surface.setResizable(true);
  pixelDensity(displayDensity());
  
  initializeData("ranom");
  
  comparing = 1;
  next = 1;
  comparisons = 0;
  
  // speed = x; // 
    
  size(800, 600);
  textFont(createFont("Arial", height / 60 + 4, true));
}

void draw() {
  for (int i = 0; i < speed; i++) {
    insertionSort();
  }
  background(0);
  drawData();
}

boolean bubbleSort() {
  if (comparing >= length) {
    comparing = 1;
  }
  if (data[comparing] < data[comparing - 1]) {
    int temp = data[comparing];
    data[comparing] = data[comparing - 1];
    data[comparing - 1] = temp;
  }
  comparing++;
  comparisons++;
  for(int i = 1; i < length; i++) {
    if (data[i] < data[i - 1]) {
      return false;
    }
  }
  doneSorting = true;
  return true;
}

boolean insertionSort() {
  if (next > length) return true;
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
    return false;
  }
  
  comparing = next;
  next++;
  return true;
}

// Draws elements as vertical bars, adapted to screen size.
//   All elements are colored white, with 2 exceptions:
//     An element that is in its correct index is colored blue
//     An element that is being compared to another is colored red
void drawData() {
  for (int i = 0; i < length; i++) {
    float x = float(i) * width / length;
    float y = height;
    float w = width / length;
    float h = -data[i] * height / length + 1;
    if (i == comparing && !doneSorting) {
      fill(255, 0, 0); // red
    } else if (i + 1 == data[i]) {
      fill(0, 200, 250);
    } else {
      fill(255);
    }
    rect(x, y, w, h);
  }
  fill(255);
  text("Comparisons: " + (comparisons - 1), 20, 20);
}



// Initializers

void initializeData(String mode) {
  if (mode == "random")
    initializeRandom();
  else if (mode == "sorted")
    initializeSorted();
  else if (mode == "reversed")
    initializeReversed();
  else
    println("Data order is not valid. Initialized to random.");
    initializeRandom();
}

void initializeRandom() {
  initializeSorted();
  for (int i = 0; i < length; i++) {
    int random = int(random(length - i - 1)); // random num of decreasing range
    int temp = data[random];
    data[random] = data[length - i - 1];
    data[length - i - 1] = temp;
  }
}

void initializeSorted() {
  data = new int[length];
  for (int i = 0; i < length; i++) {
    data[i] = i + 1;
  }
}

void initializeReversed() {
  data = new int[length];
  for (int i = 0; i < length; i++) {
    data[i] = length - i - 1;
  }
}