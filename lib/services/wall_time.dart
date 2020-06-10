class DisplaySecs {
  int seconds;

  Duration get duration {
    return Duration(seconds: seconds);
  }

  String get mmss {
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }

  String get hhmmss {
    String twoDigitHours = twoDigits(duration.inHours.remainder(60));
    return "$twoDigitHours:$mmss";
  }

  String twoDigits(int n) {
    if (n >= 10) return "$n";
    return "0$n";
  }

  DisplaySecs(this.seconds);
}

class Stage {
  Map data;
  int secondsPast;

  String get title {
    return data['title'];
  }

  String get summary {
    int secsPast = secondsExpired < 0 ? 0 : secondsExpired;
    if ( secsPast > lengthSecs) secsPast = lengthSecs;
    return "${ DisplaySecs(secsPast).mmss } of ${ DisplaySecs(lengthSecs).mmss }";
  }

  int get totalSecs {
    return data['totalSecs'];
  }

  int get lengthSecs {
    return data['secs'];
  }

  int get secondsExpired {
    return secondsPast - (totalSecs - lengthSecs);
  }

  bool get hasStarted {
    return secondsExpired > 0;
  }

  bool get hasExpired {
    return secondsPast > totalSecs;
  }

  bool get isActive {
    return hasStarted && !hasExpired;
  }

  Stage(this.data, this.secondsPast);

}

class WallTime {
  String name;
  int seconds = 0;
  DateTime startTime;
  List<Map> _stages = [
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

  Stage get current {
    return stages.firstWhere((stage) => stage.hasStarted && !stage.hasExpired, orElse: () => stages.last);
  }

  List<Stage> get stages {
    return _stages.map((stage) {
      return new Stage(stage, seconds);
    }).toList();
  }

  bool get hasFinished {
    return current ==_stages.last && current.hasExpired;
  }

  bool get isNewStage {
    return current.secondsExpired == 0;
  }

  String get countDown {
    return "${ DisplaySecs(seconds).hhmmss } / ${ DisplaySecs(stages.last.totalSecs).hhmmss }";
  }
  
  String get startedAsString {
    return "${startTime.hour.toString()}:${startTime.minute.toString().padLeft(2,'0')}";
  }

  String get durationAsString {
    Duration dur = DateTime.now().difference(startTime);
    return DisplaySecs(dur.inSeconds).hhmmss;
  }

  bool get started {
    return (startTime != null);
  }

  String get summary {
    String started = "";
    String ago = "";
    if(this.started) {
      started = this.startedAsString;
      ago = this.durationAsString;
    }
    return "$started $ago";
  }

  WallTime() { // Initialization code goes here.
    // Calculate each stage totalSecs
    int totalSecs = 0;
    _stages.forEach((stage) {
      totalSecs += stage['secs'];
      stage['totalSecs'] = totalSecs;
     });
  }

  void tick([int secs = 1]) {
    this.seconds += secs;
    if ( startTime == null ) startTime = new DateTime.now();
  }
}