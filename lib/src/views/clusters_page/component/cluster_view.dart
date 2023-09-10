import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:yaml/yaml.dart';
import 'package:semaphore_web/src/views/clusters_page/model/cluster_model.dart';

import '../controller/clusters_page_controller.dart';
import 'card_elements.dart';

class ClusterView extends GetView<ClustersPageController> {
  ClusterView({super.key});

  final ClustersPageController clustersPageController = Get.put(ClustersPageController());

  @override
  Widget build(BuildContext context) {
    var arguments = Get.arguments;
    ClusterModel cluster = arguments[0]['cluster'] as ClusterModel;
    // getNodesFromClusterData(cluster);
    // print('cluster name:${cluster.name}');
    return Scaffold(
      appBar: AppBar(
        title: cluster.id == 0 ? const Text('Cluster Add') : Text('Cluster ${cluster.id}'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          buttonActions('Actions', cluster),
          buttonContents('Nodes', () {}, getNodesFromClusterData(cluster)),
          // buttonContents('Vars', () {}, getVarsFromClusterData(cluster)),
          buttonContents('Users', () {}, getPgUsersFromClusterData(cluster)),
          buttonContents('Backup', () {}, getPgBackupFromClusterData(cluster)),
          buttonContents('Keys', () {}, []),
        ],
      ),
    );
  }

