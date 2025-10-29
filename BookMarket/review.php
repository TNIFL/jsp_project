
<!DOCTYPE html>
<html lang="en">
<head>
    
    <title>리뷰 작성</title>
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
                <h1>리뷰 작성</h1>
            </div>
        </div> 
<br>
    <form method = "post" action = "reviewwatch.php">
        <p><textarea name="review" cols ="170" rows="10" placeholder ="책의 리뷰를를 입력해 주세요."></textarea>
        <p><input type ="submit" value ="작성하기">
</form>
<form action = "books.php">
        <p><input type ="submit" value ="취소하기">
</form>
    
<?php     
    require "./footer.php";
?>
</body>
</html>