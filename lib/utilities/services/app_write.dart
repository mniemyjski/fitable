import 'package:appwrite/appwrite.dart';
import 'package:fitable/config/injectable/injection.dart';
import 'package:fitable/constants/paths.dart';
import 'package:injectable/injectable.dart';

abstract class AppWrite {
  Client client = Client();
}

@Environment(Env.prod)
@Injectable(as: AppWrite)
class AppWriteProduction extends AppWrite {
  AppWriteProduction() {
    client
            .setEndpoint(Paths.url_prod()) // Your Appwrite Endpoint
            .setProject(Paths.project_id_prod()) // Your project ID
            .setSelfSigned() // Use only on dev mode with a self-signed SSL cert
        ;
  }
}

@Environment(Env.dev)
@Injectable(as: AppWrite)
class AppWriteDev extends AppWrite {
  AppWriteDev() {
    client
            .setEndpoint(Paths.url_dev()) // Your Appwrite Endpoint
            .setProject(Paths.project_id_dev()) // Your project ID
            .setSelfSigned() // Use only on dev mode with a self-signed SSL cert
        ;
  }
}
