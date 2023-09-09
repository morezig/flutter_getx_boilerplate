// id: 1, name: cct-inventory, project_id: 1, inventory: '', ssh_key_id: 1, become_key_id: null, type: static-yaml
class ClusterModel {
  final int id;
  final String name;
  final int projectId;
  final String inventory;
  final int sshKeyId;
  final int becomeKeyId;
  final String type;

  ClusterModel({
    required this.id,
    required this.name,
    required this.projectId,
    required this.inventory,
    required this.sshKeyId,
    required this.becomeKeyId,
    required this.type,
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
        "id": id,
        "name": name,
        "project_id": projectId,
        "inventory": inventory,
        "ssh_key_id": sshKeyId,
        "become_key_id": becomeKeyId,
        "type": type,
      };
}
