<!doctype html>
<html class="h-100" >   
  <title>배송 정보</title>
  <link href="./resources/css/bootstrap.min.css" rel="stylesheet">    
    
    <!-- Custom styles for this template -->
    </head>
  <body class="d-flex flex-column h-100">
  <?php      
    require "./menu.php";
    session_start();
    $cartId = $_GET["cartId"];
  ?>
<br>
 <main>
 <div class="container py-5">
   <div class="p-5 mb-4 bg-body-tertiary rounded-3">
     <div class="container-fluid py-5">
       <h1 class="display-5 fw-bold">배송 정보</h1>
       <p class="col-md-8 fs-4">Shipping Info</p>
      </div>
   </div>
      <div class="row align-items-md-stretch">      
      <div class="col-md-12">
        <div class="h-100 p-5">
        <form name="newBook" action="./processShippingInfo.php" method ="post">			
        <input type="hidden" name="cartId" value="<?=$cartId ?>">
        <div class="mb-3 row">
            <label class="col-sm-2">성명</label>
            <div class="col-sm-3">
                <input type="text" name="name" class="form-control" >
            </div>
        </div>
        <div class="mb-3 row">
            <label class="col-sm-2">배송일</label>
            <div class="col-sm-3">
                <input type="text" name="shippingDate" class="form-control" >(yyyy/mm/dd)
            </div>
        </div>
            <div class="mb-3 row">
            <label class="col-sm-2">국가명</label>
            <div class="col-sm-3">
                <input type="text" name="country" class="form-control" >
            </div>
        </div>
        <div class="mb-3 row">
            <label class="col-sm-2">우편번호</label>
            <div class="col-sm-3">
                <input type="text" name="zipCode" class="form-control">
            </div>
        </div>
        <div class="mb-3 row">
            <label class="col-sm-2">주소</label>
            <div class="col-sm-5">
            <input type="text" name="addressName" class="form-control" >
            </div>
        </div>    
        <div class="mb-3 row">
            <div class="col-sm-offset-2 col-sm-10 ">
                 <a href="./cart.php?cartId=<?=$cartId ?>" class="btn btn-secondary" role="button"> 이전 </a> 
                <input type="submit" class="btn btn-primary" value="등록" >
                <a href="./checkOutCancelled.php" class="btn btn-secondary" role="button"> 취소 </a>
            </div>
        </div>
    </form>
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
