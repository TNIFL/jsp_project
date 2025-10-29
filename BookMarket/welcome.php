<!doctype html>
<html class="h-100" >
<head>    
    <title>Welcome</title>
    <link href="https://getbootstrap.com/docs/5.3/dist/css/bootstrap.min.css" rel="stylesheet">     
   
   
  </head>
<body class="d-flex flex-column h-100">
   
<?php
   
    require "./menu.php";
?> 

<?php
     $greeting = "도서 쇼핑몰에 오신 것을 환영합니다";
     $tagline = "Welcome to Web Market!";

?>  

<br>
<main>
    <div class="container py-5">
        
<div class="p-5 mb-4 bg-body-tertiary rounded-3">
            <div class="container-fluid py-5">
                <h1 class="display-5 fw-bold"><?php echo $greeting ?></h1>
                <p class="col-md-8 fs-4">BookMarket</p>
            </div>
        </div> 
  <form action = "login.php" method="POST">
        <p><input type = "submit" value = "로그인">
</form>
<form action = "join.php" method="POST">
        <p><input type = "submit" value = "회원가입">
</form>   
<div class="row align-items-md-stretch text-center">
            <div class="col-md-12">
                <div class="h-100 p-5">
                    <h2><?php echo $tagline ?></h2>
                    <?php
                        header("Refresh:5");
                        date_default_timezone_set("Asia/Seoul");
                        echo "현재 접속 일시 : ".date("Y/m/d  H:i:s A");       
                    ?>      
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