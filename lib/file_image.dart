import 'dart:io';
import 'package:simple_permissions/simple_permissions.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart';

Future<void> downloadVideo() async {
  PermissionStatus permissionResult = await SimplePermissions.requestPermission(
      Permission.WriteExternalStorage);
  if (permissionResult == PermissionStatus.authorized) {
    try {
      final file=await getApplicationDocumentsDirectory();
      print(file);
      File cfile=new File('${file.path}/dogo.jpg');
      return cfile;
      /* Future fileData=cfile.readAsBytes();
      fileData.then((c)=>print(c)); */
    } 
    catch (e) {
      print(e.toString());
    }
  }
} 