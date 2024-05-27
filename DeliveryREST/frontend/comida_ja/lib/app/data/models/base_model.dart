abstract class BaseModel {
  int? id;

  BaseModel fromMap(Map<String, dynamic> map);

  Map<String, dynamic> toMap();

  @override
  bool operator ==(Object other) {
    if (other is! BaseModel) return false;
    if (id != other.id) return false;
    return true;
  }

  @override
  int get hashCode {
    var result = 17;
    result = 37 * result + id.hashCode;
    return result;
  }
}
