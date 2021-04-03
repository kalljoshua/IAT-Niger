class UserProfile {
    UserProfile({
        this.id,
        this.name,
        this.avatar,
        this.teamName,
        this.teamShortName,
        this.teamPoints,
        this.teamPlayed,
        this.attendance,
    });

    int id;
    String name;
    dynamic avatar;
    String teamName;
    String teamShortName;
    int teamPoints;
    int teamPlayed;
    int attendance;

    factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
        id: json["id"],
        name: json["name"],
        avatar: json["avatar"],
        teamName: json["team_name"],
        teamShortName: json["team_short_name"],
        teamPoints: json["team_points"],
        teamPlayed: json["team_played"],
        attendance: json["attendance"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "avatar": avatar,
        "team_name": teamName,
        "team_short_name": teamShortName,
        "team_points": teamPoints,
        "team_played": teamPlayed,
        "attendance": attendance,
    };
}
