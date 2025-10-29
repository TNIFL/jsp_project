<?php

function filterBookId($field){   
  $field = filter_var(trim($field));    
 
  if(filter_var($field, FILTER_VALIDATE_REGEXP, array("options"=>array("regexp"=>"/^ISBN[0-9]{4,11}$/")))){
      return $field;
  } else{
      return FALSE;
  }
}    

function filterName($field){

  $field = filter_var(trim($field));    

  if(strlen($field) >= 4 && strlen($field)<= 50){
      return $field;
  } else{
      return FALSE;
  }
}   

function filterPrice($field){       
  if(filter_var(trim($field), FILTER_VALIDATE_INT) || filter_var(trim($field), FILTER_VALIDATE_FLOAT) ){
      return $field;
  } else{
      return FALSE;
  }
}   

function filterPriceFloat($field){     

  $field = filter_var(trim($field));    
 
  if(filter_var($field, FILTER_VALIDATE_REGEXP, array("options"=>array("regexp"=>"/^[\d]*\.?[\d]{0,2}$/")))){
      return $field;
  } else{
      return FALSE;
  }
}   

function filterStock($field){
 
  if(filter_var(trim($field), FILTER_VALIDATE_INT)){
      return $field;
  } else{
      return FALSE;
  }
}   

function filterDescription($field){
     
  $field = filter_var(trim($field));
  if(!empty($field) && strlen($field) >= 80){
      return $field;
  } else{
      return FALSE;
  }
}   

$bookIdErr =  $nameErr = $unitPriceErr = $descriptionErr = $unitsInStockErr = $bookImageErr = "";


if($_SERVER["REQUEST_METHOD"] == "POST"){

  $bookId = $_POST["bookId"];
  $name = $_POST["name"];
  $unitPrice = $_POST["unitPrice"];
  $author = $_POST["author"];
  $description = $_POST["description"];	
  $category = $_POST["category"];
  $unitsInStock = $_POST["unitsInStock"];
  $releaseDate = $_POST["releaseDate"];		 
  $condition = $_POST["condition"];   
  $filename = $_FILES['bookImage']['name'];


  if(empty($bookId)){    
    $bookIdErr  = "도서코드를 입력하세요";
  } else{      
      if(filterBookId($bookId) == FALSE){
          $bookIdErr  = "ISBN과 숫자를 조합하여 5~12자까지 입력하세요";    
      }
  }
   
  if(empty($name )){      
    $nameErr  = "도서명을 입력하세요";
  } else{    
    if(filterName($name ) == FALSE){             
        $nameErr  = "최소 4자에서 최대 50자까지 입력하세요"; 
    }
  }


  if(empty($unitPrice)){       
      $unitPriceErr = "가격을 입력하세요";
  } else{ 
      if(filterPrice($unitPrice) == FALSE){          
        $unitPriceErr =  "숫자만 입력하세요";         
      }
      else if (filterPrice($unitPrice) < 0)   
        $unitPriceErr ="양수를 입력하세요";
      else {      
        if(filterPriceFloat($unitPrice) == FALSE){          
          $unitPriceErr =  "소수점 둘째 자리까지만 입력하세요";         
      }
    }     
  }
  
  if(empty( $unitsInStock)){       
      $unitsInStockErr = "재고수를 입력하세요";
  } else{    
      if(filterStock( $unitsInStock)== FALSE){        
         $unitsInStockErr =  "숫자만 입력하세요";
      }  
  }

 
  if(empty($description)){      
      $descriptionErr = "상세설명을 입력하세요"; 
  } else{    
      if(filterDescription($description) == FALSE){            
          $descriptionErr = "최소 80자이상 입력하세요";
      }
  }  


  if ( empty(  $filename )){
      $bookImageErr = "업로드파일을 입력하세요"; 
  }
 
  
if ($bookIdErr =="" && $nameErr =="" && $unitPriceErr =="" && $descriptionErr =="" && $unitsInStockErr =="" && $bookImageErr =="")
{
  
  $target_path = "resources/images/";  

  $ext = pathinfo($filename, PATHINFO_EXTENSION);
  $filename = $bookId.".".$ext;

  //if(move_uploaded_file($_FILES['bookImage']['tmp_name'], $target_path)) {  
 if ( move_uploaded_file($_FILES["bookImage"]["tmp_name"], $target_path . $filename)){
  // echo "File uploaded successfully!";  
   $handle = fopen("domain.dat", "a"); //파일 열기
    $book_info = "$bookId | $name | $unitPrice | $author | $description | $category | $unitsInStock | $releaseDate | $condition | $filename";
    fwrite($handle, "\n".$book_info);
    fclose($handle);
    Header("Location:books.php"); 

  } else{  
      echo "파일이 업로드되지 않았습니다. 다시 시도해 주세요!";  
  }  
}   
require "./addBook_Error.php";

}
?>
