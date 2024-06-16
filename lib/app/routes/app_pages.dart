import 'package:get/get.dart';
import 'package:meds_record/app/modules/home/views/admin/homeadmin_screen.dart';
import 'package:meds_record/app/modules/home/views/admin/homeadmin_view.dart';
import 'package:meds_record/app/modules/home/views/admin/patient_view.dart';
import 'package:meds_record/app/modules/home/views/admin/patientdetails2_view.dart';
import 'package:meds_record/app/modules/home/views/admin/patientdetails_view.dart';
import 'package:meds_record/app/modules/home/views/admin/pdf_view.dart';
import 'package:meds_record/app/modules/home/views/admin/request_view.dart';
import 'package:meds_record/app/modules/home/views/admin/settingadmin_screen.dart';
import 'package:meds_record/app/modules/home/views/user/changekey_view.dart';
import 'package:meds_record/app/modules/home/views/user/home_screen.dart';
import 'package:meds_record/app/modules/home/views/user/install_view.dart';
import 'package:meds_record/app/modules/home/views/user/list_details.dart';
import 'package:meds_record/app/modules/home/views/user/login_view.dart';
import 'package:meds_record/app/modules/home/views/user/receive_details.dart';
import 'package:meds_record/app/modules/home/views/user/receive_view.dart';
import 'package:meds_record/app/modules/home/views/user/record_details.dart';
import 'package:meds_record/app/modules/home/views/user/record_screen.dart';
import 'package:meds_record/app/modules/home/views/user/register_view.dart';

import '../modules/home/views/admin/addrecord_view.dart';
import '../modules/home/views/user/home_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(name: '/install', page: () => const InstallView()),
    GetPage(
      name: '/register',
      page: () => const RegisterView(),
    ),
    GetPage(name: '/login', page: () => const LoginView()),
    GetPage(name: '/main', page: () => HomeView()),
    GetPage(name: '/homes', page: () => HomeScreen()),
    GetPage(name: '/record', page: () => RecordScreen()),
    GetPage(name: '/recorddetails', page: () => RecordDetails()),
    GetPage(name: '/receive', page: () => const ReceiveView()),
    GetPage(name: '/receive-details', page: () => ReceiveDetails()),
    GetPage(name: '/list-details', page: () => const ListDetails()),
    GetPage(name: '/changekey', page: () => const ChangeKeyView()),

    // AdminRoutes
    GetPage(name: '/addrecord', page: () => const AddRecordView()),
    GetPage(name: '/viewpdf', page: () => const PdfView()),
    GetPage(name: '/patient', page: () => PatientView()),
    GetPage(name: '/patientdetails', page: () => const PatientDetails()),
    GetPage(name: '/patientdetails2', page: () => PatientDetails2()),
    GetPage(name: '/medrecord', page: () => const PdfView()),
    GetPage(name: '/settingadmin', page: () => SettingScreen()),
    GetPage(name: '/adminhome', page: () => HomeAdminView()),
    GetPage(name: '/adminmain', page: () => HomeAdminScreen()),
    GetPage(name: '/request', page: () => RequestView())
  ];
}