  DecoratedBox getDecoratedBox(String showTitle, Function func) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 1.0, vertical: 1.0),
        child: ElevatedButton(
          onPressed: func(),
          child: Text(showTitle),
        ),
      ),
    );
  }

  List<Widget> getNodesFromClusterData(ClusterModel cluster) {
    List<Widget> ret = <Widget>[];
    if (cluster.inventory != null) {
      var doc = loadYaml(cluster.inventory!);
      var hosts = doc['all']['children'][cluster.name]['hosts'];
      print("[getNodesFromClusterData]:chkvs:${hosts}");
      if (hosts is YamlMap) {
        print("[getNodesFromClusterData]:is YamlMap");
        for (var item in hosts.entries) {
          ret.add(getDecoratedBox(item.key, () {}));
        }
      } else if (hosts is YamlList) {
        print("[getNodesFromClusterData]:is YamlList");
        for (var host in hosts) {
          for (var item in host.entries) {
            ret.add(getDecoratedBox(item.key, () {}));
          }
        }
      }
    }

    return ret;
  }

  List<Widget> getPgUsersFromClusterData(ClusterModel cluster) {
    List<Widget> ret = <Widget>[];
    if (cluster.inventory != null) {
      var doc = loadYaml(cluster.inventory!);
      print("[getPgUsersFromClusterData]:doc:${doc}");
      var chkvs = doc['all']['children'][cluster.name]['vars']['pg_users'];
      print("[getPgUsersFromClusterData]:chkvs:${chkvs}");
      if (chkvs is YamlMap) {
        print("[getPgUsersFromClusterData]:is YamlMap");
        for (var item in chkvs.entries) {
          if (item.key == "name") {
            ret.add(getDecoratedBox(item.value, () {}));
          }
        }
      } else if (chkvs is YamlList) {
        print("[getPgUsersFromClusterData]:is YamlList");
        for (var chkv in chkvs) {
          for (var item in chkv.entries) {
            if (item.key == "name") {
              ret.add(getDecoratedBox(item.value, () {}));
            }
          }
        }
      }
    }

    return ret;
  }

  List<Widget> getPgBackupFromClusterData(ClusterModel cluster) {
    List<Widget> ret = <Widget>[];
    if (cluster.inventory != null) {
      var doc = loadYaml(cluster.inventory!);
      print("[getVarsFromClusterData]:doc:${doc}");
      var chkvs = doc['all']['children'][cluster.name]['vars']['node_crontab'];
      print("[getVarsFromClusterData]:chkvs:${chkvs}");
      if (chkvs is YamlMap) {
        print("[getVarsFromClusterData]:is YamlMap");
        // for (var item in chkvs.entries) {
        //   if (item.key == showKey) {
        //     ret.add(getDecoratedBox(item.value, () {}));
        //   }
        // }
      } else if (chkvs is YamlList) {
        print("[getVarsFromClusterData]:is YamlList");
        print("[getVarsFromClusterData]:is YamlList: ${chkvs[0]}");
        // ret.add(getDecoratedBox('${chkvs[0]} ${chkvs[1]} ${chkvs[2]} ${chkvs[3]} ${chkvs[4]})', () {}));
        for (var chkv in chkvs) {
          final splChkv = chkv.split(' ');
          ret.add(getDecoratedBox('${splChkv[0]} ${splChkv[1]} ${splChkv[2]} ${splChkv[3]} ${splChkv[4]} (${splChkv[splChkv.length - 1]}))', () {}));
        }
      }
    }

    return ret;
  }

  List<Widget> getVarsFromClusterData(ClusterModel cluster, String chkVar, String showKey) {
    List<Widget> ret = <Widget>[];
    if (cluster.inventory != null) {
      var doc = loadYaml(cluster.inventory!);
      print("[getVarsFromClusterData]:doc:${doc}");
      var chkvs = doc['all']['children'][cluster.name]['vars'][chkVar];
      print("[getVarsFromClusterData]:chkvs:${chkvs}");
      if (chkvs is YamlMap) {
        print("[getVarsFromClusterData]:is YamlMap");
        for (var item in chkvs.entries) {
          if (item.key == showKey) {
            ret.add(getDecoratedBox(item.value, () {}));
          }
        }
      } else if (chkvs is YamlList) {
        print("[getVarsFromClusterData]:is YamlList");
        for (var chkv in chkvs) {
          for (var item in chkv.entries) {
            if (item.key == showKey) {
              ret.add(getDecoratedBox(item.value, () {}));
            }
          }
        }
      }
    }

    return ret;
  }

  Widget buttonContents(String title, Function addBtnFunc, List<Widget> ws) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Text(title),
              trailing: FittedBox(
                child: TextButton.icon(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.green[800],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                    ),
                  ),
                  icon: Icon(Icons.add_circle, color: Colors.green),
                  label: Text("Add", style: TextStyle(color: Colors.green)),
                  onPressed: addBtnFunc(),
                ),
              ),
            ),
            Visibility(
              visible: true,
              child: const Divider(
                height: 1.0,
                thickness: 1.0,
              ),
            ),
            CardBody(
              padding: const EdgeInsets.all(16.0),
              child: FormBuilder(
                autovalidateMode: AutovalidateMode.disabled,
                child: Wrap(
                  spacing: 8.0, // 主轴(水平)方向间距
                  runSpacing: 8.0, // 纵轴（垂直）方向间距
                  alignment: WrapAlignment.start,
                  children: ws,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buttonActions(String title, ClusterModel cluster) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CardHeader(
              padding: const EdgeInsets.all(8.0),
              title: title,
            ),
            CardBody(
              padding: const EdgeInsets.all(16.0),
              child: FormBuilder(
                autovalidateMode: AutovalidateMode.disabled,
                child: Wrap(
                  spacing: 8.0, // 主轴(水平)方向间距
                  runSpacing: 8.0, // 纵轴（垂直）方向间距
                  alignment: WrapAlignment.start,
                  children: <Widget>[
                    DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3.0), //3像素圆角
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                          ),
                          //themeData.extension<AppButtonTheme>()!.infoElevated,
                          onPressed: () async {
                            /*
                              1. gen Inventory content
                              2. add access key (then get return sshKeyId)
                                # clustersPageController.addAccessKey(cluster, pkey);
                              3. add Inventory (then get return InventoryId)
                                # clustersPageController.addInventory(cluster);
                              4. add templates (node.yml, etcd.yml, ces.yml)
                                # clustersPageController.addTemplate(cluster, node);
                                # clustersPageController.addTemplate(cluster, etcd);
                                # clustersPageController.addTemplate(cluster, ces);
                              5. prepare full inventory file for cmdb
                              6. call inventory_load
                             */

                            await clustersPageController.addAccessKey(cluster, "whatever");
                            int accKeyId = await clustersPageController.getAccessKey(cluster);
                            print('accKeyId:$accKeyId');
                            cluster.sshKeyId = accKeyId;
                            ClusterModel newInv = await clustersPageController.addInventory(cluster);
                            await clustersPageController.addTemplate(newInv, "node");
                            await clustersPageController.addTemplate(newInv, "etcd");
                            await clustersPageController.addTemplate(newInv, "ces");
                          },
                          child: Text('Save'),
                        ),
                      ),
                    ),
                    DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3.0), //3像素圆角
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                          ),
                          //themeData.extension<AppButtonTheme>()!.infoElevated,
                          onPressed: () async {},
                          child: Text('Install Env'),
                        ),
                      ),
                    ),
                    DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3.0), //3像素圆角
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                          ),
                          //themeData.extension<AppButtonTheme>()!.infoElevated,
                          onPressed: () async {},
                          child: Text('switchover'),
                        ),
                      ),
                    ),
                    DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3.0), //3像素圆角
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                          ),
                          //themeData.extension<AppButtonTheme>()!.infoElevated,
                          onPressed: () async {},
                          child: Text('failover'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
