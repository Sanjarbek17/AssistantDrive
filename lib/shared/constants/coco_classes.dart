/// COCO dataset class names (80 classes) used by YOLO models
class CocoClasses {
  static const List<String> classNames = [
    'person', // 0
    'bicycle', // 1
    'car', // 2
    'motorcycle', // 3
    'airplane', // 4
    'bus', // 5
    'train', // 6
    'truck', // 7
    'boat', // 8
    'traffic light', // 9
    'fire hydrant', // 10
    'stop sign', // 11
    'parking meter', // 12
    'bench', // 13
    'bird', // 14
    'cat', // 15
    'dog', // 16
    'horse', // 17
    'sheep', // 18
    'cow', // 19
    'elephant', // 20
    'bear', // 21
    'zebra', // 22
    'giraffe', // 23
    'backpack', // 24
    'umbrella', // 25
    'handbag', // 26
    'tie', // 27
    'suitcase', // 28
    'frisbee', // 29
    'skis', // 30
    'snowboard', // 31
    'sports ball', // 32
    'kite', // 33
    'baseball bat', // 34
    'baseball glove', // 35
    'skateboard', // 36
    'surfboard', // 37
    'tennis racket', // 38
    'bottle', // 39
    'wine glass', // 40
    'cup', // 41
    'fork', // 42
    'knife', // 43
    'spoon', // 44
    'bowl', // 45
    'banana', // 46
    'apple', // 47
    'sandwich', // 48
    'orange', // 49
    'broccoli', // 50
    'carrot', // 51
    'hot dog', // 52
    'pizza', // 53
    'donut', // 54
    'cake', // 55
    'chair', // 56
    'couch', // 57
    'potted plant', // 58
    'bed', // 59
    'dining table', // 60
    'toilet', // 61
    'tv', // 62
    'laptop', // 63
    'mouse', // 64
    'remote', // 65
    'keyboard', // 66
    'cell phone', // 67
    'microwave', // 68
    'oven', // 69
    'toaster', // 70
    'sink', // 71
    'refrigerator', // 72
    'book', // 73
    'clock', // 74
    'vase', // 75
    'scissors', // 76
    'teddy bear', // 77
    'hair drier', // 78
    'toothbrush', // 79
  ];

  /// Get class name by index
  static String getClassName(int classIndex) {
    if (classIndex >= 0 && classIndex < classNames.length) {
      return classNames[classIndex];
    }
    return 'unknown';
  }

  /// Get class index by name
  static int getClassIndex(String className) {
    return classNames.indexOf(className.toLowerCase());
  }

  /// Check if class is relevant for driving assistance
  static bool isDrivingRelevant(int classIndex) {
    const relevantClasses = [
      0, // person
      1, // bicycle
      2, // car
      3, // motorcycle
      5, // bus
      7, // truck
      9, // traffic light
      11, // stop sign
    ];
    return relevantClasses.contains(classIndex);
  }

  /// Get audio key for driving-relevant classes
  static String? getAudioKey(int classIndex) {
    switch (classIndex) {
      case 0: // person
        return 'pedestrian_crossing';
      case 1: // bicycle
        return 'traffic_ahead';
      case 2: // car
        return 'traffic_ahead';
      case 3: // motorcycle
        return 'traffic_ahead';
      case 5: // bus
        return 'traffic_ahead';
      case 7: // truck
        return 'traffic_ahead';
      case 9: // traffic light
        return 'traffic_light_ahead';
      case 11: // stop sign
        return 'stop_sign';
      default:
        return null;
    }
  }

  /// Get priority level for driving assistance (1-5, 5 being highest)
  static int getPriority(int classIndex) {
    switch (classIndex) {
      case 11: // stop sign
        return 5;
      case 9: // traffic light
        return 4;
      case 0: // person
        return 4;
      case 1: // bicycle
      case 3: // motorcycle
        return 3;
      case 2: // car
      case 5: // bus
      case 7: // truck
        return 2;
      default:
        return 1;
    }
  }

  /// Check if detection is urgent (requires immediate attention)
  static bool isUrgent(int classIndex) {
    const urgentClasses = [
      0, // person (pedestrian)
      11, // stop sign
      9, // traffic light
    ];
    return urgentClasses.contains(classIndex);
  }
}
