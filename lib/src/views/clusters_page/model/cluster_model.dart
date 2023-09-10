// id: 1, name: cct-inventory, project_id: 1, inventory: '', ssh_key_id: 1, become_key_id: null, type: static-yaml
class ClusterModel {
  int? id;
  String? name;
  int? projectId;
  String? inventory;
  int? sshKeyId;
  int? becomeKeyId;
  String? type;

  ClusterModel({
    this.id,
    this.name,
    this.projectId,
    this.inventory,
    this.sshKeyId,
    this.becomeKeyId,
    this.type,
  });

  factory ClusterModel.fromJson(Map<String, dynamic> json) => ClusterModel(
        id: json["id"],
        name: json["name"],
        projectId: json["project_id"],
        inventory: json["inventory"],
        sshKeyId: json["ssh_key_id"],
        becomeKeyId: json["become_key_id"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        // "id": id,
        "name": name,
        "project_id": projectId,
        "inventory": inventory,
        "ssh_key_id": sshKeyId,
        "become_key_id": becomeKeyId,
        "type": type,
      };
}
