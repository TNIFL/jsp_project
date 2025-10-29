<!DOCTYPE html>
<html lang="en">
<head>
    
    <title>회원 가입</title>
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
                <h1>회원 가입</h1>
            </div>
        </div> 

        <?php
         if ($_SERVER["REQUEST_METHOD"]=="POST"){
            
            $userId = $_POST["id"];
            $userPw = $_POST["passwd"];
            $handle = fopen("join.txt", "w"); 
            $_wjdqh = "$userId | $userPw";
            fwrite($handle, $_wjdqh);
            fclose($handle);
            echo "회원가입을 성공했습니다!";  
          } 
          else{  
              echo "정보를 다시 입력 해주세요!";  
         }
           
          ?>

          <form action = "login.php">
        <p><input type = "submit" value = "로그인 하기">
    </form>
    
<?php     
    require "./footer.php";
?>
</body>
</html>