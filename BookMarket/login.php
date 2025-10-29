<!DOCTYPE html>
<html lang="en">
<head>
    
    <title>로그인</title>
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
                <h1> 로그인</h1>
            </div>
        </div> 
<br>
    <form action = "login_process.php" method = "POST">
        <p>아 이 디 : <input type="text" name= "id">
        <p>비밀번호 : <input type="password" name = "passwd">
        <p><input type = "submit" value = "로그인">
    </form>
    
<?php     
    require "./footer.php";
?>
</body>
</html>