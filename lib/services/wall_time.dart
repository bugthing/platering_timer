
class WallTime {
  String name;
  int seconds = 0;
  List<Map> stages = [
    {
      "title": "Applying Plaster",
      //"secs": 1800
      "secs": 2
    },
    {
      "title": "Flattening 1st Coat",
      //"secs": 600
      "secs": 2
    },
    {
      "title": "Clean Tools and Mix New Plaster",
      "secs": 600
    },
    {
      "title": "Applying 2nd Coat",
      "secs": 1800
    },
    {
      "title": "Clean Bucket",
      "secs": 300
    },
    {
      "title": "Closing In",
      "secs": 1500
    },
    {
      "title": "First Trowel",
      "secs": 1800
    },
    {
      "title": "2nd Trowel",
      "secs": 1800
    },
    {
      "title": "Wet Trowel",
      "secs": 1200
    },
    {
      "title": "Dry Trowel",
      "secs": 900
    },
  ];
  
  WallTime() { // Initialization code goes here.

    // Calculate each stage totalSecs
    int totalSecs = 0;
    stages.forEach((stage) {
      totalSecs += stage['secs'];
      stage['totalSecs'] = totalSecs;
     });
  }

  void tick([int secs = 1]) {
    this.seconds += secs;
  }

  bool isFinished() {
    return current() == stages.last && current()['totalSecs'] < this.seconds;
  }

  bool isNewStage() {
    return this.seconds > 0 && current()['totalSecs'] == this.seconds;
  }

  Map current() {
    return stages.firstWhere((stage) => stage['totalSecs'] >= this.seconds, orElse: () => stages.last);
  }

  String currentTitle() {
    return current()['title'];
  }

  String title() {
    return "$seconds - ${ currentTitle() }";
  }
}