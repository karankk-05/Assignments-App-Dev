// import 'dart:convert';
// import 'package:http/http.dart' as http;

// class Post{
//     int userId;
//     int id;
//     String title;
//     String body;
//     Post(this.userId,this.id,this.title,this.body);
    
//   }

// void main() async {
//   final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));

  
//     final data = json.decode(response.body);
//     List<Post> fakedata =[];
 
//   for(var a in data){
//    fakedata.add( Post(a['userId'],a['id'],a['title'],a['body']));
//   }
//   for(Post fdata in fakedata){
//     if(fdata.userId == 1)
//     {
//       print('Post ID : ${fdata.id}\nTitle : ${fdata.title}\nBody : ${fdata.body}\n\n');
//     }
//   }
  



// }