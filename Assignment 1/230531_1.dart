import 'dart:io';

void main(){
stdout.write("Enter the text string: ");
var input =stdin.readLineSync();


//Calculating Characters
  if (input != null) {
  List<String> Listc = input.split('');
  
  var x=Listc.length;
  print("Characters: $x");
  

 //Calculating Words 
   int wordcount=0;
  for(String word in input.toLowerCase().split(' ')){
  
  if (input.contains(word)) {
      wordcount++;
    };
}
  print("Words: $wordcount");



//Calculating Sentences
  int count2=0;
  for(int i=0;i<x;i++){
    if (Listc[i]=="."){
        count2++;
    }
    else if (Listc[i]=="?"){
        count2++;
    }
  
    else continue;
  }

  int z =count2;
  print("Sentences: $z");
  
  
//Calculating Articles
  List<String> articles = ["a", "an", "the"];
  int articleCount = 0;

  for (String word in input.toLowerCase().split(' ')) {
    if (articles.contains(word)) {
      articleCount++;
    }
  }

  print("Articles: $articleCount");
  
  }
 else {
    print("Null String.");
  }
}
