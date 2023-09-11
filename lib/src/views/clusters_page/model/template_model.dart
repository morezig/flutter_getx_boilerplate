// ID int `db:"id" json:"id"`
// 	ProjectID     int  `db:"project_id" json:"project_id"`
// 	InventoryID   int  `db:"inventory_id" json:"inventory_id"`
// 	RepositoryID  int  `db:"repository_id" json:"repository_id"`
// 	EnvironmentID *int `db:"environment_id" json:"environment_id"`
// 	Name string `db:"name" json:"name"`
// 	Playbook string `db:"playbook" json:"playbook"`

class TemplateModel {
  int? id;
  int? projectId;
  int? inventoryId;
  int? repositoryId;
  int? environmentId;
  String? name;
  String? playbook;

  TemplateModel({
    this.id,
    this.projectId,
    this.inventoryId,
    this.repositoryId,
    this.environmentId,
    this.name,
    this.playbook,
  });

  factory TemplateModel.fromJson(Map<String, dynamic> json) => TemplateModel(
        id: json["id"],
        projectId: json["project_id"],
        inventoryId: json["inventory_id"],
        repositoryId: json["repository_id"],
        environmentId: json["environment_id"],
        name: json["name"],
        playbook: json["playbook"],
      );

  Map<String, dynamic> toJson() => {
        // "id": id,
        "project_id": projectId,
        "inventory_id": inventoryId,
        "repository_id": repositoryId,
        "environment_id": environmentId,
        "name": name,
        "playbook": playbook,
      };
}
