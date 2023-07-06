import 'package:simple_rest/simple_rest.dart';

@RestController('/school')
class SchoolController {

  @GetMapping(path: '/id/<number>')
  Map<String, dynamic> printSchoolIdWithNumber(@PathVariable('number') dynamic number) {
    return {'name': 'Name School', 'number': number};
  }

  @GetMapping(path: '/apellido/<ape>')
  Map<String, dynamic> printSchoolIdWithName2(@PathVariable('ape') dynamic name) {
    return {'address': 'J 23 Remuerandia', 'apellido': name};
  }

  @GetMapping(path: '/name/<name>')
  Map<String, dynamic> printSchoolIdWithName(@PathVariable('name') dynamic name) {
    return {'address': 'J 23 Remuerandia', 'school': name};
  }

  @PostMapping(path: '/')
  List<Map<String, dynamic>> saveSchool(@BodyAttribute('body') dynamic bodyData) {
    Map<String, dynamic> moreInfo = {
      "school": "san jose"
    };

    var dataSchool = jsonDecode(bodyData );
    return [
      moreInfo,
      dataSchool
    ];
  }

  @DeleteMapping(path: '/id/<id>')
  Map<String, dynamic> deleteSchool(@PathVariable('id') String id){

    List<String> dates = ['jhon','juan','pedro'];
    dates.remove(id);

    return {
      "names": dates
    };
  }

  @PatchMapping(path: '/')
  Map<String, dynamic> updateSchool(@BodyAttribute('body') dynamic body){
    var dataSchool = jsonDecode(body );
    return dataSchool;
  }


  @PutMapping(path: '/')
  Map<String, dynamic> updateSchoolComplete(@BodyAttribute('body') dynamic body){
    var dataSchool = jsonDecode(body );
    return dataSchool;
  }



}
