import '../my_classes/statusrequest.dart';

handlingData(response){
  if(response is StatusRequest){
    return response;
  }
  else {
    return StatusRequest.success;
  }
}