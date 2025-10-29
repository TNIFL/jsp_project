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
                <h1>로그인</h1>
            </div>
        </div> 

        

    <?php 
       if ($_SERVER["REQUEST_METHOD"]=="POST"){
            $user_id =$_POST["id"];
            $user_pw =$_POST["passwd"];

            $_wjdqh = "$user_id | $user_pw";
            $handle =fopen("join.txt","r");
            $file = fread($handle,filesize("join.txt"));
            
            if ($_wjdqh == $file){
                echo "로그인 성공!";

            }
            else{
                echo "로그인 실패";
            }
            fclose($handle);
        }
       
       ?>
          <form action = "welcome.php">
        <p><input type = "submit" value = "홈으로 돌아가기">
    </form>
    
<?php     
    require "./footer.php";
?>

</body>
</html>