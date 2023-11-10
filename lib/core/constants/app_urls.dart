
class AppUrl{
  static const stagingUrl = 'http://www.boredapi.com/api/';

  static String Function(String activity,) get getActivity=>
          (activity) => 'activity?type=$activity';
}
 
