<!DOCTYPE html>
<html lang="en">
<head>
    
    <title>리뷰 확인</title>
     <link href="https://getbootstrap.com/docs/5.3/dist/css/bootstrap.min.css" rel="stylesheet">     
</head>
<body>
    <?php
   
    require "./menu.php";
?> 
 <div class="container py-5">
        
<div class="p-5 mb-4 bg-body-tertiary rounded-3">
            <div class="container-fluid py-5">
                <p class="col-md-8 fs-4">BookMarket</p>
                <h1>리뷰 확인</h1>
            </div>
        </div> 
<br>
<?php 
if ($_SERVER["REQUEST_METHOD"]=="POST"){
        echo $_POST["review"];
    }
?>
<br>
    <form action = "review.php">
        <p><input type = "submit" value = "돌아가기">
    </form>
<?php     
    require "./footer.php";
?>
</body>
</html>