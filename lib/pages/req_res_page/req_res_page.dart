import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_testing_tutorial/controller/providers/user_change_notifier.dart';
import 'package:provider/provider.dart';

class ReqResPage extends StatefulWidget {
  const ReqResPage({Key? key}) : super(key: key);

  @override
  State<ReqResPage> createState() => _ReqResPageState();
}

class _ReqResPageState extends State<ReqResPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => context.read<UserChangeNotifier>().getUser('1'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<UserChangeNotifier>(
          builder: (context, notifier, child) {
            if (notifier.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return Center(
              child: Column(
                children: [
                  Text(notifier.userModel!.data.firstName! + ' ' + notifier.userModel!.data.lastName!),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(notifier.userModel!.data.email),
                  const SizedBox(
                    height: 8,
                  ),
                  SizedBox(
                      width: 100,
                      height: 100,
                      child: CachedNetworkImage(
                        imageUrl: notifier.userModel!.data.avatar!,
                        progressIndicatorBuilder: (context, url, downloadProgress) => SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(value: downloadProgress.progress),
                        ),
                      )),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
