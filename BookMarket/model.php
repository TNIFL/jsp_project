<?php
/*
  $BookArray = [
    "ISBN1234" => ["name" => 'HTML5 웹 프로그래밍', "unitPrice" => 29000],
    "ISBN1235" => ["name" => 'JSP 웹 프로그래밍', "unitPrice" => 27000],
    "ISBN1236" => ["name" => '스프링 프레임워크', "unitPrice" => 30000]
  ];

  $BookArray["ISBN1234"]["author"] = "윤인성";
  $BookArray["ISBN1234"]["description"] = "이 책은 웹 프로그래밍을 시작하는 입문자를 위한 실습서입니다. 단계별 예제를 따라 하며 HTML5, CSS3, 자바스크립트의 기초를 익히고 jQuery와 실무에서 쓰이는 다양한 플러그인을 경험할 수 있습니다";
  $BookArray["ISBN1234"]["category"] = "IT모바일";
  $BookArray["ISBN1234"]["unitsInStock"] = 1000;
  $BookArray["ISBN1234"]["releaseDate"] = "2023/08/05";
  $BookArray["ISBN1234"]["condition"] = "N";
  
  $BookArray["ISBN1235"]["author"] = "송미영";
  $BookArray["ISBN1235"]["description"] = "JSP의 이론적 개념 → 기본 실습 → 응용 실습 순의 단계별 학습이 가능합니다. 응용 실습이 합쳐져 최종적으로 쇼핑몰 하나를 완성하는 구성이라 배운 내용이 어디에 어떻게 적용되는지 알 수 있습니다.";
  $BookArray["ISBN1235"]["category"] = "IT모바일";
  $BookArray["ISBN1235"]["unitsInStock"] = 1000;
  $BookArray["ISBN1235"]["releaseDate"] =  "2018/10/08";
  $BookArray["ISBN1235"]["condition"] = "N";

  $BookArray["ISBN1236"]["author"] = "김명호";
  $BookArray["ISBN1236"]["description"] = "스프링 프레임워크의 전체적인 구조와 핵심 이론을 다양한 예제 프로젝트를 통해 배울 수 있습니다. 전자 도서관 시스템의 여러 기능을 구현하며 스프링 MVC의 심화 개념과 실무 기술도 익힐 수 있습니다. ";
  $BookArray["ISBN1236"]["category"] = "IT모바일";
  $BookArray["ISBN1236"]["unitsInStock"] = 1000;
  $BookArray["ISBN1236"]["releaseDate"] = "2023/07/10";
  $BookArray["ISBN1236"]["condition"] = "N";
*/


  $handle = fopen("domain.dat", "r"); //파일 열기

  global $BookArray;
  while(!feof($handle)){ 

  $array =  explode("|", fgets($handle));
  $id = trim($array[0]);
 
  $BookArray[$id]["name"] = trim($array[1]);
  $BookArray[$id]["unitPrice"] = trim($array[2]);
  $BookArray[$id]["author"] = trim($array[3]);
  $BookArray[$id]["description"] = trim($array[4]);
  $BookArray[$id]["category"] = trim($array[5]);
  $BookArray[$id]["unitsInStock"] = trim($array[6]);
  $BookArray[$id]["releaseDate"] =trim($array[7]);
  $BookArray[$id]["condition"] = trim($array[8]);
  $BookArray[$id]["filename"] = trim($array[9]); 
  $BookArray[$id]["quantity"] = trim($array[10]); 
  }

fclose($handle);

 
  function getAllBooks(){
    global    $BookArray;
    return   $BookArray;
  }

  function getBookById($id){
    global    $BookArray, $bookById;   
    for ($i = 0; $i <count($BookArray); $i++) {
      if (array_key_exists($id,   $BookArray)){       
         $bookById =   $BookArray[$id];         
         break;          
       }        
    }     
    return $bookById;
  }
  
  function addBook($bookId, $nbook) {
    global    $BookArray;
    $BookArray[$bookId]["name"] =  $nbook["name"];
    $BookArray[$bookId]["unitPrice"] =  $nbook["unitPrice"];
    $BookArray[$bookId]["author"] =  $nbook["author"];
    $BookArray[$bookId]["description"] =  $nbook["description"];
    $BookArray[$bookId]["category"] =  $nbook["category"];
    $BookArray[$bookId]["unitsInStock"] =  $nbook["unitsInStock"];
    $BookArray[$bookId]["releaseDate"] =  $nbook["releaseDate"];
    $BookArray[$bookId]["condition"] =  $nbook["condition"];
    
  }

?>