import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:capturing/models/projectTileLayer.dart';
import 'package:capturing/components/formTitle.dart';
import 'package:capturing/screens/projectTileLayer/projectTileLayer.dart';
import 'package:capturing/components/carouselIndicators.dart';
import 'package:capturing/store.dart';
import 'package:collection/collection.dart';
import 'package:capturing/utils/urlUtils.dart';

class ProjectTileLayerContainer extends StatelessWidget {
  final Isar isar = Get.find<Isar>();
  final String projectId = activeProjectId ?? '';
  final String? id = url.length > 0 ? url[url.length - 1] : null;

  final RxInt bottomBarIndex = 0.obs;
  final activePageIndex = 0.obs;
  final pageHistory = <int>[0].obs;

  @override
  Widget build(BuildContext context) {
    List<ProjectTileLayer> projectTileLayers = isar.projectTileLayers
        .filter()
        .deletedEqualTo(false)
        .and()
        .projectIdEqualTo(projectId)
        .sortByOrd()
        .findAllSync();
    ProjectTileLayer? projectTileLayer =
        projectTileLayers.where((p) => p.id == id).firstOrNull;
    List<String> urlOnEntering = [...url];

    activePageIndex.value = projectTileLayer != null
        ? projectTileLayers.indexWhere((pTL) => pTL.id == projectTileLayer.id)
        : 0;
    final PageController controller =
        PageController(initialPage: activePageIndex.value);

    return WillPopScope(
      // PageView does not navigate using navigator
      // so when user pops, need to use self-built pageHistory
      // and navigate back using that to enable expected experience
      onWillPop: () {
        if (pageHistory.length > 1) {
          pageHistory.removeLast();
          controller.animateToPage(
            pageHistory.last,
            duration: Duration(milliseconds: 500),
            curve: Curves.ease,
          );
          return Future.value(false);
        }
        urlOnEntering.removeLast();
        List<String> newUrl = [...url];
        newUrl.removeLast();
        url.value = newUrl;
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          title: FormTitle(title: projectTileLayer?.getLabel() ?? ''),
          iconTheme: IconThemeData(color: Colors.white),
        ),
        body: Column(
          children: [
            Expanded(
              child: PageView(
                controller: controller,
                children: projectTileLayers
                    .map((f) => ProjectTileLayerWidget(projectTileLayer: f))
                    .toList(),
                onPageChanged: (index) {
                  activePageIndex.value = index;
                  // do not add index if returning to last
                  if (index != pageHistory.lastOrNull) {
                    pageHistory.add(index);
                  }
                  // enable showing same after reload
                  List<String> newUrl = [...url];
                  newUrl.removeLast();
                  newUrl.add(projectTileLayers[index].id);
                  persistUrl(newUrl);
                },
              ),
            ),
            CarrouselIndicators(
              activePageIndex: activePageIndex,
              controller: controller,
              datasets: projectTileLayers,
            ),
          ],
        ),
      ),
    );
  }
}
