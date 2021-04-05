
class IspData {
    IspData({
        this.id,
        this.name,
        this.url,
    });

    int id;
    String name;
    String url;

    factory IspData.fromJson(Map<String, dynamic> json) => IspData(
        id: json["id"],
        name: json["name"],
        url: json["url"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "url": url,
    };
}
