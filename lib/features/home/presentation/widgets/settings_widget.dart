import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:web_translator_ml/features/home/presentation/bloc/home_bloc.dart';

class SettingsWidget extends StatelessWidget {
  const SettingsWidget({
    Key? key,
    required this.server,
  }) : super(key: key);

  final TextEditingController server;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.h),
      child: Column(
        children: [
          const Text('Configuración'),
          SizedBox(
            height: 10.h,
          ),
          TextField(
            controller: server,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Dirección del servidor',
              hintText: 'localhost:5000',
            ),
          ),
          SizedBox(
            height: 30.h,
          ),
          SizedBox(
            height: 40.h,
            width: 300.w,
            child: ElevatedButton(
              onPressed: () async {
                final box = await Hive.openBox('settings');
                if (server.text.isNotEmpty) {
                  await box.clear();
                  await box.put('url', server.text);
                  Navigator.pop(context);

                  /// Get Server Status
                  BlocProvider.of<HomeBloc>(context)
                      .add(GetServerStatusEvent());
                }
              },
              child: const Text('Guardar'),
            ),
          )
        ],
      ),
    );
  }
}
