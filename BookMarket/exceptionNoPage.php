<!doctype html>
<html class="h-100" >   
  <title>페이지 오류</title>
  <link href="./resources/css/bootstrap.min.css" rel="stylesheet">    
    <!-- Custom styles for this template -->
    </head>
  <body class="d-flex flex-column h-100">
  <?php 
    require "./model.php";    
    require "./menu.php";
  ?>
<br>
 <main>
 <div class="container py-5">
   <div class="p-5 mb-4 bg-body-tertiary rounded-3">
     <div class="container-fluid py-5">
       <h1 class="alert alert-danger">요청하신 페이지를 찾을 수 없습니다.</h1>
      
      </div>
   </div>

   <?php
    $http_host = $_SERVER['HTTP_HOST'];
    $request_uri = $_SERVER['REQUEST_URI'];
     $url = 'http://' . $http_host . $request_uri; 
     // Header("Location:exceptionNoBookId.php?url=$url");   
   
   ?>

   <div class="row align-items-md-stretch">        
      <div class = "col-md-12">
        <div class="h-100 p-5">
          <p><?php echo $url; ?>
          <p><a href="books.php" class="btn btn-secondary"> 도서 목록 &raquo;</a>	
         </div>     
      </div>
  </div> 
</div>   
</main>
<?php     
    require "./footer.php";
?>
</body>
</html>
